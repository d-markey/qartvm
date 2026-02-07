// Generated from C:\_Projects\github\qartvm\tools\antlr4\\OpenQASM3Parser.g4 by ANTLR 4.12.0
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes
import 'package:antlr4/antlr4.dart';

import 'OpenQASM3Parser.dart';

/// This abstract class defines a complete listener for a parse tree produced by
/// [OpenQASM3Parser].
abstract class OpenQASM3ParserListener extends ParseTreeListener {
  /// Enter a parse tree produced by [OpenQASM3Parser.program].
  /// [ctx] the parse tree
  void enterProgram(ProgramContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.program].
  /// [ctx] the parse tree
  void exitProgram(ProgramContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.version].
  /// [ctx] the parse tree
  void enterVersion(VersionContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.version].
  /// [ctx] the parse tree
  void exitVersion(VersionContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.statement].
  /// [ctx] the parse tree
  void enterStatement(StatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.statement].
  /// [ctx] the parse tree
  void exitStatement(StatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.annotation].
  /// [ctx] the parse tree
  void enterAnnotation(AnnotationContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.annotation].
  /// [ctx] the parse tree
  void exitAnnotation(AnnotationContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.scope].
  /// [ctx] the parse tree
  void enterScope(ScopeContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.scope].
  /// [ctx] the parse tree
  void exitScope(ScopeContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.pragma].
  /// [ctx] the parse tree
  void enterPragma(PragmaContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.pragma].
  /// [ctx] the parse tree
  void exitPragma(PragmaContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.statementOrScope].
  /// [ctx] the parse tree
  void enterStatementOrScope(StatementOrScopeContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.statementOrScope].
  /// [ctx] the parse tree
  void exitStatementOrScope(StatementOrScopeContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.calibrationGrammarStatement].
  /// [ctx] the parse tree
  void enterCalibrationGrammarStatement(CalibrationGrammarStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.calibrationGrammarStatement].
  /// [ctx] the parse tree
  void exitCalibrationGrammarStatement(CalibrationGrammarStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.includeStatement].
  /// [ctx] the parse tree
  void enterIncludeStatement(IncludeStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.includeStatement].
  /// [ctx] the parse tree
  void exitIncludeStatement(IncludeStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.breakStatement].
  /// [ctx] the parse tree
  void enterBreakStatement(BreakStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.breakStatement].
  /// [ctx] the parse tree
  void exitBreakStatement(BreakStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.continueStatement].
  /// [ctx] the parse tree
  void enterContinueStatement(ContinueStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.continueStatement].
  /// [ctx] the parse tree
  void exitContinueStatement(ContinueStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.endStatement].
  /// [ctx] the parse tree
  void enterEndStatement(EndStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.endStatement].
  /// [ctx] the parse tree
  void exitEndStatement(EndStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.forStatement].
  /// [ctx] the parse tree
  void enterForStatement(ForStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.forStatement].
  /// [ctx] the parse tree
  void exitForStatement(ForStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.ifStatement].
  /// [ctx] the parse tree
  void enterIfStatement(IfStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.ifStatement].
  /// [ctx] the parse tree
  void exitIfStatement(IfStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.returnStatement].
  /// [ctx] the parse tree
  void enterReturnStatement(ReturnStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.returnStatement].
  /// [ctx] the parse tree
  void exitReturnStatement(ReturnStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.whileStatement].
  /// [ctx] the parse tree
  void enterWhileStatement(WhileStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.whileStatement].
  /// [ctx] the parse tree
  void exitWhileStatement(WhileStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.barrierStatement].
  /// [ctx] the parse tree
  void enterBarrierStatement(BarrierStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.barrierStatement].
  /// [ctx] the parse tree
  void exitBarrierStatement(BarrierStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.boxStatement].
  /// [ctx] the parse tree
  void enterBoxStatement(BoxStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.boxStatement].
  /// [ctx] the parse tree
  void exitBoxStatement(BoxStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.delayStatement].
  /// [ctx] the parse tree
  void enterDelayStatement(DelayStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.delayStatement].
  /// [ctx] the parse tree
  void exitDelayStatement(DelayStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.gateCallStatement].
  /// [ctx] the parse tree
  void enterGateCallStatement(GateCallStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.gateCallStatement].
  /// [ctx] the parse tree
  void exitGateCallStatement(GateCallStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.measureArrowAssignmentStatement].
  /// [ctx] the parse tree
  void enterMeasureArrowAssignmentStatement(MeasureArrowAssignmentStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.measureArrowAssignmentStatement].
  /// [ctx] the parse tree
  void exitMeasureArrowAssignmentStatement(MeasureArrowAssignmentStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.resetStatement].
  /// [ctx] the parse tree
  void enterResetStatement(ResetStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.resetStatement].
  /// [ctx] the parse tree
  void exitResetStatement(ResetStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.aliasDeclarationStatement].
  /// [ctx] the parse tree
  void enterAliasDeclarationStatement(AliasDeclarationStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.aliasDeclarationStatement].
  /// [ctx] the parse tree
  void exitAliasDeclarationStatement(AliasDeclarationStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.classicalDeclarationStatement].
  /// [ctx] the parse tree
  void enterClassicalDeclarationStatement(ClassicalDeclarationStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.classicalDeclarationStatement].
  /// [ctx] the parse tree
  void exitClassicalDeclarationStatement(ClassicalDeclarationStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.constDeclarationStatement].
  /// [ctx] the parse tree
  void enterConstDeclarationStatement(ConstDeclarationStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.constDeclarationStatement].
  /// [ctx] the parse tree
  void exitConstDeclarationStatement(ConstDeclarationStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.ioDeclarationStatement].
  /// [ctx] the parse tree
  void enterIoDeclarationStatement(IoDeclarationStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.ioDeclarationStatement].
  /// [ctx] the parse tree
  void exitIoDeclarationStatement(IoDeclarationStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.oldStyleDeclarationStatement].
  /// [ctx] the parse tree
  void enterOldStyleDeclarationStatement(OldStyleDeclarationStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.oldStyleDeclarationStatement].
  /// [ctx] the parse tree
  void exitOldStyleDeclarationStatement(OldStyleDeclarationStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.quantumDeclarationStatement].
  /// [ctx] the parse tree
  void enterQuantumDeclarationStatement(QuantumDeclarationStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.quantumDeclarationStatement].
  /// [ctx] the parse tree
  void exitQuantumDeclarationStatement(QuantumDeclarationStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.defStatement].
  /// [ctx] the parse tree
  void enterDefStatement(DefStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.defStatement].
  /// [ctx] the parse tree
  void exitDefStatement(DefStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.externStatement].
  /// [ctx] the parse tree
  void enterExternStatement(ExternStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.externStatement].
  /// [ctx] the parse tree
  void exitExternStatement(ExternStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.gateStatement].
  /// [ctx] the parse tree
  void enterGateStatement(GateStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.gateStatement].
  /// [ctx] the parse tree
  void exitGateStatement(GateStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.assignmentStatement].
  /// [ctx] the parse tree
  void enterAssignmentStatement(AssignmentStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.assignmentStatement].
  /// [ctx] the parse tree
  void exitAssignmentStatement(AssignmentStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.expressionStatement].
  /// [ctx] the parse tree
  void enterExpressionStatement(ExpressionStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.expressionStatement].
  /// [ctx] the parse tree
  void exitExpressionStatement(ExpressionStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.calStatement].
  /// [ctx] the parse tree
  void enterCalStatement(CalStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.calStatement].
  /// [ctx] the parse tree
  void exitCalStatement(CalStatementContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.defcalStatement].
  /// [ctx] the parse tree
  void enterDefcalStatement(DefcalStatementContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.defcalStatement].
  /// [ctx] the parse tree
  void exitDefcalStatement(DefcalStatementContext ctx);

