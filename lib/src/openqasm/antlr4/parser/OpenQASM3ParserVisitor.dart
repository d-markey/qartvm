// Generated from C:\_Projects\github\qartvm\tools\antlr4\\OpenQASM3Parser.g4 by ANTLR 4.12.0
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes
import 'package:antlr4/antlr4.dart';

import 'OpenQASM3Parser.dart';

/// This abstract class defines a complete generic visitor for a parse tree
/// produced by [OpenQASM3Parser].
///
/// [T] is the eturn type of the visit operation. Use `void` for
/// operations with no return type.
abstract class OpenQASM3ParserVisitor<T> extends ParseTreeVisitor<T> {
  /// Visit a parse tree produced by [OpenQASM3Parser.program].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitProgram(ProgramContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.version].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitVersion(VersionContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.statement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitStatement(StatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.annotation].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitAnnotation(AnnotationContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.scope].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitScope(ScopeContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.pragma].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitPragma(PragmaContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.statementOrScope].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitStatementOrScope(StatementOrScopeContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.calibrationGrammarStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitCalibrationGrammarStatement(CalibrationGrammarStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.includeStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitIncludeStatement(IncludeStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.breakStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitBreakStatement(BreakStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.continueStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitContinueStatement(ContinueStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.endStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitEndStatement(EndStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.forStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitForStatement(ForStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.ifStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitIfStatement(IfStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.returnStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitReturnStatement(ReturnStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.whileStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitWhileStatement(WhileStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.barrierStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitBarrierStatement(BarrierStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.boxStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitBoxStatement(BoxStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.delayStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitDelayStatement(DelayStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.gateCallStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitGateCallStatement(GateCallStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.measureArrowAssignmentStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitMeasureArrowAssignmentStatement(MeasureArrowAssignmentStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.resetStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitResetStatement(ResetStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.aliasDeclarationStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitAliasDeclarationStatement(AliasDeclarationStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.classicalDeclarationStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitClassicalDeclarationStatement(ClassicalDeclarationStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.constDeclarationStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitConstDeclarationStatement(ConstDeclarationStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.ioDeclarationStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitIoDeclarationStatement(IoDeclarationStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.oldStyleDeclarationStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitOldStyleDeclarationStatement(OldStyleDeclarationStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.quantumDeclarationStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitQuantumDeclarationStatement(QuantumDeclarationStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.defStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitDefStatement(DefStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.externStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitExternStatement(ExternStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.gateStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitGateStatement(GateStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.assignmentStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitAssignmentStatement(AssignmentStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.expressionStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitExpressionStatement(ExpressionStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.calStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitCalStatement(CalStatementContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.defcalStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitDefcalStatement(DefcalStatementContext ctx);

  /// Visit a parse tree produced by the {@code bitwiseXorExpression}
  /// labeled alternative in {@link OpenQASM3Parser#expression}.
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitBitwiseXorExpression(BitwiseXorExpressionContext ctx);

  /// Visit a parse tree produced by the {@code additiveExpression}
  /// labeled alternative in {@link OpenQASM3Parser#expression}.
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitAdditiveExpression(AdditiveExpressionContext ctx);

  /// Visit a parse tree produced by the {@code durationofExpression}
  /// labeled alternative in {@link OpenQASM3Parser#expression}.
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitDurationofExpression(DurationofExpressionContext ctx);

  /// Visit a parse tree produced by the {@code parenthesisExpression}
  /// labeled alternative in {@link OpenQASM3Parser#expression}.
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitParenthesisExpression(ParenthesisExpressionContext ctx);

  /// Visit a parse tree produced by the {@code comparisonExpression}
  /// labeled alternative in {@link OpenQASM3Parser#expression}.
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitComparisonExpression(ComparisonExpressionContext ctx);

  /// Visit a parse tree produced by the {@code multiplicativeExpression}
  /// labeled alternative in {@link OpenQASM3Parser#expression}.
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitMultiplicativeExpression(MultiplicativeExpressionContext ctx);

  /// Visit a parse tree produced by the {@code logicalOrExpression}
  /// labeled alternative in {@link OpenQASM3Parser#expression}.
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitLogicalOrExpression(LogicalOrExpressionContext ctx);

