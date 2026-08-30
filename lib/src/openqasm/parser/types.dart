part of 'ast_nodes.dart';

abstract class TypeNode extends OpenQASMNode {
  const TypeNode._(super.source) : super._();
}

class ScalarTypeNode extends TypeNode {
  final String name;
  final Expression? designator;

  ScalarTypeNode(super.source, this.name, {this.designator}) : super._();
}

class QubitTypeNode extends TypeNode {
  final Expression? designator;

  QubitTypeNode(super.source, {this.designator}) : super._();
}

class ComplexTypeNode extends TypeNode {
  final ScalarTypeNode? baseType;

  ComplexTypeNode(super.source, [this.baseType]) : super._();
}

class ArrayTypeNode extends TypeNode {
  final TypeNode baseType;
  final List<Expression> dimensions;

  ArrayTypeNode(super.source, this.baseType, this.dimensions) : super._();
}

class ArrayReferenceType extends TypeNode {
  final String modifier; // 'readonly' or 'mutable'
  final ScalarTypeNode baseType;
  final List<Expression> dimensions;
  final Expression? dimEquals; // For DIM = expression syntax

  ArrayReferenceType(
    super.source,
    this.modifier,
    this.baseType,
    this.dimensions, {
    this.dimEquals,
  }) : super._();
}