  /// Enter a parse tree produced by the [bitwiseXorExpression]
  /// labeled alternative in [file.parserName>.expression].
  /// [ctx] the parse tree
  void enterBitwiseXorExpression(BitwiseXorExpressionContext ctx);
  /// Exit a parse tree produced by the [bitwiseXorExpression]
  /// labeled alternative in [OpenQASM3Parser.expression].
  /// [ctx] the parse tree
  void exitBitwiseXorExpression(BitwiseXorExpressionContext ctx);

  /// Enter a parse tree produced by the [additiveExpression]
  /// labeled alternative in [file.parserName>.expression].
  /// [ctx] the parse tree
  void enterAdditiveExpression(AdditiveExpressionContext ctx);
  /// Exit a parse tree produced by the [additiveExpression]
  /// labeled alternative in [OpenQASM3Parser.expression].
  /// [ctx] the parse tree
  void exitAdditiveExpression(AdditiveExpressionContext ctx);

  /// Enter a parse tree produced by the [durationofExpression]
  /// labeled alternative in [file.parserName>.expression].
  /// [ctx] the parse tree
  void enterDurationofExpression(DurationofExpressionContext ctx);
  /// Exit a parse tree produced by the [durationofExpression]
  /// labeled alternative in [OpenQASM3Parser.expression].
  /// [ctx] the parse tree
  void exitDurationofExpression(DurationofExpressionContext ctx);

