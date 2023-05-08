import '_token.dart';
import 'parser_exception.dart';

class Tokenizer {
  Tokenizer(String program, {this.trace = false}) {
    _chars.addAll(program.runes.map((r) => String.fromCharCode(r)));
    _length = _chars.length;
  }

  final bool trace;

  final _chars = <String>[];
  late final int _length;

  String operator [](int idx) =>
      (0 <= idx && idx < _length) ? _chars[idx] : '\u0000';

  bool _isNewLine = true;

  int _skipWhiteSpaces(int pos) {
    _isNewLine = false;
    while (pos < _length && _whitespaces.contains(this[pos])) {
      if (_newLine.contains(this[pos])) {
        _isNewLine = true;
      }
      pos++;
    }
    return pos;
  }

  int _skipSingleLineComment(int pos) {
    pos += 2;
    while (pos < _length && !_newLine.contains(this[pos])) {
      pos++;
    }
    return pos;
  }

  int _skipMultiLineComment(int pos) {
    pos += 2;
    while (pos < _length) {
      if (this[pos] == '*' && this[pos + 1] == '/') {
        pos += 2;
        break;
      } else {
        pos++;
      }
    }
    return pos;
  }

  int _skipDigits(int pos, Set<String> digits) {
    var ok = false, start = pos;
    while (pos < _length && (this[pos] == '_' || digits.contains(this[pos]))) {
      ok |= (this[pos] != '_');
      pos++;
    }
    return ok ? pos : start;
  }

  _NumberResult _skipNumber(int pos) {
    var p = pos;
    if (this[p] == '0' && _hexMarks.contains(this[p + 1])) {
      var idx = _skipDigits(p + 2, _hexDigits);
      if (idx == p + 2) {
        throw InvalidTokenException('Malformed hexadecimal number (pos=$pos).');
      }
      return _NumberResult(TokenType.integer, idx);
    } else if (this[p] == '0' && _octMarks.contains(this[p + 1])) {
      var idx = _skipDigits(p + 2, _octDigits);
      if (idx == p + 2) {
        throw InvalidTokenException('Malformed octal number (pos=$pos).');
      }
      return _NumberResult(TokenType.integer, idx);
    } else if (this[p] == '0' && _binMarks.contains(this[p + 1])) {
      var idx = _skipDigits(p + 3, _binDigits);
      if (idx == p + 2) {
        throw InvalidTokenException('Malformed binary number (pos=$pos).');
      }
      return _NumberResult(TokenType.integer, idx);
    }
    var type = TokenType.integer;
    p = _skipDigits(p, _digits);
    if (this[p] == '.') {
      type = TokenType.real;
      p = _skipDigits(p + 1, _digits);
    }
    if (_expMarks.contains(this[p])) {
      type = TokenType.real;
      var start = p + (_signs.contains(this[p + 1]) ? 2 : 1);
      var idx = _skipDigits(start, _digits);
      if (idx == start) {
        throw InvalidTokenException('Malformed exponent (pos=$pos).');
      }
      p = idx;
    }
    // check suffix
    var end = p;
    while (_whitespaces.contains(this[p])) {
      p++;
    }
    if (this[p] == 'i' && this[p + 1] == 'm') {
      // imaginary
      type = TokenType.imaginary;
      p += 2;
    } else if (type == TokenType.integer) {
      if (this[p] == 's') {
        // duration (seconds)
        type = TokenType.duration;
        p += 1;
      } else if (const {'n', 'µ', 'u', 'm'}.contains(this[p]) &&
          this[p + 1] == 's') {
        // other duration
        type = TokenType.duration;
        p += 2;
      } else if (this[p] == 'd' && this[p + 1] == 't') {
        // "dt"
        type = TokenType.duration;
        p += 2;
      } else {
        p = end;
      }
    } else {
      p = end;
    }
    return _NumberResult(type, p);
  }

  int _skipString(int pos) {
    var quote = this[pos];
    var p = pos + 1;
    while (p < _length) {
      var ch = this[p];
      if (ch == '\\') {
        p += 2;
      } else if (ch == quote) {
        p++;
        // end of string
        return p;
      } else {
        p++;
      }
    }
    throw InvalidTokenException('Malformed string (pos=$pos).');
  }

  int _skipOperator(int pos) {
    if (const {'<', '>', '*'}.contains(this[pos]) &&
        this[pos + 1] == this[pos]) {
      // **, **=, >>, >>=, <<, <<=
      return pos + ((this[pos + 2] == '=') ? 3 : 2);
    } else if (const {
          '<',
          '>',
          '=',
          '!',
          '+',
          '-',
          '*',
          '/',
          '%',
          '^',
          '|',
          '&',
          '~'
        }.contains(this[pos]) &&
        this[pos + 1] == '=') {
      // <=, >=, ==, !=, +=, -=, *=, /=, %=, ^=, |=, &=, ~=
      return pos + 2;
    } else if (this[pos] == '-' && this[pos + 1] == '>') {
      // ->
      return pos + 2;
    } else if (const {'|', '&', '+'}.contains(this[pos]) &&
        this[pos + 1] == this[pos]) {
      // <<, >>, ||, &&, ++
      return pos + 2;
    } else {
      // single character operator
      return pos + 1;
    }
  }

