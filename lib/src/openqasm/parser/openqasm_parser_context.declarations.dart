part of 'openqasm_parser_context.dart';

extension OpenQAsmDeclarationParserContext on OpenQAsmParserContext {
  AstDeclaration? _parseDeclaration() =>
      _parseAliasDeclaration() ??
      _parseConstDeclaration() ??
      _parseIODeclaration() ??
      _parseClassicalDeclaration() ??
      _parseQuantumDeclaration() ??
      _parseRegisterDeclaration();

  AstDefinition? _parseDefinition() =>
      _parseFunctionDefinition() ?? _parseGateDefinition();

  AstDeclaration? _parseAliasDeclaration() {
    if (_token.text != Keywords.$let ||
        _peek().type != TokenType.identifier ||
        _peek(2).text != '=') {
      return null;
    }
    _bookmark();
    final let = _consume();
    final identifier = _parseIdentifier()!;
    final eq = _consume();
    final expr = _parseAliasExpression();
    if (expr == null) {
      return _rollback();
    }
    final decl = AstAlias(identifier, expr);
    decl.comments.addAll(comments);
    decl.tokens.add(let);
    decl.tokens.add(eq);
    return _commit(decl);
  }

  AstVariable? _parseConstDeclaration() {
    if (_token.text != Types.$const) {
      return null;
    }
    _bookmark();
    final constToken = _consume();
    final decl = _parseClassicalDeclaration();
    if (decl == null || decl.type is AstArrayType || decl.expression == null) {
      return _rollback();
    }
    decl.setConst(constToken);
    return _commit(decl);
  }

  AstVariable? _parseIODeclaration() {
    if (!const {Types.$input, Types.$output}.contains(_token.text)) {
      return null;
    }
    _bookmark();
    final ioToken = _consume();
    final decl = _parseClassicalDeclaration();
    if (decl == null || decl.expression != null) {
      return _rollback();
    }
    decl.setInputOutput(ioToken);
    return _commit(decl);
  }

  AstVariable? _parseClassicalDeclaration() {
    _bookmark();
    final type = _parseClassicalType();
    if (type == null) {
      return _rollback();
    }
    final identifier = _parseIdentifier();
    if (identifier == null) {
      return _rollback();
    }
    AstExpression? expr;
    Token? eq;
    if (_token.text == '=') {
      eq = _consume();
      expr = _parseNonAssignmentExpression();
      if (expr == null) {
        return _rollback();
      }
    }
    final decl = AstVariable(type, identifier, eq, expr);
    decl.comments.addAll(comments);
    return _commit(decl);
  }

  AstType? _parseClassicalType() =>
      _parseScalarType() ?? _parseArrayType() ?? _parseStringType();

  AstScalarType? _parseScalarType() => _parseRealType() ?? _parseComplexType();

  AstScalarType? _parseRealType() {
    if (const {Types.$bit, Types.$int, Types.$uint, Types.$float, Types.$angle}
        .contains(_token.text)) {
      final type = _consume();
      final designator = _parseDesignator();
      return AstSimpleType(type, designator);
    } else if (const {Types.$bool, Types.$duration, Types.$stretch}
        .contains(_token.text)) {
      return AstSimpleType(_consume());
    } else {
      return null;
    }
  }

  AstSimpleType? _parseStringType() =>
      (_token.text == Types.$string) ? AstSimpleType(_consume()) : null;

  AstComplexType? _parseComplexType() {
    if (_token.text != Types.$complex) {
      return null;
    }
    _bookmark();
    final type = AstComplexType(_consume());
    if (_token.text == '[') {
      type.tokens.add(_consume());
      final itemType = _parseScalarType();
      if (itemType == null || _token.text != ']') {
        return _rollback();
      }
      type.setItemType(itemType);
      type.tokens.add(_consume());
    }
    return _commit(type);
  }

  AstArrayType? _parseArrayType() {
    if (_token.text != Types.$array || _peek().text != '[') {
      return null;
    }
    _bookmark();
    final array = _consume();
    final open = _consume();
    final itemType = _parseScalarType();
    if (itemType == null) {
      return _rollback();
    }
    final type = AstArrayType(itemType);
    type.tokens.add(array);
    type.tokens.add(open);
    while (_token.text == ',') {
      type.tokens.add(_consume());
      final expr = _parseNonAssignmentExpression();
      if (expr == null) {
        return _rollback();
      }
      type.dimensions.add(expr);
    }
    if (_token.text != ']') {
      return _rollback();
    }
    type.tokens.add(_consume());
    return _commit(type);
  }

  AstQubit? _parseQuantumDeclaration() {
    _bookmark();
    final type = _parseQuantumType();
    if (type == null) {
      return _rollback();
    }
    final identifier = _parseIdentifier();
    if (identifier == null) {
      return _rollback();
    }
    final decl = AstQubit(type, identifier);
    decl.comments.addAll(comments);
    return _commit(decl);
  }