  /// Enter a parse tree produced by the [parenthesisExpression]
  /// labeled alternative in [file.parserName>.expression].
  /// [ctx] the parse tree
  void enterParenthesisExpression(ParenthesisExpressionContext ctx);
  /// Exit a parse tree produced by the [parenthesisExpression]
  /// labeled alternative in [OpenQASM3Parser.expression].
  /// [ctx] the parse tree
  void exitParenthesisExpression(ParenthesisExpressionContext ctx);

  /// Enter a parse tree produced by the [comparisonExpression]
  /// labeled alternative in [file.parserName>.expression].
  /// [ctx] the parse tree
  void enterComparisonExpression(ComparisonExpressionContext ctx);
  /// Exit a parse tree produced by the [comparisonExpression]
  /// labeled alternative in [OpenQASM3Parser.expression].
  /// [ctx] the parse tree
  void exitComparisonExpression(ComparisonExpressionContext ctx);

  /// Enter a parse tree produced by the [multiplicativeExpression]
  /// labeled alternative in [file.parserName>.expression].
  /// [ctx] the parse tree
  void enterMultiplicativeExpression(MultiplicativeExpressionContext ctx);
  /// Exit a parse tree produced by the [multiplicativeExpression]
  /// labeled alternative in [OpenQASM3Parser.expression].
  /// [ctx] the parse tree
  void exitMultiplicativeExpression(MultiplicativeExpressionContext ctx);

  /// Enter a parse tree produced by the [logicalOrExpression]
  /// labeled alternative in [file.parserName>.expression].
  /// [ctx] the parse tree
  void enterLogicalOrExpression(LogicalOrExpressionContext ctx);
  /// Exit a parse tree produced by the [logicalOrExpression]
  /// labeled alternative in [OpenQASM3Parser.expression].
  /// [ctx] the parse tree
  void exitLogicalOrExpression(LogicalOrExpressionContext ctx);

  /// Enter a parse tree produced by the [castExpression]
  /// labeled alternative in [file.parserName>.expression].
  /// [ctx] the parse tree
  void enterCastExpression(CastExpressionContext ctx);
  /// Exit a parse tree produced by the [castExpression]
  /// labeled alternative in [OpenQASM3Parser.expression].
  /// [ctx] the parse tree
  void exitCastExpression(CastExpressionContext ctx);

  /// Enter a parse tree produced by the [powerExpression]
  /// labeled alternative in [file.parserName>.expression].
  /// [ctx] the parse tree
  void enterPowerExpression(PowerExpressionContext ctx);
  /// Exit a parse tree produced by the [powerExpression]
  /// labeled alternative in [OpenQASM3Parser.expression].
  /// [ctx] the parse tree
  void exitPowerExpression(PowerExpressionContext ctx);

  /// Enter a parse tree produced by the [bitwiseOrExpression]
  /// labeled alternative in [file.parserName>.expression].
  /// [ctx] the parse tree
  void enterBitwiseOrExpression(BitwiseOrExpressionContext ctx);
  /// Exit a parse tree produced by the [bitwiseOrExpression]
  /// labeled alternative in [OpenQASM3Parser.expression].
  /// [ctx] the parse tree
  void exitBitwiseOrExpression(BitwiseOrExpressionContext ctx);

  /// Enter a parse tree produced by the [callExpression]
  /// labeled alternative in [file.parserName>.expression].
  /// [ctx] the parse tree
  void enterCallExpression(CallExpressionContext ctx);
  /// Exit a parse tree produced by the [callExpression]
  /// labeled alternative in [OpenQASM3Parser.expression].
  /// [ctx] the parse tree
  void exitCallExpression(CallExpressionContext ctx);

  /// Enter a parse tree produced by the [bitshiftExpression]
  /// labeled alternative in [file.parserName>.expression].
  /// [ctx] the parse tree
  void enterBitshiftExpression(BitshiftExpressionContext ctx);
  /// Exit a parse tree produced by the [bitshiftExpression]
  /// labeled alternative in [OpenQASM3Parser.expression].
  /// [ctx] the parse tree
  void exitBitshiftExpression(BitshiftExpressionContext ctx);

