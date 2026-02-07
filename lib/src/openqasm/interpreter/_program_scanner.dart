import '../parser/ast_nodes.dart';
import '_execution_context.dart';
import '_expression_evaluator.dart';

/// Pre-scans OpenQASM programs for qubit declarations and constants.
class ProgramScanner {
  ProgramScanner(this.context, this.evaluator);

  final ExecutionContext context;
  final ExpressionEvaluator evaluator;

  /// Scans the given [program] and registers constants in the context.
  /// Returns the total number of qubits declared.
  Future<int> scan(Program program) async {
    int totalQubits = 0;

    Future<void> _scanStatements(List<Statement> stmts) async {
      for (final statement in stmts) {
        if (statement is QubitDeclaration) {
          final sizeExpr = statement.type.designator;
          final size = sizeExpr != null
              ? await evaluator.evaluate(sizeExpr) as int
              : 1;
          totalQubits += size;
        } else if (statement is ConstantDeclaration) {
          final value = await evaluator.evaluate(statement.value);
          context.symbols.declareConstant(statement.name, value);
        } else if (statement is IfStatement) {
          await _scanStatements(statement.ifBody);
          if (statement.elseBody != null) {
            await _scanStatements(statement.elseBody!);
          }
        } else if (statement is WhileStatement) {
          await _scanStatements(statement.body);
        } else if (statement is ForStatement) {
          await _scanStatements(statement.body);
        }
      }
    }

    await _scanStatements(program.statements);
    return totalQubits;
  }
}
