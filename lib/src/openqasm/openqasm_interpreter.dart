import '../qmemory_space.dart';
import 'parser/ast_nodes.dart';
import 'interpreter/_execution_context.dart';
import 'interpreter/interpreter_result.dart';
import 'interpreter/_expression_evaluator.dart';
import 'interpreter/_gate_mapper.dart';
import 'interpreter/_qbit_resolver.dart';
import 'interpreter/_flow_exceptions.dart';
import 'interpreter/_program_scanner.dart';
import 'interpreter/_range_result.dart';
import 'interpreter/exceptions.dart';

/// OpenQASM 3.0 interpreter that executes parsed programs.
class OpenQASMInterpreter {
  OpenQASMInterpreter();

  late ExpressionEvaluator _evaluator;
  late GateMapper _gateMapper;
  late QbitResolver _qbitResolver;

  /// Executes the given [program] and returns the result.
  InterpreterResult execute(Program program) {
    // Create execution context
    final context = ExecutionContext();
    _evaluator = ExpressionEvaluator(context, (statements) {
      for (final statement in statements) {
        _executeStatement(statement, context);
      }
    });
    _gateMapper = GateMapper(context, _evaluator);
    _qbitResolver = QbitResolver(context, _evaluator.evaluate);

    // Process version if specified
    if (program.version != null) {
      _checkVersion(program.version!);
    }

    // 1. Pre-scan for total qubit count and constants
    final scanner = ProgramScanner(context, _evaluator);
    final totalQubits = scanner.scan(program);

    // Initialize quantum memory if needed
    if (totalQubits > 0) {
      context.quantumMemory = QMemorySpace.zero(totalQubits);
    }

    // Reset context state (except quantum memory) for the actual execution
    context.resetForExecution();

    // 2. Actual execution
    // Execute all statements in order
    for (final statement in program.statements) {
      _executeStatement(statement, context);
    }

    // Collect results
    final measurements = <String, int>{};
    // TODO: Extract measurement results from context

    return InterpreterResult(
      quantumMemory:
          context.quantumMemory, // Nullable - null if no qubits declared
      classicalVariables: context.getAllVariables(),
      measurements: measurements,
    );
  }

  /// Checks that the OpenQASM version is supported.
  void _checkVersion(Version version) {
    if (!version.version.startsWith('3.')) {
      throw InterpreterException(
        'Unsupported OpenQASM version: ${version.version}. '
        'Only version 3.x is supported.',
      );
    }
  }

  /// Executes a single statement.
  void _executeStatement(Statement statement, ExecutionContext context) {
    switch (statement) {
      case QubitDeclaration e:
        _executeQubitDeclaration(e, context);
      case ClassicalDeclaration e:
        _executeClassicalDeclaration(e, context);
      case GateCallStatement e:
        _executeGateCall(e, context);
      case MeasurementStatement e:
        _executeMeasurement(e, context);
      case ResetStatement e:
        _executeReset(e, context);
      case BarrierStatement e:
        _executeBarrier(e, context);
      case AssignmentStatement e:
        _executeAssignment(e, context);
      case IfStatement e:
        _executeIf(e, context);
      case ForStatement e:
        _executeFor(e, context);
      case WhileStatement e:
        _executeWhile(e, context);
      case BreakStatement():
        throw BreakException();
      case ContinueStatement():
        throw ContinueException();
      case ReturnStatement e:
        throw ReturnException(_evaluator.evaluate(e.expression));
      case GateStatement e:
        _executeGateDefinition(e, context);
      case SubroutineDefinition e:
        _executeSubroutineDefinition(e, context);
      case IncludeStatement e:
        _executeInclude(e, context);
      case AliasStatement e:
        _executeAlias(e, context);
      case ConstantDeclaration e:
        _executeConstant(e, context);
      case IOStatement e:
        _executeIO(e, context);
      case ExternStatement e:
        _executeExtern(e, context);
      case ExpressionStatement e:
        _executeExpressionStatement(e, context);
      default:
        throw InterpreterException(
          'Unknown statement type: ${statement.runtimeType}',
        );
    }
  }

  // Statement execution methods

  void _executeQubitDeclaration(
    QubitDeclaration stmt,
    ExecutionContext context,
  ) {
    final sizeExpr = stmt.type.designator;
    final sizeValue = sizeExpr != null
        ? _evaluator.evaluate(sizeExpr) as int
        : 1;

    context.declareQubitRegister(stmt.name, sizeValue);
  }

  void _executeClassicalDeclaration(
    ClassicalDeclaration stmt,
    ExecutionContext context,
  ) {
    final value = stmt.initializer != null
        ? _evaluator.evaluate(stmt.initializer)
        : null;

    context.declareClassicalVariable(stmt.name, stmt.type, value);
  }

  void _executeGateCall(GateCallStatement stmt, ExecutionContext context) {
    _gateMapper.executeGateCall(stmt);
  }

  void _executeMeasurement(
    MeasurementStatement stmt,
    ExecutionContext context,
  ) {
    final qubits = _qbitResolver.resolve(stmt.measureExpression);
    if (qubits.isEmpty) return;

    final qmem = context.quantumMemory;
    if (qmem == null) {
      throw InterpreterException('Cannot measure: no quantum memory');
    }

    final value = qmem.read(qubits: qubits);

    if (stmt.targetIdentifier != null) {
      context.updateVariable(stmt.targetIdentifier!, value);
    }
  }

