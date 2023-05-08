part of 'ast_node.dart';

abstract class AstDeclaration extends AstNode {}

abstract class AstDefinition extends AstNode {}

abstract class AstType extends AstNode {
  Token get type;
  AstDesignator? get designator;
}

abstract class AstScalarType extends AstType {}

class AstSimpleType extends AstScalarType {
  AstSimpleType(this.type, [this.designator]);

  @override
  final Token type;

  @override
  final AstDesignator? designator;

  @override
  Iterable<Ast> getChildren() sync* {
    yield type;
    if (designator != null) {
      yield designator!;
    }
  }
}

class AstComplexType extends AstScalarType {
  AstComplexType(this.type);

  @override
  final Token type;

  @override
  AstDesignator? get designator => null;

  AstScalarType? _itemType;
  AstScalarType? get itemType => _itemType;

  @override
  Iterable<Ast> getChildren() sync* {
    yield type;
    if (_itemType != null) {
      yield tokens.first;
      yield _itemType!;
      yield tokens.last;
    }
  }
}

class AstArrayType extends AstType {
  AstArrayType(this.itemType, [this.modifier]);

  @override
  Token get type => tokens.first;

  @override
  AstDesignator? get designator => null;

  final Token? modifier;
  final AstScalarType itemType;
  final dimensions = <AstExpression>[];

  @override
  Iterable<Ast> getChildren() sync* {
    var idx = 0;
    yield tokens[idx++];
    yield tokens[idx++];
    yield itemType;
    for (var i = 0; i < dimensions.length; i++) {
      yield tokens[idx++];
      yield dimensions[i];
    }
    yield tokens[idx];
  }
}

class AstQuantumType extends AstType {
  AstQuantumType(this.type, [this.designator]);

  @override
  final Token type;

  @override
  final AstDesignator? designator;

  @override
  Iterable<Ast> getChildren() sync* {
    yield type;
    if (designator != null) {
      yield designator!;
    }
  }
}

class AstParameter extends AstDefinition {}

class AstVariable extends AstDeclaration implements AstParameter {
  AstVariable(this.type, this.identifier, [this.eq, this.expression])
      : assert((eq == null && expression == null) ||
            (eq != null && expression != null));

  Token? _constant;
  Token? _input;
  Token? _output;
  final AstType type;
  final AstIdentifier identifier;
  final Token? eq;
  final AstExpression? expression;

  bool get constant => _constant != null;
  bool get input => _input != null;
  bool get output => _output != null;

  @override
  Iterable<Ast> getChildren() sync* {
    final modifier = _constant ?? _input ?? _output;
    if (modifier != null) {
      yield modifier;
    }
    yield type;
    yield identifier;
    if (expression != null) {
      yield eq!;
      yield expression!;
    }
  }
}

class AstQubit extends AstDeclaration implements AstParameter {
  AstQubit(this.type, this.identifier);

  final AstQuantumType type;
  final AstIdentifier identifier;

  @override
  Iterable<Ast> getChildren() sync* {
    yield type;
    yield identifier;
  }
}

class AstRegister extends AstDeclaration implements AstParameter {
  AstRegister(this.identifier, this.designator);

  final AstIdentifier identifier;
  final AstDesignator? designator;

  @override
  Iterable<Ast> getChildren() sync* {
    yield tokens.first;
    yield identifier;
    if (designator != null) {
      yield designator!;
    }
  }
}

class AstAlias extends AstDeclaration {
  AstAlias(this.identifier, this.sets);

  final AstIdentifier identifier;
  final AstExpressionSets sets;

  @override
  Iterable<Ast> getChildren() sync* {
    yield tokens.first;
    yield identifier;
    yield tokens.last;
    yield sets;
  }
}

class AstFunction extends AstDefinition {
  AstFunction(this.identifier);

  final AstIdentifier identifier;
  final parameters = <AstParameter>[];
  AstScalarType? _type;
  AstScalarType? get type => _type;
  AstBlock? _body;
  AstBlock get body => _body!;

  @override
  Iterable<Ast> getChildren() sync* {
    var idx = 0;
    yield tokens[idx++];
    yield identifier;
    yield tokens[idx++];
    for (var i = 0; i < parameters.length; i++) {
      if (i > 0) {
        yield tokens[idx++];
      }
      yield parameters[i];
    }
    yield tokens[idx++];
    if (_type != null) {
      yield tokens[idx++];
      yield _type!;
    }
    yield body;
  }
}

class AstGate extends AstDefinition {
  AstGate(this.identifier);

  final AstIdentifier identifier;
  final parameters = <AstIdentifier>[];
  final qubits = <AstIdentifier>[];
  AstBlock? _body;
  AstBlock get body => _body!;

  @override
  Iterable<Ast> getChildren() sync* {
    var idx = 0;
    yield tokens[idx++];
    yield identifier;
    if (parameters.isNotEmpty || tokens[idx].text == '(') {
      yield tokens[idx++];
    }
    for (var i = 0; i < parameters.length; i++) {
      if (i > 0) {
        yield tokens[idx++];
      }
      yield parameters[i];
    }
    if (parameters.isNotEmpty || tokens[idx].text == ')') {
      yield tokens[idx++];
    }
    for (var i = 0; i < qubits.length; i++) {
      if (i > 0) {
        yield tokens[idx++];
      }
      yield qubits[i];
    }
    yield body;
  }
}

@internal
extension AstComplexTypeImpl on AstComplexType {
  void setItemType(AstScalarType itemType) => _itemType = itemType;
}

@internal
extension AstVariableImpl on AstVariable {
  void setConst(Token constToken) => _constant = constToken;

  void setInputOutput(Token ioToken) {
    if (ioToken.text == Types.$input) {
      _input = ioToken;
    } else if (ioToken.text == Types.$output) {
      _output = ioToken;
    }
  }
}

@internal
extension AstFunctionImpl on AstFunction {
  void setBody(AstBlock body) => _body = body;

  void setType(AstScalarType type) => _type = type;
}

@internal
extension AstGateImpl on AstGate {
  void setBody(AstBlock body) => _body = body;
}
