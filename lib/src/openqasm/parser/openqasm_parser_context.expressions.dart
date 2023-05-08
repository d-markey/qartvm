part of 'openqasm_parser_context.dart';

extension OpenQAsmExpressionParserContext on OpenQAsmParserContext {
  AstExpression? _parseAssignmentExpression() {
    final measureAssignment = _parseMeasureAssignment();
    if (measureAssignment != null) {
      return measureAssignment;
    }
    _bookmark();
    final assignee = _parseIndexedIdentifier();
    if (assignee == null) {
      return _rollback();
    }

    final op = _consume();
    if (!const {
      '=',
      ...['+=', '-=', '*=', '/=', '%=', '**='],
      ...['^=', '|=', '&=', '>>=', '<<='],
    }.contains(op.text)) {
      return _rollback();
    }

    final expression = _parseNonAssignmentExpression() ?? _parseMeasureCall();
    if (expression == null) {
      return _rollback();
    }

    final assignment = AstExpressionAssignment(assignee, op, expression);
    return _commit(assignment);
  }

  AstExpression? _parseIndexedIdentifier() {
    if (_token.type != TokenType.identifier) {
      return null;
    }
    _bookmark();
    AstExpression identifier = _parseIdentifier()!;
    while (_token.text == '[') {
      final indexer = _parseIndexOrRange();
      if (indexer == null) {
        return _rollback();
      }
      identifier = AstExpressionArrayAccess(identifier, indexer);
    }
    return _commit(identifier);
  }

  AstExpression? _parseNonAssignmentExpression() => _parseLogicalOrExpression();
  // _parseLogicalAndExpression() ??
  // _parseBitwiseOrExpression() ??
  // _parseBitwiseXorExpression() ??
  // _parseBitwiseAndExpression() ??
  // _parseEqualityExpression() ??
  // _parseComparisonExpression() ??
  // _parseBitShiftExpression() ??
  // _parseAdditiveExpression() ??
  // _parseMultiplicativeExpression() ??
  // _parsePowerExpression() ??
  // _parseAtomicExpression();

  AstExpression? _parseLogicalOrExpression() {
    _bookmark();
    final left = _parseLogicalAndExpression();
    if (left == null) {
      return _rollback();
    }
    if (_token.text != '||') {
      return _commit(left);
    }
    final op = _consume();
    final right = _parseLogicalOrExpression();
    if (right == null) {
      throw SyntaxException('Expression expected after "||".');
    }
    return _commit(AstExpressionBinary(left, op, right));
  }

  AstExpression? _parseLogicalAndExpression() {
    _bookmark();
    final left = _parseBitwiseOrExpression();
    if (left == null) {
      return _rollback();
    }
    if (_token.text != '&&') {
      return _commit(left);
    }
    final op = _consume();
    final right = _parseLogicalAndExpression();
    if (right == null) {
      throw SyntaxException('Expression expected after "&&".');
    }
    return _commit(AstExpressionBinary(left, op, right));
  }

  AstExpression? _parseBitwiseOrExpression() {
    _bookmark();
    final left = _parseBitwiseXorExpression();
    if (left == null) {
      return _rollback();
    }
    if (_token.text != '|') {
      return _commit(left);
    }
    final op = _consume();
    final right = _parseBitwiseOrExpression();
    if (right == null) {
      throw SyntaxException('Expression expected after "|".');
    }
    return _commit(AstExpressionBinary(left, op, right));
  }

  AstExpression? _parseBitwiseXorExpression() {
    _bookmark();
    final left = _parseBitwiseAndExpression();
    if (left == null) {
      return _rollback();
    }
    if (_token.text != '^') {
      return _commit(left);
    }
    final op = _consume();
    final right = _parseBitwiseXorExpression();
    if (right == null) {
      throw SyntaxException('Expression expected after "^".');
    }
    return _commit(AstExpressionBinary(left, op, right));
  }