  /// Enter a parse tree produced by the [bitwiseAndExpression]
  /// labeled alternative in [file.parserName>.expression].
  /// [ctx] the parse tree
  void enterBitwiseAndExpression(BitwiseAndExpressionContext ctx);
  /// Exit a parse tree produced by the [bitwiseAndExpression]
  /// labeled alternative in [OpenQASM3Parser.expression].
  /// [ctx] the parse tree
  void exitBitwiseAndExpression(BitwiseAndExpressionContext ctx);

  /// Enter a parse tree produced by the [equalityExpression]
  /// labeled alternative in [file.parserName>.expression].
  /// [ctx] the parse tree
  void enterEqualityExpression(EqualityExpressionContext ctx);
  /// Exit a parse tree produced by the [equalityExpression]
  /// labeled alternative in [OpenQASM3Parser.expression].
  /// [ctx] the parse tree
  void exitEqualityExpression(EqualityExpressionContext ctx);

  /// Enter a parse tree produced by the [logicalAndExpression]
  /// labeled alternative in [file.parserName>.expression].
  /// [ctx] the parse tree
  void enterLogicalAndExpression(LogicalAndExpressionContext ctx);
  /// Exit a parse tree produced by the [logicalAndExpression]
  /// labeled alternative in [OpenQASM3Parser.expression].
  /// [ctx] the parse tree
  void exitLogicalAndExpression(LogicalAndExpressionContext ctx);

  /// Enter a parse tree produced by the [indexExpression]
  /// labeled alternative in [file.parserName>.expression].
  /// [ctx] the parse tree
  void enterIndexExpression(IndexExpressionContext ctx);
  /// Exit a parse tree produced by the [indexExpression]
  /// labeled alternative in [OpenQASM3Parser.expression].
  /// [ctx] the parse tree
  void exitIndexExpression(IndexExpressionContext ctx);

  /// Enter a parse tree produced by the [unaryExpression]
  /// labeled alternative in [file.parserName>.expression].
  /// [ctx] the parse tree
  void enterUnaryExpression(UnaryExpressionContext ctx);
  /// Exit a parse tree produced by the [unaryExpression]
  /// labeled alternative in [OpenQASM3Parser.expression].
  /// [ctx] the parse tree
  void exitUnaryExpression(UnaryExpressionContext ctx);