  int _skipIdentifier(int pos) {
    var p = pos;
    while (p < _length) {
      var ch = this[p];
      if (_delimitors.contains(ch)) {
        // end of identifier
        return p;
      }
      p++;
    }
    return p;
  }

  Token _token(int start, int end, TokenType type) =>
      Token(start, end, _chars.sublist(start, end).join(), type);

  Iterable<Token> _readTokens() sync* {
    var pos = _skipWhiteSpaces(0), idx = 0, ch = '';
    _isNewLine = true;
    while (pos < _length) {
      idx = pos;
      ch = this[pos];
      if (_whitespaces.contains(ch)) {
        // skip whitespaces
        pos = _skipWhiteSpaces(pos);
        continue;
      } else if (_isNewLine && ch == '@') {
        while (idx < _length && !_newLine.contains(this[idx])) {
          idx++;
        }
        yield _token(pos, idx, TokenType.annotation);
      } else if (ch == '/' && this[pos + 1] == '/') {
        // single-line comment
        idx = _skipSingleLineComment(pos);
        yield _token(pos, idx, TokenType.comment);
      } else if (ch == '/' && this[pos + 1] == '*') {
        // multi-line comment
        idx = _skipMultiLineComment(pos);
        yield _token(pos, idx, TokenType.comment);
      } else if (_digits.contains(ch) ||
          (ch == '.' && _digits.contains(this[pos + 1]))) {
        // number literal
        final res = _skipNumber(pos);
        yield _token(pos, res.end, res.type);
        idx = res.end;
      } else if (_quotes.contains(ch)) {
        // string literal
        idx = _skipString(pos);
        yield _token(pos, idx, TokenType.string);
      } else if (_operators.contains(ch)) {
        // operator
        idx = _skipOperator(pos);
        yield _token(pos, idx, TokenType.operator);
      } else if (_separators.contains(ch)) {
        // separator
        idx = pos + 1;
        yield _token(pos, idx, TokenType.separator);
      } else {
        // identifier
        idx = _skipIdentifier(pos);
        final token = _token(pos, idx, TokenType.identifier);
        if (_isNewLine &&
            const {Keywords.$$pragma, Keywords.$pragma}.contains(token.text)) {
          while (idx < _length && !_newLine.contains(this[idx])) {
            idx++;
          }
          yield _token(pos, idx, TokenType.pragma);
        } else {
          yield token;
        }
      }
      pos = idx;
      _isNewLine = false;
    }
  }

  Iterable<Token> get tokens sync* {
    for (var token in _readTokens()) {
      var t = token;
      if (t.type == TokenType.identifier) {
        if (_keywords.contains(t.text)) {
          t = t.withType(TokenType.keyword);
        } else if (Constants.all.contains(t.text)) {
          t = t.withType(TokenType.constant);
        }
      } else if (t.type == TokenType.operator && t.text == '->') {
        t = t.withType(TokenType.separator);
      }
      if (trace) {
        print('${t.start}: [${t.type}] ${t.text}');
      }
      yield t;
    }
  }

  static const _newLine = {
    '\f',
    '\n',
    '\r',
    '\v',
    '\u0085',
    '\u2028',
    '\u2029'
  };
  static const _whitespaces = {
    ..._newLine,
    ' ',
    '\t',
    '\u00A0',
    '\u1680',
    '\u2000',
    '\u2001',
    '\u2002',
    '\u2003',
    '\u2004',
    '\u2005',
    '\u2006',
    '\u2007',
    '\u2008',
    '\u2009',
    '\u200A',
    '\u202F',
    '\u205F',
    '\u3000'
  };
  static const _quotes = {'\'', '"'};
  static const _operators = {
    '+',
    '-',
    '*',
    '/',
    '%',
    '&',
    '|',
    '^',
    '~',
    '!',
    '=',
    '<',
    '>'
  };
  static const _separators = {
    '(',
    ')',
    '[',
    ']',
    '{',
    '}',
    ',',
    ':',
    ';',
    '@',
  };