  AstExpression? _parseBitwiseAndExpression() {
    _bookmark();
    final left = _parseEqualityExpression();
    if (left == null) {
      return _rollback();
    }
    if (_token.text != '&') {
      return _commit(left);
    }
    final op = _consume();
    final right = _parseBitwiseAndExpression();
    if (right == null) {
      throw SyntaxException('Expression expected after "&".');
    }
    return _commit(AstExpressionBinary(left, op, right));
  }

  AstExpression? _parseEqualityExpression() {
    _bookmark();
    final left = _parseComparisonExpression();
    if (left == null) {
      return _rollback();
    }
    if (!const {'==', '!=', 'in'}.contains(_token.text)) {
      return _commit(left);
    }
    final op = _consume();
    final right = _parseEqualityExpression();
    if (right == null) {
      throw SyntaxException('Expression expected after "${op.text}".');
    }
    return _commit(AstExpressionBinary(left, op, right));
  }

  AstExpression? _parseComparisonExpression() {
    _bookmark();
    final left = _parseBitShiftExpression();
    if (left == null) {
      return _rollback();
    }
    if (!const {'<', '<=', '>', '>='}.contains(_token.text)) {
      return _commit(left);
    }
    final op = _consume();
    final right = _parseComparisonExpression();
    if (right == null) {
      throw SyntaxException('Expression expected after "${op.text}".');
    }
    return _commit(AstExpressionBinary(left, op, right));
  }

  AstExpression? _parseBitShiftExpression() {
    _bookmark();
    final left = _parseAdditiveExpression();
    if (left == null) {
      return _rollback();
    }
    if (!const {'<<', '>>'}.contains(_token.text)) {
      return _commit(left);
    }
    final op = _consume();
    final right = _parseBitShiftExpression();
    if (right == null) {
      throw SyntaxException('Expression expected after "${op.text}".');
    }
    return _commit(AstExpressionBinary(left, op, right));
  }

  AstExpression? _parseAdditiveExpression() {
    _bookmark();
    final left = _parseMultiplicativeExpression();
    if (left == null) {
      return _rollback();
    }
    if (!const {'+', '-'}.contains(_token.text)) {
      return _commit(left);
    }
    final op = _consume();
    final right = _parseAdditiveExpression();
    if (right == null) {
      throw SyntaxException('Expression expected after "${op.text}".');
    }
    return _commit(AstExpressionBinary(left, op, right));
  }

  AstExpression? _parseMultiplicativeExpression() {
    _bookmark();
    final left = _parsePowerExpression();
    if (left == null) {
      return _rollback();
    }
    if (!const {'*', '/', '%'}.contains(_token.text)) {
      return _commit(left);
    }
    final op = _consume();
    final right = _parseMultiplicativeExpression();
    if (right == null) {
      throw SyntaxException('Expression expected after "${op.text}".');
    }
    return _commit(AstExpressionBinary(left, op, right));
  }

  AstExpression? _parsePowerExpression() {
    _bookmark();
    final left = _parseAtomicExpression();
    if (left == null) {
      return _rollback();
    }
    if (_token.text != '**') {
      return _commit(left);
    }
    final op = _consume();
    final right = _parsePowerExpression();
    if (right == null) {
      throw SyntaxException('Expression expected after "${op.text}".');
    }
    return _commit(AstExpressionBinary(left, op, right));
  }

  AstExpression? _parseAtomicExpression() {
    AstExpression? expr;

    _bookmark();
    final type = _parseScalarType() ?? _parseArrayType();
    if (type != null) {
      if (_token.text != '(') {
        return _rollback();
      }
      final open = _consume();
      expr = _parseNonAssignmentExpression();
      if (expr == null || _token.text != ')') {
        // invalid cast expression
        return _rollback();
      }
      final close = _consume();
      expr = AstExpressionCast(type, expr);
      expr.tokens.add(open);
      expr.tokens.add(close);
      return _commit(expr);
    }

    expr = _parseUnaryExpression() ?? _parseLiteral() ?? _parsePhysicalQubit();
    if (expr != null) {
      return _commit(expr);
    }
    expr = _parseFunctionCall() ??
        _parseIdentifier() ??
        _parseArrayExpression() ??
        _parseRangeExpression() ??
        _parseParenthesisExpression();

    while (_token.text == '[') {
      final indexer = _parseIndexOrRange();
      if (indexer == null) {
        break;
      }
      expr = AstExpressionArrayAccess(expr!, indexer);
    }

    return (expr == null) ? _rollback() : _commit(expr);
  }

