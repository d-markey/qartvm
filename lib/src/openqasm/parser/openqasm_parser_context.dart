import '../_token.dart';
import '../_tokenizer.dart';
import '../ast/ast_node.dart';
import '../parser_exception.dart';

part 'openqasm_parser_context.declarations.dart';
part 'openqasm_parser_context.expressions.dart';
part 'openqasm_parser_context.statements.dart';

class OpenQAsmParserContext {
  OpenQAsmParserContext(String code, this.trace) {
    _tokens.addAll(Tokenizer(code, trace: trace).tokens);
    _length = _tokens.length;
  }

  final bool trace;

  final _tokens = <Token>[];
  Token _token = Token.nil;
  int _length = 0;
  int _pos = -1;

  final _commentsStack = <List<Token>>[<Token>[]];
  late List<Token> _comments = _commentsStack[0];
  final _annotationsStack = <List<Token>>[<Token>[]];
  late List<Token> _annotations = _annotationsStack[0];
  final _bookmarks = <int>[];
  final _callers = <String>[];

  Iterable<AstStatement> get statements sync* {
    _next();
    AstStatement? stmt;
    final annotations = <Token>[];
    while (_pos < _length) {
      annotations.clear();
      stmt = null;
      if (_token.type == TokenType.pragma) {
        stmt = AstPragma();
        stmt.tokens.add(_consume());
      } else {
        while (_token.type == TokenType.annotation) {
          annotations.add(_consume());
        }
        final decl = _parseDeclaration();
        if (decl != null && _token.text == ';') {
          stmt = AstStatementDeclaration(decl);
          stmt.tokens.add(_consume());
        } else {
          final def = _parseDefinition();
          if (def != null) {
            stmt = AstStatementDefinition(def);
          } else {
            stmt = _parseStatement();
          }
        }
      }
      if (stmt == null) {
        throw SyntaxException('Statement expected.');
      }
      stmt.annotations.addAll(annotations);
      yield stmt;
    }
    if (_bookmarks.isNotEmpty) {
      throw SyntaxException('Internal error.');
    }
  }

  Iterable<Token> get comments sync* {
    while (_comments.isNotEmpty) {
      final comment = _comments.removeAt(0);
      yield comment;
    }
  }

  Iterable<Token> get annotations sync* {
    while (_annotations.isNotEmpty) {
      final annotation = _annotations.removeAt(0);
      yield annotation;
    }
  }

  AstDesignator? _parseDesignator() {
    if (_token.text != '[') {
      return null;
    }
    _bookmark();
    final open = _consume();
    final expr = _parseNonAssignmentExpression();
    final close = _consume();
    if (expr == null || close.text != ']') {
      return _rollback();
    }
    final designator = AstDesignator(expr);
    designator.tokens.add(open);
    designator.tokens.add(close);
    return _commit(designator);
  }

  void _bookmark() {
    if (trace) {
      final caller = _caller();
      _callers.add(caller);
      print('[$caller]   ${_bookmarks.join(' ')} ($_pos) ${_token.text}');
    }
    _bookmarks.add(_pos);
    _comments = <Token>[];
    _commentsStack.add(_comments);
    _annotations = <Token>[];
    _annotationsStack.add(_annotations);
  }

  T _commit<T extends AstNode>(T node) {
    if (trace) {
      final caller = _caller();
      final c = _callers.removeLast();
      if (c != caller) {
        throw Exception('Caller mismatch: commit from $caller instead of $c');
      }
      print(
          '[$caller] = ${_bookmarks.join(' ')} [${node.runtimeType}] ${node.asText()}');
    }
    final lastComments = _commentsStack.removeLast();
    _comments = _commentsStack.last;
    _comments.addAll(lastComments);
    final lastAnnotations = _annotationsStack.removeLast();
    _annotations = _annotationsStack.last;
    _annotations.addAll(lastAnnotations);
    _bookmarks.removeLast();
    return node;
  }

  T? _rollback<T extends AstNode>() {
    _pos = _bookmarks.removeLast();
    _token = _tokens[_pos];
    if (trace) {
      final caller = _caller();
      final c = _callers.removeLast();
      if (c != caller) {
        throw Exception('Caller mismatch: rollback from $caller instead of $c');
      }
      print('[$caller] ! ${_bookmarks.join(' ')} ($_pos) ${_token.text}');
    }
    _commentsStack.removeLast();
    _comments = _commentsStack.last;
    _annotationsStack.removeLast();
    _annotations = _annotationsStack.last;
    return null;
  }

  bool _next() {
    if (_pos < _length) {
      _pos++;
    }
    while (_pos < _length) {
      var t = _tokens[_pos];
      if (t.type == TokenType.comment) {
        // do not emit comments
        _comments.add(t);
        _pos++;
      } else {
        _token = t;
        return true;
      }
    }
    _token = Token.nil;
    return false;
  }

  Token _peek([int ahead = 1]) {
    var p = _pos;
    while (ahead > 0) {
      p++;
      if (p >= _length) {
        break;
      }
      if (_tokens[p].type != TokenType.comment) {
        ahead--;
      }
    }
    return (p < _length) ? _tokens[p] : Token.nil;
  }

  Token _consume() {
    var t = _token;
    _next();
    return t;
  }
}

String _caller() {
  final st = StackTrace.current.toString().split('\n');
  // #0 = here, #1 = current method, #2 = caller
  var caller =
      st[2].split(' ').where((t) => t.isNotEmpty).skip(1).first.split('.').last;
  while (caller.length < 32) {
    caller += ' ';
  }
  return caller;
}
