import '../qmemory_space.dart';
import 'interpreter/_execution_context.dart';
import 'interpreter/_expression_evaluator.dart';
import 'interpreter/_flow_exceptions.dart';
import 'interpreter/_gate_mapper.dart';
import 'interpreter/_program_scanner.dart';
import 'interpreter/_qbit_resolver.dart';
import 'interpreter/_range_result.dart';
import 'interpreter/_standard_gate_executors.dart';
import 'interpreter/exceptions.dart';
import 'interpreter/interpreter_result.dart';
import 'interpreter/openqasm_include_provider.dart';
import 'openqasm_parser.dart';
import 'parser/ast_nodes.dart';

/// OpenQASM 3.0 interpreter that executes parsed programs.
class OpenQASMInterpreter {
  OpenQASMInterpreter({OpenQASMIncludeProvider? includeProvider})
    : _includeProvider = includeProvider;

  final OpenQASMIncludeProvider? _includeProvider;

  late ExpressionEvaluator _evaluator;
  late GateMapper _gateMapper;
  late QbitResolver _qbitResolver;

  /// Executes the given [program] and returns the result.
  ///
  /// The [includeProvider] passed to the constructor is used to load
  /// any files referenced by `include` statements.
  Future<InterpreterResult> execute(Program program) async {
    // Create execution context
    final context = ExecutionContext();
    _evaluator = ExpressionEvaluator(context, (statements) {
      for (final statement in statements) {
        _executeStatement(statement, context);
      }
    });
    _gateMapper = GateMapper(
      context,
      _evaluator,
      statementExecutor: (statements, ctx) {
        for (final statement in statements) {
          _executeStatement(statement, ctx);
        }
      },
    );
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
    try {
      for (final statement in program.statements) {
        await _executeStatementAsync(statement, context);
      }
    } on EndException {
      // end of program decided by user, swallow the exception
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
    final ver = version.version;
    if (ver != '3' && !ver.startsWith('3.')) {
      throw InterpreterException(
        'Unsupported OpenQASM version: $ver. Only version 3.x is supported.',
      );
    }
  }

  /// Executes a single statement asynchronously.
  /// Handles include statements which require async file loading.
  Future<void> _executeStatementAsync(
    Statement statement,
    ExecutionContext context,
  ) async {
    if (statement is IncludeStatement) {
      await _executeInclude(statement, context);
    } else {
      _executeStatement(statement, context);
    }
  }

  /// Executes a single statement.
  void _executeStatement(Statement statement, ExecutionContext context) {
    switch (statement) {
      case QubitDeclaration():
        _executeQubitDeclaration(statement, context);
      case ClassicalDeclaration():
        _executeClassicalDeclaration(statement, context);
      case GateCallStatement():
        _executeGateCall(statement, context);
      case MeasurementStatement():
        _executeMeasurement(statement, context);
      case ResetStatement():
        _executeReset(statement, context);
      case BarrierStatement():
        _executeBarrier(statement, context);
      case AssignmentStatement():
        _executeAssignment(statement, context);
      case IfStatement():
        _executeIf(statement, context);
      case ForStatement():
        _executeFor(statement, context);
      case WhileStatement():
        _executeWhile(statement, context);
      case BreakStatement():
        throw BreakException();
      case ContinueStatement():
        throw ContinueException();
      case EndStatement():
        throw EndException();
      case ReturnStatement():
        throw ReturnException(_evaluator.evaluate(statement.expression));
      case GateStatement():
        _executeGateDefinition(statement, context);
      case SubroutineDefinition():
        _executeSubroutineDefinition(statement, context);
      case IncludeStatement():
        throw IncludeException(
          'Include statements must be executed asynchronously. '
          'Use executeAsync() instead of execute().',
          filename: statement.filename,
        );
      case AliasStatement():
        _executeAlias(statement, context);
      case ConstantDeclaration():
        _executeConstant(statement, context);
      case IOStatement():
        _executeIO(statement, context);
      case ExternStatement():
        _executeExtern(statement, context);
      case ExpressionStatement():
        _executeExpressionStatement(statement, context);
      default:
        throw InterpreterException(
          'Unsupported statement type: ${statement.runtimeType}',
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
    var value = stmt.initializer != null
        ? _evaluator.evaluate(stmt.initializer)
        : null;

    // If the type is a ScalarTypeNode with a designator, initialize as an array
    if (stmt.type is ScalarTypeNode) {
      final scalarType = stmt.type as ScalarTypeNode;
      if (scalarType.designator != null && value == null) {
        // Evaluate the designator to get the array size
        final sizeValue = _evaluator.evaluate(scalarType.designator!);
        if (sizeValue is num) {
          final size = sizeValue.toInt();
          // Initialize array with size, filled with 0s for now
          value = List<int>.filled(size, 0);
        } else {
          value = [];
        }
      }
    }

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
      // Handle indexed assignment (e.g., arr[0] = 5, arr[i][j] += 1)
      final indices = <int>[];

      // Extract all indices from the IndexExpression
      for (final indexExpr in target.indices) {
        indices.add(_evaluator.evaluate(indexExpr) as int);
      }

      // Get variable name from the base expression
      final baseExpr = target.expression;
      if (baseExpr is! IdentifierExpression) {
        throw InterpreterException(
          'Invalid assignment target: must be array access',
        );
      }
      final varName = baseExpr.name;

      // Get the array/container
      var container = context.getVariable(varName);

      // Handle multi-dimensional arrays - navigate to the target element
      for (int i = 0; i < indices.length - 1; i++) {
        if (container is! List<dynamic>) {
          throw InterpreterException(
            'Cannot index into non-array value at dimension $i',
          );
        }
        final list = container;
        final idx = indices[i];

        // Ensure the list is large enough
        while (list.length <= idx) {
          list.add(null);
        }
        container = list[idx];
      }

      final lastIndex = indices.last;

      // The final container should be a list
      if (container is! List<dynamic>) {
        throw InterpreterException(
          'Cannot index into non-array value. Expected List but got ${container.runtimeType}',
        );
      }

      final list = container;

      // Ensure the list is large enough for the assignment
      while (list.length <= lastIndex) {
        list.add(null);
      }

      if (stmt.operator == '=') {
        list[lastIndex] = value;
      } else {
        final currentValue = list[lastIndex];
        final newValue = _applyCompoundOperator(
          stmt.operator,
          currentValue,
          value,
        );
        list[lastIndex] = newValue;
      }
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
          final varType = stmt.variableType;
          if (varType != null) {
            context.declareClassicalVariable(stmt.loopVariable, varType, val);
          }
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
    onScopeEnter?.call();
    try {
      for (final statement in body) {
        _executeStatement(statement, context);
      }
      return false; // Normal completion
    } on BreakException {
      return true; // Signal to break the loop
    } on ContinueException {
      return false; // Signal to continue (not break)
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

  /// Executes an include statement by loading the file and parsing/executing its contents.
  Future<void> _executeInclude(
    IncludeStatement stmt,
    ExecutionContext context,
  ) async {
    // Special case for standard gates: register built-in gates without loading from a provider
    if (stmt.filename == 'stdgates.inc') {
      _registerStandardGates(context);
      return;
    }

    if (_includeProvider == null) {
      throw IncludeException(
        'Missing provider to include file',
        filename: stmt.filename,
      );
    }

    try {
      // Load the include file using the provider
      final fileContents = await _includeProvider.loadIncludeFile(
        stmt.filename,
      );

      // Parse the included file
      final includedProgram = OpenQASMParser.parse(fileContents);

      // Execute the included program's statements in the current context
      for (final statement in includedProgram.statements) {
        await _executeStatementAsync(statement, context);
      }
    } on IncludeException {
      rethrow;
    } catch (e) {
      throw IncludeException(
        'Error loading include file: $e',
        filename: stmt.filename,
      );
    }
  }

  /// Registers standard OpenQASM gates as executors.
  /// This is called when `include "stdgates.inc"` is processed.
  /// At this point, quantum memory has been initialized with the correct size.
  void _registerStandardGates(ExecutionContext context) {
    final qmem = context.quantumMemory;
    if (qmem == null) {
      throw InterpreterException(
        'Cannot register standard gates: quantum memory not initialized',
      );
    }

    // Single-qubit gates
    context.symbols.registerGateExecutor('id', IdGateExecutor(qmem));
    context.symbols.registerGateExecutor('h', HGateExecutor(qmem));
    context.symbols.registerGateExecutor('x', XGateExecutor(qmem));
    context.symbols.registerGateExecutor('y', YGateExecutor(qmem));
    context.symbols.registerGateExecutor('z', ZGateExecutor(qmem));
    context.symbols.registerGateExecutor('s', SGateExecutor(qmem));
    context.symbols.registerGateExecutor('t', TGateExecutor(qmem));
    context.symbols.registerGateExecutor('sdg', SdgGateExecutor(qmem));
    context.symbols.registerGateExecutor('tdg', TdgGateExecutor(qmem));
    context.symbols.registerGateExecutor('sx', SXGateExecutor(qmem));

    // Parameterized single-qubit gates
    context.symbols.registerGateExecutor('rx', RXGateExecutor(qmem));
    context.symbols.registerGateExecutor('ry', RYGateExecutor(qmem));
    context.symbols.registerGateExecutor('rz', RZGateExecutor(qmem));
    context.symbols.registerGateExecutor('p', PGateExecutor(qmem));
    context.symbols.registerGateExecutor(
      'phase',
      PhaseGateExecutor(qmem),
    ); // alias for p
    context.symbols.registerGateExecutor('u1', U1GateExecutor(qmem));
    context.symbols.registerGateExecutor('u2', U2GateExecutor(qmem));
    context.symbols.registerGateExecutor('u3', U3GateExecutor(qmem));

    // Two-qubit gates
    context.symbols.registerGateExecutor('cx', CXGateExecutor(qmem));
    context.symbols.registerGateExecutor(
      'CX',
      CXGateExecutor(qmem),
    ); // alias for cx
    context.symbols.registerGateExecutor('cnot', CNOTGateExecutor(qmem));
    context.symbols.registerGateExecutor('cy', CYGateExecutor(qmem));
    context.symbols.registerGateExecutor('cz', CZGateExecutor(qmem));
    context.symbols.registerGateExecutor('cp', CPGateExecutor(qmem));
    context.symbols.registerGateExecutor(
      'cphase',
      CPhaseGateExecutor(qmem),
    ); // alias for cp
    context.symbols.registerGateExecutor('crx', CRXGateExecutor(qmem));
    context.symbols.registerGateExecutor('cry', CRYGateExecutor(qmem));
    context.symbols.registerGateExecutor('crz', CRZGateExecutor(qmem));
    context.symbols.registerGateExecutor('ch', CHGateExecutor(qmem));
    context.symbols.registerGateExecutor('cu', CUGateExecutor(qmem));
    context.symbols.registerGateExecutor('swap', SWAPGateExecutor(qmem));

    // Three-qubit gates
    context.symbols.registerGateExecutor('ccx', CCXGateExecutor(qmem));
    context.symbols.registerGateExecutor('cswap', CSWAPGateExecutor(qmem));
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