  AstExpression? _parseParenthesisExpression() {
    if (_token.text != '(') {
      return null;
    }
    _bookmark();
    final open = _consume();
    var expr = _parseNonAssignmentExpression();
    if (expr == null || _token.text != ')') {
      return _rollback();
    }
    final close = _consume();
    expr = AstExpressionParenthesis(expr);
    expr.tokens.add(open);
    expr.tokens.add(close);
    return _commit(expr);
  }

  AstExpression? _parseUnaryExpression() {
    if (!const {'+', '-', '!', '~'}.contains(_token.text)) {
      return null;
    }
    _bookmark();
    final op = _consume();
    final operand = _parseAtomicExpression();
    return (operand == null)
        ? _rollback()
        : _commit(AstExpressionUnary(op, operand));
  }

  AstExpression? _parseArrayExpression() {
    if (_token.text != '{') {
      return null;
    }
    _bookmark();
    final array = AstExpressionArray();
    array.tokens.add(_consume());
    while (_pos < _length) {
      var item = _parseNonAssignmentExpression();
      if (item == null) {
        return _rollback();
      }
      array.add(item);
      final token = _consume();
      array.tokens.add(token);
      if (token.text == '}') {
        return _commit(array);
      } else if (token.text != ',') {
        return _rollback();
      }
    }
    throw SyntaxException('Unterminated array.');
  }

  AstExpression? _parsePhysicalQubit() {
    if (!_token.text.startsWith('\$') ||
        int.tryParse(_token.text.substring(1)) == null) {
      return null;
    }
    final expr = AstExpressionPhysicalQubit();
    expr.tokens.add(_consume());
    return expr;
  }

  AstExpression? _parseLiteral() {
    switch (_token.type) {
      case TokenType.integer:
        return AstExpressionInteger(_consume());
      case TokenType.real:
        return AstExpressionReal(_consume());
      case TokenType.imaginary:
        return AstExpressionImaginary(_consume());
      case TokenType.duration:
        return AstExpressionDuration(_consume());
      case TokenType.string:
        return AstExpressionString(_consume());
      case TokenType.constant:
        return AstExpressionConstant(_consume());
      default:
        return null;
    }
  }

  AstExpressionIndexSet? _parseIndexOrRange() =>
      _parseRangeExpression() ?? _parseIndexExpression();

  AstExpressionIndex? _parseIndexExpression() {
    if (_token.text != '[') {
      return null;
    }
    _bookmark();
    final index = AstExpressionIndex();
    index.tokens.add(_consume());
    var expr = _parseSliceOrExpression();
    if (expr == null) {
      return _rollback();
    }
    index.add(expr);
    while (_token.text == ',') {
      index.tokens.add(_consume());
      expr = _parseSliceOrExpression();
      if (expr == null) {
        return _rollback();
      }
      index.add(expr);
    }
    if (_token.text != ']') {
      return _rollback();
    }
    index.tokens.add(_consume());
    return _commit(index);
  }

  AstExpressionIndexSet? _parseRangeExpression() {
    if (_token.text != '[') {
      return null;
    }
    _bookmark();
    final open = _consume();
    final slice = _parseSliceOrExpression();
    if (slice is! AstExpressionSlice || _token.text != ']') {
      return _rollback();
    }
    final close = _consume();
    final range = AstExpressionRange(slice);
    range.tokens.add(open);
    range.tokens.add(close);
    return _commit(range);
  }

