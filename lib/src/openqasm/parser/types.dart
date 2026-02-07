part of 'ast_nodes.dart';

abstract class TypeNode extends OpenQASMNode {
  const TypeNode._() : super._();
}

class ScalarTypeNode extends TypeNode {
  final String name;
  final Expression? designator;

  ScalarTypeNode(this.name, {this.designator}) : super._();
}

class QubitTypeNode extends TypeNode {
  final Expression? designator;

  QubitTypeNode({this.designator}) : super._();
}

class ComplexTypeNode extends TypeNode {
  final ScalarTypeNode? baseType;

  ComplexTypeNode([this.baseType]) : super._();
}

class ArrayTypeNode extends TypeNode {
  final TypeNode baseType;
  final List<Expression> dimensions;

  ArrayTypeNode(this.baseType, this.dimensions) : super._();
}

class ArrayReferenceType extends TypeNode {
  final String modifier; // 'readonly' or 'mutable'
  final ScalarTypeNode baseType;
  final List<Expression> dimensions;
  final Expression? dimEquals; // For DIM = expression syntax

  ArrayReferenceType(
    this.modifier,
    this.baseType,
    this.dimensions, {
    this.dimEquals,
  }) : super._();
}