  static const _signs = {'+', '-'};
  static const _digits = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
  static const _expMarks = {'E', 'e'};
  static const _hexMarks = {'X', 'x'};
  static const _hexDigits = {
    ..._digits,
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'a',
    'b',
    'c',
    'd',
    'e',
    'f'
  };
  static const _octMarks = {'O', 'o'};
  static const _octDigits = {'0', '1', '2', '3', '4', '5', '6', '7'};
  static const _binMarks = {'B', 'b'};
  static const _binDigits = {'0', '1'};

  static const _delimitors = {
    ..._whitespaces,
    ..._quotes,
    ..._operators,
    ..._separators,
  };

  static const _keywords = {
    ...Keywords.all,
    ...ReservedKeywords.all,
    ...Types.all,
    ...BuiltIn.all,
    ...BuiltInFunctions.all,
  };
}

abstract class Constants {
  static const $true = 'true';
  static const $false = 'false';
  static const $pi = 'pi';
  static const $$pi = 'π';
  static const $tau = 'tau';
  static const $$tau = 'τ';
  static const $euler = 'euler';
  static const $$euler = 'ℇ';

  static const all = {$true, $false, $pi, $$pi, $tau, $$tau, $euler, $$euler};
}

abstract class Keywords {
  static const $openqasm = 'OPENQASM';
  static const $include = 'include';
  static const $pragma = 'pragma';
  static const $$pragma = '#pragma';
  static const $box = 'box';
  static const $def = 'def';
  static const $cal = 'cal';
  static const $defcal = 'defcal';
  static const $gate = 'gate';
  static const $extern = 'extern';
  static const $let = 'let';
  static const $if = 'if';
  static const $else = 'else';
  static const $while = 'while';
  static const $for = 'for';
  static const $in = 'in';
  static const $continue = 'continue';
  static const $break = 'break';
  static const $end = 'end';
  static const $return = 'return';

  static const all = {
    $openqasm,
    $include,
    $pragma,
    $$pragma,
    $box,
    $def,
    $cal,
    $defcal,
    $gate,
    $extern,
    $let,
    $if,
    $else,
    $while,
    $for,
    $in,
    $continue,
    $break,
    $end,
    $return
  };
}

abstract class ReservedKeywords {
  static const $switch = 'switch';
  static const $case = 'case';
  static const $default = 'default';
  static const $void = 'void';

  static const all = {$switch, $case, $default, $void};
}

abstract class Types {
  static const $input = 'input';
  static const $output = 'output';
  static const $const = 'const';
  static const $readonly = 'readonly';
  static const $mutable = 'mutable';
  static const $qreg = 'qreg';
  static const $qubit = 'qubit';
  static const $creg = 'creg';
  static const $bool = 'bool';
  static const $bit = 'bit';
  static const $int = 'int';
  static const $uint = 'uint';
  static const $float = 'float';
  static const $angle = 'angle';
  static const $complex = 'complex';
  static const $array = 'array';
  static const $duration = 'duration';
  static const $stretch = 'stretch';
  static const $string = 'string';

  static const all = {
    $input,
    $output,
    $const,
    $readonly,
    $mutable,
    $qreg,
    $qubit,
    $creg,
    $bool,
    $bit,
    $int,
    $uint,
    $float,
    $angle,
    $complex,
    $array,
    $duration,
    $stretch,
    $string,
  };
}

abstract class BuiltIn {
  static const $gphase = 'gphase';
  static const $inv = 'inv';
  static const $ctrl = 'ctrl';
  static const $negCtrl = 'negctrl';
  static const $dim = '#dim';
  static const $durationOf = 'durationof';
  static const $delay = 'delay';
  static const $reset = 'reset';
  static const $measure = 'measure';
  static const $barrier = 'barrier';

  static const all = {
    $gphase,
    $inv,
    $ctrl,
    $negCtrl,
    $dim,
    $durationOf,
    $delay,
    $reset,
    $measure,
    $barrier
  };
}

abstract class BuiltInFunctions {
  static const $arccos = 'arccos';
  static const $arcsin = 'arcsin';
  static const $arctan = 'arctan';
  static const $ceiling = 'ceiling';
  static const $cos = 'cos';
  static const $exp = 'exp';
  static const $floor = 'floor';
  static const $log = 'log';
  static const $mod = 'mod';
  static const $popcount = 'popcount';
  static const $pow = 'pow'; // also a gate modifier
  static const $rotl = 'rotl';
  static const $rotr = 'rotr';
  static const $sin = 'sin';
  static const $sqrt = 'sqrt';
  static const $tan = 'tan';

  static const all = {
    $arccos,
    $arcsin,
    $arctan,
    $ceiling,
    $cos,
    $exp,
    $floor,
    $log,
    $mod,
    $popcount,
    $pow,
    $rotl,
    $rotr,
    $sin,
    $sqrt,
    $tan,
  };
}

class _NumberResult {
  _NumberResult(this.type, this.end);

  final TokenType type;
  final int end;
}