  AstQuantumType? _parseQuantumType() {
    if (_token.text != Types.$qubit) {
      return null;
    }
    final type = _consume();
    final designator = _parseDesignator();
    return AstQuantumType(type, designator);
  }

  AstRegister? _parseRegisterDeclaration() {
    if (!const {Types.$qreg, Types.$creg}.contains(_token.text) ||
        _peek().type != TokenType.identifier) {
      return null;
    }
    final regToken = _consume();
    final identifier = _parseIdentifier()!;
    final designator = _parseDesignator();
    final decl = AstRegister(identifier, designator);
    decl.tokens.add(regToken);
    return decl;
  }

  AstDefinition? _parseFunctionDefinition() {
    if (_token.text != Keywords.$def || _peek().type != TokenType.identifier) {
      return null;
    }
    _bookmark();
    final def = _consume();
    final identifier = _parseIdentifier()!;
    if (_token.text != '(') {
      return _rollback();
    }
    final open = _consume();
    final functionDef = AstFunction(identifier);
    functionDef.tokens.add(def);
    functionDef.tokens.add(open);
    var arg = _parseArgumentDefinition();
    if (arg != null) {
      functionDef.parameters.add(arg);
      while (_token.text == ',') {
        functionDef.tokens.add(_consume());
        arg = _parseArgumentDefinition();
        if (arg == null) {
          return _rollback();
        }
        functionDef.parameters.add(arg);
      }
    }
    if (_token.text != ')') {
      return _rollback();
    }
    functionDef.tokens.add(_consume());
    if (_token.text == '->') {
      functionDef.tokens.add(_consume());
      final type = _parseScalarType();
      if (type == null) {
        return _rollback();
      }
      functionDef.setType(type);
    }
    final body = _parseBlock();
    if (body == null) {
      return _rollback();
    }
    functionDef.setBody(body);
    return _commit(functionDef);
  }

  AstDefinition? _parseGateDefinition() {
    if (_token.text != Keywords.$gate || _peek().type != TokenType.identifier) {
      return null;
    }
    _bookmark();
    final gate = _consume();
    final identifier = _parseIdentifier()!;
    final gateDef = AstGate(identifier);
    gateDef.tokens.add(gate);
    if (_token.text == '(') {
      gateDef.tokens.add(_consume());
      var arg = _parseIdentifier();
      if (arg != null) {
        gateDef.parameters.add(arg);
        while (_token.text == ',') {
          gateDef.tokens.add(_consume());
          arg = _parseIdentifier();
          if (arg == null) {
            return _rollback();
          }
          gateDef.parameters.add(arg);
        }
        if (_token.text != ')') {
          return null;
        }
        gateDef.tokens.add(_consume());
      }
    }
    var qubit = _parseIdentifier();
    if (qubit == null) {
      return _rollback();
    }
    gateDef.qubits.add(qubit);
    while (_token.text == ',') {
      gateDef.tokens.add(_consume());
      qubit = _parseIdentifier();
      if (qubit == null) {
        return _rollback();
      }
      gateDef.qubits.add(qubit);
    }
    final body = _parseBlock();
    if (body == null) {
      return _rollback();
    }
    gateDef.setBody(body);
    return _commit(gateDef);
  }

  AstParameter? _parseArgumentDefinition() {
    var arg = _parseRegisterDeclaration() ??
        _parseClassicalDeclaration() ??
        _parseQuantumDeclaration();
    if (arg == null) {
      final type = _parseRefArrayType();
      if (type != null && _token.type == TokenType.identifier) {
        final identifier = _parseIdentifier()!;
        arg = AstVariable(type, identifier);
      }
    }
    return arg;
  }

  AstArrayType? _parseRefArrayType() {
    if (!const {Types.$readonly, Types.$mutable}.contains(_token.text) ||
        _peek(1).text != Types.$array ||
        _peek(2).text != '[') {
      return null;
    }
    _bookmark();
    final modifier = _consume();
    final array = _consume();
    final open = _consume();
    final itemType = _parseScalarType();
    if (itemType == null) {
      return _rollback();
    }
    final type = AstArrayType(itemType, modifier);
    type.tokens.add(array);
    type.tokens.add(open);
    while (_token.text == ',') {
      type.tokens.add(_consume());
      AstExpression? expr;
      if (_token.text == BuiltIn.$dim) {
        if (_peek().text != '=') {
          return _rollback();
        }
        final dim = AstIdentifier(_consume());
        final eq = _consume();
        expr = _parseNonAssignmentExpression();
        if (expr != null) {
          expr = AstExpressionAssignment(dim, eq, expr);
        }
      } else {
        expr = _parseNonAssignmentExpression();
      }
      if (expr == null) {
        return _rollback();
      }
      type.dimensions.add(expr);
    }
    if (_token.text != ']') {
      return _rollback();
    }
    type.tokens.add(_consume());
    return _commit(type);
  }
}