  /// Enter a parse tree produced by the [literalExpression]
  /// labeled alternative in [file.parserName>.expression].
  /// [ctx] the parse tree
  void enterLiteralExpression(LiteralExpressionContext ctx);
  /// Exit a parse tree produced by the [literalExpression]
  /// labeled alternative in [OpenQASM3Parser.expression].
  /// [ctx] the parse tree
  void exitLiteralExpression(LiteralExpressionContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.aliasExpression].
  /// [ctx] the parse tree
  void enterAliasExpression(AliasExpressionContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.aliasExpression].
  /// [ctx] the parse tree
  void exitAliasExpression(AliasExpressionContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.declarationExpression].
  /// [ctx] the parse tree
  void enterDeclarationExpression(DeclarationExpressionContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.declarationExpression].
  /// [ctx] the parse tree
  void exitDeclarationExpression(DeclarationExpressionContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.measureExpression].
  /// [ctx] the parse tree
  void enterMeasureExpression(MeasureExpressionContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.measureExpression].
  /// [ctx] the parse tree
  void exitMeasureExpression(MeasureExpressionContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.rangeExpression].
  /// [ctx] the parse tree
  void enterRangeExpression(RangeExpressionContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.rangeExpression].
  /// [ctx] the parse tree
  void exitRangeExpression(RangeExpressionContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.setExpression].
  /// [ctx] the parse tree
  void enterSetExpression(SetExpressionContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.setExpression].
  /// [ctx] the parse tree
  void exitSetExpression(SetExpressionContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.arrayLiteral].
  /// [ctx] the parse tree
  void enterArrayLiteral(ArrayLiteralContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.arrayLiteral].
  /// [ctx] the parse tree
  void exitArrayLiteral(ArrayLiteralContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.indexOperator].
  /// [ctx] the parse tree
  void enterIndexOperator(IndexOperatorContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.indexOperator].
  /// [ctx] the parse tree
  void exitIndexOperator(IndexOperatorContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.indexedIdentifier].
  /// [ctx] the parse tree
  void enterIndexedIdentifier(IndexedIdentifierContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.indexedIdentifier].
  /// [ctx] the parse tree
  void exitIndexedIdentifier(IndexedIdentifierContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.returnSignature].
  /// [ctx] the parse tree
  void enterReturnSignature(ReturnSignatureContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.returnSignature].
  /// [ctx] the parse tree
  void exitReturnSignature(ReturnSignatureContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.gateModifier].
  /// [ctx] the parse tree
  void enterGateModifier(GateModifierContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.gateModifier].
  /// [ctx] the parse tree
  void exitGateModifier(GateModifierContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.scalarType].
  /// [ctx] the parse tree
  void enterScalarType(ScalarTypeContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.scalarType].
  /// [ctx] the parse tree
  void exitScalarType(ScalarTypeContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.qubitType].
  /// [ctx] the parse tree
  void enterQubitType(QubitTypeContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.qubitType].
  /// [ctx] the parse tree
  void exitQubitType(QubitTypeContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.arrayType].
  /// [ctx] the parse tree
  void enterArrayType(ArrayTypeContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.arrayType].
  /// [ctx] the parse tree
  void exitArrayType(ArrayTypeContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.arrayReferenceType].
  /// [ctx] the parse tree
  void enterArrayReferenceType(ArrayReferenceTypeContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.arrayReferenceType].
  /// [ctx] the parse tree
  void exitArrayReferenceType(ArrayReferenceTypeContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.designator].
  /// [ctx] the parse tree
  void enterDesignator(DesignatorContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.designator].
  /// [ctx] the parse tree
  void exitDesignator(DesignatorContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.defcalTarget].
  /// [ctx] the parse tree
  void enterDefcalTarget(DefcalTargetContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.defcalTarget].
  /// [ctx] the parse tree
  void exitDefcalTarget(DefcalTargetContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.defcalArgumentDefinition].
  /// [ctx] the parse tree
  void enterDefcalArgumentDefinition(DefcalArgumentDefinitionContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.defcalArgumentDefinition].
  /// [ctx] the parse tree
  void exitDefcalArgumentDefinition(DefcalArgumentDefinitionContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.defcalOperand].
  /// [ctx] the parse tree
  void enterDefcalOperand(DefcalOperandContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.defcalOperand].
  /// [ctx] the parse tree
  void exitDefcalOperand(DefcalOperandContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.gateOperand].
  /// [ctx] the parse tree
  void enterGateOperand(GateOperandContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.gateOperand].
  /// [ctx] the parse tree
  void exitGateOperand(GateOperandContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.externArgument].
  /// [ctx] the parse tree
  void enterExternArgument(ExternArgumentContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.externArgument].
  /// [ctx] the parse tree
  void exitExternArgument(ExternArgumentContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.argumentDefinition].
  /// [ctx] the parse tree
  void enterArgumentDefinition(ArgumentDefinitionContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.argumentDefinition].
  /// [ctx] the parse tree
  void exitArgumentDefinition(ArgumentDefinitionContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.argumentDefinitionList].
  /// [ctx] the parse tree
  void enterArgumentDefinitionList(ArgumentDefinitionListContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.argumentDefinitionList].
  /// [ctx] the parse tree
  void exitArgumentDefinitionList(ArgumentDefinitionListContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.defcalArgumentDefinitionList].
  /// [ctx] the parse tree
  void enterDefcalArgumentDefinitionList(DefcalArgumentDefinitionListContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.defcalArgumentDefinitionList].
  /// [ctx] the parse tree
  void exitDefcalArgumentDefinitionList(DefcalArgumentDefinitionListContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.defcalOperandList].
  /// [ctx] the parse tree
  void enterDefcalOperandList(DefcalOperandListContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.defcalOperandList].
  /// [ctx] the parse tree
  void exitDefcalOperandList(DefcalOperandListContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.expressionList].
  /// [ctx] the parse tree
  void enterExpressionList(ExpressionListContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.expressionList].
  /// [ctx] the parse tree
  void exitExpressionList(ExpressionListContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.identifierList].
  /// [ctx] the parse tree
  void enterIdentifierList(IdentifierListContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.identifierList].
  /// [ctx] the parse tree
  void exitIdentifierList(IdentifierListContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.gateOperandList].
  /// [ctx] the parse tree
  void enterGateOperandList(GateOperandListContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.gateOperandList].
  /// [ctx] the parse tree
  void exitGateOperandList(GateOperandListContext ctx);

  /// Enter a parse tree produced by [OpenQASM3Parser.externArgumentList].
  /// [ctx] the parse tree
  void enterExternArgumentList(ExternArgumentListContext ctx);
  /// Exit a parse tree produced by [OpenQASM3Parser.externArgumentList].
  /// [ctx] the parse tree
  void exitExternArgumentList(ExternArgumentListContext ctx);
}