  void _executeReset(ResetStatement stmt, ExecutionContext context) {
    final qubits = _qbitResolver.resolve(stmt.qubit);
    final qmem = context.quantumMemory;
    if (qmem == null) return;

    for (final q in qubits) {
      final value = qmem.read(qubits: [q]);
      if (value == 1) {
        _gateMapper.applyGate('x', [q], null, null);
      }
    }
  }

  void _executeBarrier(BarrierStatement stmt, ExecutionContext context) {
    // Barrier is a no-op in simulation
  }

  void _executeAssignment(AssignmentStatement stmt, ExecutionContext context) {
    var value = _evaluator.evaluate(stmt.value);

    // If the value is a MeasureExpression, it was evaluated by _evaluator.evaluate
    // which calls _evaluateMeasure.

    final target = stmt.target;
    if (target is IdentifierExpression) {
      final name = target.name;
      if (stmt.operator == '=') {
        context.updateVariable(name, value);
      } else {
        final currentValue = context.getVariable(name);
        final newValue = _applyCompoundOperator(
          stmt.operator,
          currentValue,
          value,
        );
        context.updateVariable(name, newValue);
      }
    } else if (target is IndexExpression) {
      // TODO: Handle indexed assignment (e.g., arr[0] = 5)
      throw UnimplementedError('Indexed assignment not yet supported');
    }
  }

  dynamic _applyCompoundOperator(String op, dynamic left, dynamic right) {
    return switch (op) {
      '+=' => left + right,
      '-=' => left - right,
      '*=' => left * right,
      '/=' => left / right,
      '%=' => left % right,
      '<<=' => (left as int) << (right as int),
      '>>=' => (left as int) >> (right as int),
      '&=' => (left as int) & (right as int),
      '|=' => (left as int) | (right as int),
      '^=' => (left as int) ^ (right as int),
      _ => throw InterpreterException('Unknown assignment operator: $op'),
    };
  }

  void _executeIf(IfStatement stmt, ExecutionContext context) {
    if (_conditionToBool(stmt.condition, context)) {
      _executeWithScope(stmt.ifBody, context);
    } else if (stmt.elseBody != null) {
      _executeWithScope(stmt.elseBody!, context);
    }
  }

  void _executeWithScope(List<Statement> body, ExecutionContext context) {
    context.pushScope();
    try {
      for (final s in body) {
        _executeStatement(s, context);
      }
    } finally {
      context.popScope();
    }
  }

  void _executeFor(ForStatement stmt, ExecutionContext context) {
    final rangeValue = _evaluator.evaluate(stmt.range);
    final Iterable<dynamic> values = switch (rangeValue) {
      RangeResult r => r.values,
      Iterable r => r,
      _ => throw InterpreterException(
        'For loop range must be an iterable or range, got $rangeValue',
      ),
    };

    for (final val in values) {
      final shouldBreak = _executeLoopBody(
        stmt.body,
        context,
        onScopeEnter: () {
          context.declareClassicalVariable(
            stmt.loopVariable,
            stmt.variableType,
            val,
          );
        },
      );
      if (shouldBreak) break;
    }
  }

  void _executeWhile(WhileStatement stmt, ExecutionContext context) {
    while (_conditionToBool(stmt.condition, context)) {
      final shouldBreak = _executeLoopBody(stmt.body, context);
      if (shouldBreak) break;
    }
  }

  /// Executes a loop body, handling break/continue exceptions.
  /// Returns true if the loop should break, false otherwise.
  bool _executeLoopBody(
    List<Statement> body,
    ExecutionContext context, {
    void Function()? onScopeEnter,
  }) {
    context.pushScope();
    if (onScopeEnter != null) onScopeEnter();
    try {
      try {
        for (final statement in body) {
          _executeStatement(statement, context);
        }
      } catch (e) {
        if (e is BreakException) {
          return true; // Signal to break the loop
        } else if (e is ContinueException) {
          return false; // Signal to continue (not break)
        }
        rethrow;
      }
      return false; // Normal completion
    } finally {
      context.popScope();
    }
  }

  bool _conditionToBool(Expression condition, ExecutionContext context) {
    final result = _evaluator.evaluate(condition);
    return ExpressionEvaluator.toBool(result);
  }

  void _executeGateDefinition(GateStatement stmt, ExecutionContext context) {
    context.symbols.declareGate(stmt.name, stmt);
  }

  void _executeSubroutineDefinition(
    SubroutineDefinition stmt,
    ExecutionContext context,
  ) {
    context.symbols.declareSubroutine(stmt.name, stmt);
  }

  void _executeInclude(IncludeStatement stmt, ExecutionContext context) {
    throw UnimplementedError('IncludeStatement not yet implemented');
  }

  void _executeAlias(AliasStatement stmt, ExecutionContext context) {
    throw UnimplementedError('AliasStatement not yet implemented');
  }

  void _executeConstant(ConstantDeclaration stmt, ExecutionContext context) {
    final value = _evaluator.evaluate(stmt.value);
    context.symbols.declareConstant(stmt.name, value);
  }

  void _executeIO(IOStatement stmt, ExecutionContext context) {
    // IO statements are no-ops in simulation
  }

  void _executeExtern(ExternStatement stmt, ExecutionContext context) {
    // Extern declarations are no-ops
  }

  void _executeExpressionStatement(
    ExpressionStatement stmt,
    ExecutionContext context,
  ) {
    _evaluator.evaluate(stmt.expression);
  }
}
