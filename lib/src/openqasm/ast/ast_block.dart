part of 'ast_node.dart';

class AstBlock extends AstNodeList<AstStatement> implements AstStatement {
  AstBlock();

  @override
  final annotations = <Token>[];

  @override
  Iterable<Ast> getChildren() sync* {
    yield tokens.first;
    yield* super.getChildren();
    yield tokens.last;
  }
}
