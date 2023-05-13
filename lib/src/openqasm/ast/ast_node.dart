import 'package:meta/meta.dart';
import '../_token.dart';
import '../_tokenizer.dart';
import '../interpreter/value.dart';

part 'ast_block.dart';
part 'ast_declaration.dart';
part 'ast_expression.dart';
part 'ast_statement.dart';

abstract class Ast {
  Iterable<Token> getTokens() sync* {
    for (var child in getChildren()) {
      yield* child.getTokens();
    }
  }

  Iterable<Ast> getChildren();

  @override
  String toString() => getTokens().asText().toString();
}

abstract class AstNode extends Ast {
  AstNode();

  final tokens = <Token>[];
  final comments = <Token>[];

  @override
  Iterable<Ast> getChildren() => tokens;
}

abstract class AstNodeList<T extends AstNode> extends Iterable<T>
    implements AstNode {
  AstNodeList();

  void add(T child) => _children.add(child);

  void addAll(Iterable<T> children) => _children.addAll(children);

  @override
  int get length => _children.length;

  @override
  final tokens = <Token>[];

  @override
  final comments = <Token>[];

  final _children = <T>[];

  Iterable<T> get children => _children.map((c) => c);

  T operator [](int index) => _children[index];

  @override
  Iterator<T> get iterator => _children.iterator;

  @override
  Iterable<Ast> getChildren() => children;

  @override
  Iterable<Token> getTokens() sync* {
    for (var child in getChildren()) {
      yield* child.getTokens();
    }
  }
}

class AstDesignator extends AstNode {
  AstDesignator(this.expression);

  final AstExpression expression;

  @override
  Iterable<Ast> getChildren() sync* {
    yield tokens.first;
    yield expression;
    yield tokens.last;
  }
}

extension AstExt on Ast {
  Iterable<String> asText() => getTokens().asText();
}