  AstExpression? _parseSliceOrExpression() {
    _bookmark();
    final start = _parseNonAssignmentExpression();
    if (start == null) {
      return _rollback();
    }
    if (_token.text != ':') {
      return _commit(start);
    }
    final colon1 = _consume();
    var end = _parseNonAssignmentExpression();
    if (end == null) {
      return _rollback();
    }
    AstExpression? incr;
    Token? colon2;
    if (_token.text == ':') {
      colon2 = _consume();
      incr = end;
      end = _parseNonAssignmentExpression();
      if (end == null) {
        return _rollback();
      }
    }
    final slice = AstExpressionSlice(start, incr, end);
    slice.tokens.add(colon1);
    if (colon2 != null) {
      slice.tokens.add(colon2);
    }
    return _commit(slice);
  }

  AstExpression? _parseFunctionCall() {
    if (_token.type != TokenType.identifier &&
        !BuiltInFunctions.all.contains(_token.text)) {
      return null;
    }
    _bookmark();
    final identifier = _parseIdentifier(force: true)!;
    final arguments = _parseArguments();
    if (arguments == null) {
      return _rollback();
    }
    return _commit(AstExpressionFunctionCall(identifier, arguments));
  }

  AstExpression? _parseQuantumCall() =>
      _parseMeasureCall() ??
      _parseResetCall() ??
      _parseDelayCall() ??
      _parseGateCall();

  AstExpressionMeasureCall? _parseMeasureCall() {
    if (_token.text != BuiltIn.$measure) {
      return null;
    }
    _bookmark();
    final measure = AstIdentifier(_consume());
    final operand = _parseGateOperand();
    if (operand == null) {
      return _rollback();
    }
    return _commit(AstExpressionMeasureCall(measure, operand));
  }

  AstExpression? _parseMeasureAssignment() {
    _bookmark();
    final measureCall = _parseMeasureCall();
    if (measureCall == null || _token.text != '->') {
      return _rollback();
    }
    measureCall.tokens.add(_consume());
    final assignee = _parseIndexedIdentifier();
    if (assignee == null) {
      return _rollback();
    }
    measureCall.setAssignee(assignee);
    return _commit(measureCall);
  }

  AstExpression? _parseResetCall() {
    if (_token.text != BuiltIn.$reset) {
      return null;
    }
    _bookmark();
    final reset = AstIdentifier(_consume());
    final qubit = _parseGateOperand();
    if (qubit == null) {
      return _rollback();
    }
    final resetCall = AstExpressionGateCall(reset, null, null, null);
    resetCall.qubits.add(qubit);
    return _commit(resetCall);
  }

  AstExpression? _parseDelayCall() {
    if (_token.text != BuiltIn.$delay) {
      return null;
    }
    _bookmark();
    final delay = AstIdentifier(_consume());
    final designator = _parseDesignator();
    if (designator == null) {
      return _rollback();
    }
    final delayCall = AstExpressionGateCall(delay, null, null, designator);
    var qubit = _parseGateOperand();
    while (qubit != null) {
      delayCall.qubits.add((qubit));
      if (_token.text != ',') {
        break;
      }
      delayCall.tokens.add(_consume());
      qubit = _parseGateOperand();
    }
    return _commit(delayCall);
  }

  AstExpression? _parseGateCall() {
    _bookmark();
    final modifiers = <AstModifier>[];
    var modifier = _parseGateModifier();
    while (modifier != null) {
      modifiers.add(modifier);
      modifier = _parseGateModifier();
    }
    AstIdentifier? identifier;
    if (_token.text == BuiltIn.$gphase) {
      identifier = AstIdentifier(_consume());
    } else {
      identifier = _parseIdentifier();
    }
    if (identifier == null) {
      return _rollback();
    }
    final arguments = _parseArguments();
    final designator = _parseDesignator();
    final gateCall =
        AstExpressionGateCall(identifier, modifiers, arguments, designator);
    var qubit = _parseGateOperand();
    while (qubit != null) {
      gateCall.qubits.add(qubit);
      if (_token.text != ',') {
        break;
      }
      gateCall.tokens.add(_consume());
      qubit = _parseGateOperand();
    }
    return (identifier.name.text != BuiltIn.$gphase && gateCall.qubits.isEmpty)
        ? _rollback()
        : _commit(gateCall);
  }