  /// Visit a parse tree produced by the {@code castExpression}
  /// labeled alternative in {@link OpenQASM3Parser#expression}.
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitCastExpression(CastExpressionContext ctx);

  /// Visit a parse tree produced by the {@code powerExpression}
  /// labeled alternative in {@link OpenQASM3Parser#expression}.
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitPowerExpression(PowerExpressionContext ctx);

  /// Visit a parse tree produced by the {@code bitwiseOrExpression}
  /// labeled alternative in {@link OpenQASM3Parser#expression}.
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitBitwiseOrExpression(BitwiseOrExpressionContext ctx);

  /// Visit a parse tree produced by the {@code callExpression}
  /// labeled alternative in {@link OpenQASM3Parser#expression}.
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitCallExpression(CallExpressionContext ctx);

  /// Visit a parse tree produced by the {@code bitshiftExpression}
  /// labeled alternative in {@link OpenQASM3Parser#expression}.
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitBitshiftExpression(BitshiftExpressionContext ctx);

  /// Visit a parse tree produced by the {@code bitwiseAndExpression}
  /// labeled alternative in {@link OpenQASM3Parser#expression}.
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitBitwiseAndExpression(BitwiseAndExpressionContext ctx);

  /// Visit a parse tree produced by the {@code equalityExpression}
  /// labeled alternative in {@link OpenQASM3Parser#expression}.
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitEqualityExpression(EqualityExpressionContext ctx);

  /// Visit a parse tree produced by the {@code logicalAndExpression}
  /// labeled alternative in {@link OpenQASM3Parser#expression}.
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitLogicalAndExpression(LogicalAndExpressionContext ctx);

  /// Visit a parse tree produced by the {@code indexExpression}
  /// labeled alternative in {@link OpenQASM3Parser#expression}.
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitIndexExpression(IndexExpressionContext ctx);

  /// Visit a parse tree produced by the {@code unaryExpression}
  /// labeled alternative in {@link OpenQASM3Parser#expression}.
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitUnaryExpression(UnaryExpressionContext ctx);

  /// Visit a parse tree produced by the {@code literalExpression}
  /// labeled alternative in {@link OpenQASM3Parser#expression}.
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitLiteralExpression(LiteralExpressionContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.aliasExpression].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitAliasExpression(AliasExpressionContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.declarationExpression].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitDeclarationExpression(DeclarationExpressionContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.measureExpression].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitMeasureExpression(MeasureExpressionContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.rangeExpression].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitRangeExpression(RangeExpressionContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.setExpression].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitSetExpression(SetExpressionContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.arrayLiteral].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitArrayLiteral(ArrayLiteralContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.indexOperator].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitIndexOperator(IndexOperatorContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.indexedIdentifier].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitIndexedIdentifier(IndexedIdentifierContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.returnSignature].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitReturnSignature(ReturnSignatureContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.gateModifier].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitGateModifier(GateModifierContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.scalarType].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitScalarType(ScalarTypeContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.qubitType].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitQubitType(QubitTypeContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.arrayType].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitArrayType(ArrayTypeContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.arrayReferenceType].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitArrayReferenceType(ArrayReferenceTypeContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.designator].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitDesignator(DesignatorContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.defcalTarget].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitDefcalTarget(DefcalTargetContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.defcalArgumentDefinition].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitDefcalArgumentDefinition(DefcalArgumentDefinitionContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.defcalOperand].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitDefcalOperand(DefcalOperandContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.gateOperand].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitGateOperand(GateOperandContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.externArgument].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitExternArgument(ExternArgumentContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.argumentDefinition].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitArgumentDefinition(ArgumentDefinitionContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.argumentDefinitionList].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitArgumentDefinitionList(ArgumentDefinitionListContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.defcalArgumentDefinitionList].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitDefcalArgumentDefinitionList(DefcalArgumentDefinitionListContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.defcalOperandList].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitDefcalOperandList(DefcalOperandListContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.expressionList].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitExpressionList(ExpressionListContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.identifierList].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitIdentifierList(IdentifierListContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.gateOperandList].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitGateOperandList(GateOperandListContext ctx);

  /// Visit a parse tree produced by [OpenQASM3Parser.externArgumentList].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitExternArgumentList(ExternArgumentListContext ctx);
}