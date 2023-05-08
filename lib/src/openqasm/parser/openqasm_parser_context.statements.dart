part of 'openqasm_parser_context.dart';

extension OpenQAsmStatementParserContext on OpenQAsmParserContext {
  AstStatement? _parseStatement() {
    AstStatement? stmt;
    stmt = _parseEmptyStatement() ??
        _parseIfStatement() ??
        _parseWhileStatement() ??
        _parseForStatement() ??
        _parseReturnStatement() ??
        _parseContinueStatement() ??
        _parseBreakStatement() ??
        _parseEndStatement() ??
        _parseBoxStatement() ??
        _parseIncludeStatement() ??
        _parseVersionStatement();
    if (stmt == null) {
      var expr = _parseAssignmentExpression() ??
          _parseQuantumCall() ??
          _parseNonAssignmentExpression();
      if (expr != null) {
        stmt = AstStatementExpression(expr);
        stmt = _endOfStatement(stmt);
      } else {
        stmt = _parseBlock();
      }
    }
    return stmt;
  }

  AstBlock? _parseBlock() {
    if (_token.text != '{') {
      return null;
    }
    _bookmark();
    final block = AstBlock();
    block.comments.addAll(comments);
    block.tokens.add(_consume());
    while (_pos < _length) {
      if (_token.text == '}') {
        block.tokens.add(_consume());
        block.comments.addAll(comments);
        return _commit(block);
      }
      final stmt = _parseStatement();
      if (stmt == null) {
        return _rollback();
      }
      block.add(stmt);
    }
    throw SyntaxException('Unterminated block: expected "}".');
  }

  AstStatement? _parseEmptyStatement() =>
      (_token.text == ';') ? _endOfStatement(AstStatement()) : null;

  AstStatement? _parseVersionStatement() {
    if (_token.text != Keywords.$openqasm) {
      return null;
    }
    final version = AstStatementVersion();
    version.tokens.add(_consume());
    if (_token.type != TokenType.real) {
      throw SyntaxException('Version number expected.');
    }
    if (!RegExp(r'^\d+\.\d+$').hasMatch(_token.text)) {
      throw SyntaxException('Invalid version number: ${_token.text}.');
    }
    version.tokens.add(_consume());
    return _endOfStatement(version);
  }

  AstStatement? _parseIncludeStatement() {
    if (_token.text != Keywords.$include) {
      return null;
    }
    _bookmark();
    final include = AstStatementInclude();
    include.tokens.add(_consume());
    if (_token.type != TokenType.string) {
      return _rollback();
    }
    include.tokens.add(_consume());
    return _commit(_endOfStatement(include));
  }

  AstStatement? _parseBoxStatement() {
    if (_token.text != Keywords.$box) {
      return null;
    }
    _bookmark();
    final boxToken = _consume();
    final designator = _parseDesignator();
    final statement = _parseStatement();
    if (statement == null) {
      return _rollback();
    }
    final boxStmt = AstStatementBox(designator, statement);
    boxStmt.tokens.add(boxToken);
    return _commit(boxStmt);
  }

  AstStatement? _parseIfStatement() {
    if (_token.text != Keywords.$if || _peek().text != '(') {
      return null;
    }
    _bookmark();
    final ifToken = _consume();
    final open = _consume();
    final condition = _parseNonAssignmentExpression();
    if (condition == null || _token.text != ')') {
      throw SyntaxException('Expression expected.');
    }
    final close = _consume();
    final trueBody = _parseStatement();
    if (trueBody == null) {
      throw SyntaxException('Statement or body expected for "if" instruction.');
    }
    final ifStmt = AstStatementIf(condition, trueBody);
    ifStmt.tokens.add(ifToken);
    ifStmt.tokens.add(open);
    ifStmt.tokens.add(close);
    if (_token.text == Keywords.$else) {
      ifStmt.tokens.add(_consume());
      final falseBody = _parseStatement();
      if (falseBody == null) {
        throw SyntaxException('Statement or body expected for "else" clause.');
      }
      ifStmt.setFalseBody(falseBody);
    }
    return _commit(ifStmt);
  }

  AstStatement? _parseWhileStatement() {
    if (_token.text != Keywords.$while || _peek().text != '(') {
      return null;
    }
    _bookmark();
    final whileToken = _consume();
    final open = _consume();
    final condition = _parseNonAssignmentExpression();
    if (condition == null || _token.text != ')') {
      throw SyntaxException('Expression expected.');
    }
    final close = _consume();
    final body = _parseStatement();
    if (body == null) {
      throw SyntaxException(
          'Statement or body expected for "while" instruction.');
    }
    final whileStmt = AstStatementWhile(condition, body);
    whileStmt.tokens.add(whileToken);
    whileStmt.tokens.add(open);
    whileStmt.tokens.add(close);
    return _commit(whileStmt);
  }

  AstStatement? _parseContinueStatement() {
    if (_token.text != Keywords.$continue) {
      return null;
    }
    final continueStmt = AstStatementContinue();
    continueStmt.tokens.add(_consume());
    return _endOfStatement(continueStmt);
  }

  AstStatement? _parseBreakStatement() {
    if (_token.text != Keywords.$break) {
      return null;
    }
    final breakStmt = AstStatementBreak();
    breakStmt.tokens.add(_consume());
    return _endOfStatement(breakStmt);
  }

  AstStatement? _parseReturnStatement() {
    if (_token.text != Keywords.$return) {
      return null;
    }
    final returnToken = _consume();
    final expr = _parseNonAssignmentExpression();
    final returnStmt = AstStatementReturn(expr);
    returnStmt.tokens.add(returnToken);
    return _endOfStatement(returnStmt);
  }

  AstStatement? _parseEndStatement() {
    if (_token.text != Keywords.$end) {
      return null;
    }
    final endStmt = AstStatementEnd();
    endStmt.tokens.add(_consume());
    return _endOfStatement(endStmt);
  }

  AstStatement? _parseForStatement() {
    if (_token.text != Keywords.$for) {
      return null;
    }
    final forToken = _consume();
    final type = _parseScalarType();
    if (type == null) {
      return _rollback();
    }
    final identifier = _parseIdentifier();
    if (identifier == null) {
      return _rollback();
    }
    if (_token.text != 'in') {
      throw SyntaxException(
          'Invalid syntax for "for" loop: variable declaration.');
    }
    final inToken = _consume();
    final set = _parseArrayExpression() ??
        _parseRangeExpression() ??
        _parseIdentifier();
    if (set == null) {
      throw SyntaxException('Invalid syntax for "for" loop: dataset.');
    }
    final body = _parseStatement();
    if (body == null) {
      throw SyntaxException(
          'Statement or body expected for "for" instruction.');
    }
    final variable = AstVariable(type, identifier);
    final forStmt = AstStatementFor(variable, set, body);
    forStmt.tokens.add(forToken);
    forStmt.tokens.add(inToken);
    return forStmt;
  }

  T _endOfStatement<T extends AstStatement>(T statement) {
    if (_token.text != ';') {
      throw SyntaxException('Unterminated statement: ";" expected.');
    }
    statement.tokens.add(_consume());
    return statement;
  }
}