  AstModifier? _parseGateModifier() =>
      _parseInvModifier() ?? _parsePowModifier() ?? _parseCtrlModifier();

  AstModifier? _parseInvModifier() {
    if (_token.text != BuiltIn.$inv && _peek().text != '@') {
      return null;
    }
    final invModifier = AstModifier();
    invModifier.tokens.add(_consume());
    invModifier.tokens.add(_consume());
    return invModifier;
  }

  AstModifier? _parsePowModifier() {
    if (_token.text != BuiltInFunctions.$pow || _peek().text != '(') {
      return null;
    }
    _bookmark();
    final pow = _consume();
    final open = _consume();
    final expr = _parseNonAssignmentExpression();
    if (expr == null || _token.text != ')') {
      return _rollback();
    }
    final close = _consume();
    final powModifier = AstPowModifier(expr);
    powModifier.tokens.add(pow);
    powModifier.tokens.add(open);
    powModifier.tokens.add(close);
    if (_token.text != '@') {
      return _rollback();
    }
    powModifier.tokens.add(_consume());
    return _commit(powModifier);
  }

  AstModifier? _parseCtrlModifier() {
    if (!const {BuiltIn.$ctrl, BuiltIn.$negCtrl}.contains(_token.text)) {
      return null;
    }
    _bookmark();
    final ctrl = _consume();
    AstExpression? expr;
    Token? open;
    Token? close;
    if (_token.text == '(') {
      open = _consume();
      expr = _parseNonAssignmentExpression();
      if (expr == null || _token.text != ')') {
        return _rollback();
      }
      close = _consume();
    }
    final ctrlModifier = AstCtrlModifier(expr);
    ctrlModifier.tokens.add(ctrl);
    if (expr != null) {
      ctrlModifier.tokens.add(open!);
      ctrlModifier.tokens.add(close!);
    }
    if (_token.text != '@') {
      return _rollback();
    }
    ctrlModifier.tokens.add(_consume());
    return _commit(ctrlModifier);
  }

  AstExpression? _parseGateOperand() =>
      _parsePhysicalQubit() ?? _parseIndexedIdentifier();

  AstExpressionArguments? _parseArguments() {
    if (_token.text != '(') {
      return null;
    }
    _bookmark();
    final args = AstExpressionArguments();
    args.tokens.add(_consume());
    if (_token.text == ')') {
      // empty parameters
      args.tokens.add(_consume());
      return _commit(args);
    }
    var expr = _parseNonAssignmentExpression();
    if (expr == null) {
      return _rollback();
    }
    args.add(expr);
    while (_token.text == ',') {
      args.tokens.add(_consume());
      expr = _parseNonAssignmentExpression();
      if (expr == null) {
        return _rollback();
      }
      args.add(expr);
    }
    if (_token.text != ')') {
      throw SyntaxException('")" expected.');
    }
    args.tokens.add(_consume());
    return _commit(args);
  }

  AstIdentifier? _parseIdentifier({bool force = false}) =>
      (force || _token.type == TokenType.identifier)
          ? AstIdentifier(_consume())
          : null;

  AstExpressionSets? _parseAliasExpression() {
    _bookmark();
    var expr = _parseNonAssignmentExpression();
    if (expr == null) {
      return _rollback();
    }
    final aliasExpr = AstExpressionSets();
    aliasExpr.add(expr);
    while (_token.text == '++') {
      aliasExpr.tokens.add(_consume());
      expr = _parseNonAssignmentExpression();
      if (expr == null) {
        return _rollback();
      }
      aliasExpr.add(expr);
    }
    return _commit(aliasExpr);
  }
}
