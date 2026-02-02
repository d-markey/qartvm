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
  int scan(Program program) {
    int totalQubits = 0;

    void _scanStatements(List<Statement> stmts) {
      for (final statement in stmts) {
        if (statement is QubitDeclaration) {
          final sizeExpr = statement.type.designator;
          final size = sizeExpr != null
              ? evaluator.evaluate(sizeExpr) as int
              : 1;
          totalQubits += size;
        } else if (statement is ConstantDeclaration) {
          final value = evaluator.evaluate(statement.value);
          context.symbols.declareConstant(statement.name, value);
        } else if (statement is FlowStatement) {
          _scanStatements(statement.body);
          if (statement is IfStatement && statement.elseBody != null) {
            _scanStatements(statement.elseBody!);
          }
        }
      }
    }

    _scanStatements(program.statements);
    return totalQubits;
  }
}
