import 'package:meta/meta.dart';

import 'ast/ast_node.dart';

enum TokenType {
  comment,
  pragma,
  annotation,
  integer,
  real,
  imaginary,
  duration,
  string,
  constant,
  operator,
  separator,
  keyword,
  identifier,
  _eot;
}

class Token implements Ast {
  const Token(this.start, this.end, this.text, this.type);

  final int start;
  final int end;
  final String text;
  final TokenType type;

  static const Token nil = Token(0, 0, '', TokenType._eot);

  bool isA(dynamic other) {
    if (other is String) return text == other;
    if (other is TokenType) return type == other;
    if (other is! Token) return false;
    return (start == other.start && end == other.end);
  }

  static String asText(Token t) => t.text;

  @override
  Iterable<Token> getTokens() sync* {
    yield this;
  }

  @override
  Iterable<Ast> getChildren() => const [];
}

extension TokenListExt on Iterable<Token> {
  Iterable<String> asText() => map(Token.asText);
}

@internal
extension TokenImpl on Token {
  Token withType(TokenType type) => Token(start, end, text, type);
}
