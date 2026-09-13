import 'dart:async';

import '../qmemory_space.dart';
import 'interpreter/_expression_evaluator.dart';
import 'interpreter/_flow_exceptions.dart';
import 'interpreter/_gate_mapper.dart';
import 'interpreter/_program_scanner.dart';
import 'interpreter/_qbit_resolver.dart';
import 'interpreter/_range_result.dart';
import 'interpreter/_standard_gate_executors.dart';
import 'interpreter/_state_context.dart';
import 'interpreter/exceptions.dart';
import 'interpreter/interpreter_result.dart';
import 'interpreter/openqasm_include_provider.dart';
import 'openqasm_parser.dart';
import 'parser/_eval.dart';
import 'parser/ast_nodes.dart';

/// Observer callback for OpenQASM execution.
/// [step] is the current execution step number.
/// [statement] is the statement being executed.
/// [qmem] is a read-only view of the quantum memory.
typedef OpenQASMObserver =
    FutureOr<void> Function(
      int step,
      Statement statement,
      QMemorySpaceView qmem,
    );

/// OpenQASM 3.0 interpreter that executes parsed programs.
class OpenQASMInterpreter {
  OpenQASMInterpreter({OpenQASMIncludeProvider? includeProvider})
    : _includeProvider = includeProvider;

  final OpenQASMIncludeProvider? _includeProvider;

  // Observers list
  final List<OpenQASMObserver> _observers = [];

  late ExpressionEvaluator _evaluator;
  late GateMapper _gateMapper;
  late QbitResolver _qbitResolver;

  // Execution state
  int _stepCount = 0;

  /// Registers an observer to be notified during execution.
  void addObserver(OpenQASMObserver observer) {
    _observers.add(observer);
  }

  /// Removes a registered observer.
  void removeObserver(OpenQASMObserver observer) {
    _observers.remove(observer);
  }

  /// Executes the given [program] and returns a list of results.
  ///
  /// The [includeProvider] passed to the constructor is used to load
  /// any files referenced by `include` statements.
  ///
  /// Use [stateContext] or [inputVariables] to provide classical values
  /// that are available at runtime without hardcoding them into the QASM source.
  ///
  /// [expectedMeasurements] is currently for future branching support.
  /// When 1 (default), executes as a single branch and returns a single-item list.
  Future<List<InterpreterResult>> execute(
    Program program, {
    StateContext? stateContext,
    Map<String, dynamic>? inputVariables,
    int expectedMeasurements = 1,
    bool withCache = true,
  }) async {
    _stepCount = 0;
    final context = stateContext ?? StateContext(withCache: withCache);
    if (inputVariables != null) {
      for (final entry in inputVariables.entries) {
        context.setInputVariable(entry.key, entry.value);
      }
    }
    _evaluator = ExpressionEvaluator(context, (statements) async {
      for (final statement in statements) {
        await _executeStatementAsync(statement, context);
      }
    });
    _gateMapper = GateMapper(
      context,
      _evaluator,
      statementExecutor: (statements, ctx) async {
        for (final statement in statements) {
          await _executeStatement(statement, ctx);
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
    final totalQbits = await scanner.scan(
      program,
    ); // Scan might trigger eval which is async

    // Initialize quantum memory if needed
    if (totalQbits > 0) {
      context.quantumMemory = QMemorySpace.zero(totalQbits);
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
    return [
      InterpreterResult(
        quantumMemory:
            context.quantumMemory, // Nullable - null if no qubits declared
        classicalVariables: context.getAllVariables(),
        measurements: context.measurements,
      ),
    ];
  }

  /// Checks that the OpenQASM version is supported.
  void _checkVersion(Version version) {
    final ver = version.version;
    if (ver != '3' && !ver.startsWith('3.')) {
      throw InterpreterException(
        'Unsupported OpenQASM version: $ver. Only version 3.x is supported.',
        version,
      );
    }
  }

  /// Notifies all observers of the current execution state.
  Future<void> _notify(Statement statement, StateContext context) async {
    if (_observers.isEmpty) return;

    final qmem = context.quantumMemory;
    // We only notify if qmem exists, or maybe we notify anyway with empty view?
    // For now, let's notify only if qmem is initialized, or if not, construct a localized view if possible?
    // Actually, qmem can be null if no qubits.
    // If qmem is null, we can't really inspect quantum state.
    // But the observer signature expects QMemorySpaceView.
    // So if qmem is null, we might skip notification or pass a "Empty" view?
    // The previous implementation initialized qmem only if totalQubits > 0.

    if (qmem != null) {
      final view = QMemorySpaceViewWrapper(qmem);
      for (final observer in _observers) {
        await observer(_stepCount, statement, view);
      }
    }
    _stepCount++;
  }

  /// Executes a single statement asynchronously.
  /// Handles include statements which require async file loading.
  Future<void> _executeStatementAsync(
    Statement statement,
    StateContext context,
  ) async {
    // Notify observers before execution
    await _notify(statement, context);

    if (statement is IncludeStatement) {
      await _executeInclude(statement, context);
    } else {
      await _executeStatement(statement, context);
    }
  }

  /// Executes a single statement.
  Future<void> _executeStatement(
    Statement statement,
    StateContext context,
  ) async {
    // Note: _notify is called by _executeStatementAsync for top-level statements.
    // Nested statements (loops, if, custom gates) call this directly.
    // We should probably decide: do we notify for EVERY statement recursively?
    // If yes, then _notify should be here.
    // But _executeStatementAsync calls this. So we would double notify for top level.
    // Let's REMOVE _notify from _executeStatementAsync and put it HERE.
    // EXCEPT: _executeStatementAsync handles Includes specially.

    // Let's guard against double notification or just rely on the caller.
    // Actually, _executeStatementAsync is called for the main program loop.
    // Recursive calls usually go to _executeStatement or _executeStatementAsync.
    // Let's refactor: _executeStatementAsync calls _executeStatement.
    // We put notification inside _executeStatementAsync?
    // No, because _executeStatement is recursive for blocks.

    // Better approach: _executeStatement handles dispatch.
    // We add a wrapper `_runStep` that handles notification and simple statement execution.

    switch (statement) {
      case QubitDeclaration():
        await _executeQubitDeclaration(statement, context);
      case ClassicalDeclaration():
        await _executeClassicalDeclaration(statement, context);
      case GateCallStatement():
        await _executeGateCall(statement, context);
      case MeasurementStatement():
        await _executeMeasurement(statement, context);
      case ResetStatement():
        await _executeReset(statement, context);
      case BarrierStatement():
        _executeBarrier(statement, context);
      case AssignmentStatement():
        await _executeAssignment(statement, context);
      case IfStatement():
        await _executeIf(statement, context);
      case ForStatement():
        await _executeFor(statement, context);
      case WhileStatement():
        await _executeWhile(statement, context);
      case BreakStatement():
        throw BreakException();
      case ContinueStatement():
        throw ContinueException();
      case EndStatement():
        throw EndException();
      case ReturnStatement():
        throw ReturnException(await _evaluator.evaluate(statement.expression));
      case GateStatement():
        _executeGateDefinition(statement, context);
      case SubroutineDefinition():
        _executeSubroutineDefinition(statement, context);
      case IncludeStatement():
        await _executeInclude(statement, context);
      case AliasStatement():
        _executeAlias(statement, context);
      case ConstantDeclaration():
        await _executeConstant(statement, context);
      case IOStatement():
        _executeIO(statement, context);
      case ExternStatement():
        _executeExtern(statement, context);
      case ExpressionStatement():
        await _executeExpressionStatement(statement, context);
      default:
        throw InterpreterException(
          'Unsupported statement type: ${statement.runtimeType}',
          statement,
        );
    }
  }

  // Statement execution methods

  Future<void> _executeQubitDeclaration(
    QubitDeclaration stmt,
    StateContext context,
  ) async {
    final sizeExpr = stmt.type.designator;
    final sizeValue = sizeExpr != null
        ? await _evaluator.evaluate(sizeExpr) as int
        : 1;

    context.declareQbitRegister(stmt.name, sizeValue);
  }

  Future<void> _executeClassicalDeclaration(
    ClassicalDeclaration stmt,
    StateContext context,
  ) async {
    var value = stmt.initializer != null
        ? await _evaluator.evaluate(stmt.initializer)
        : null;

    // If the type is a ScalarTypeNode with a designator, initialize as an array
    if (stmt.type is ScalarTypeNode) {
      final scalarType = stmt.type as ScalarTypeNode;
      if (scalarType.designator != null && value == null) {
        // Evaluate the designator to get the array size
        final sizeValue = await _evaluator.evaluate(scalarType.designator!);
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

  Future<void> _executeGateCall(
    GateCallStatement stmt,
    StateContext context,
  ) async {
    await _gateMapper.executeGateCall(stmt);
  }

  Future<void> _executeMeasurement(
    MeasurementStatement stmt,
    StateContext context,
  ) async {
    final value = await _evaluator.evaluate(stmt.measureExpression);

    if (stmt.targetIdentifier != null) {
      context.updateVariable(stmt.targetIdentifier!, value);
    }
  }

  // `reset` is implemented as a measurement followed by a conditional X:
  // read the qubit's current value, and if it comes back |1>, apply an X
  // gate to force it to |0>.
  //
  // Because it's built on a measurement, `reset` is an IRREVERSIBLE
  // (non-unitary) operation. It's only safe on a qubit that's definitely
  // in a classical basis state -- not in superposition, and not
  // entangled with any other qubit. If the target IS entangled with the
  // rest of the register (as an ancilla can be mid-computation), this
  // performs a partial measurement of the whole joint state: it collapses
  // the superposition of every qubit correlated with it, destroying
  // interference that algorithms like phase estimation depend on to work
  // at all. And unlike an explicit `measure` statement, the outcome here
  // isn't stored anywhere visible to the rest of the program, so any such
  // collapse happens silently, with no trace to debug from.
  //
  // Only reset ancilla/scratch qubits that a preceding (unitary)
  // uncomputation step has already returned to a definite, unentangled
  // state -- never use `reset` as a substitute for that uncomputation.
  Future<void> _executeReset(ResetStatement stmt, StateContext context) async {
    final qbits = await _qbitResolver.resolve(stmt.qbit);
    final qmem = context.quantumMemory;
    if (qmem == null) return;

    for (final q in qbits) {
      final value = qmem.read(qbits: [q]);
      if (value == 1) {
        await _gateMapper.applyGate('x', [q], null, null);
      }
    }
  }

  void _executeBarrier(BarrierStatement stmt, StateContext context) {
    // Barrier is a no-op in simulation
  }

  Future<void> _executeAssignment(
    AssignmentStatement stmt,
    StateContext context,
  ) async {
    var value = await _evaluator.evaluate(stmt.value);

    final target = stmt.target;
    if (target is IdentifierExpression) {
      final name = target.name;
      if (stmt.operator == '=') {
        context.updateVariable(name, value);
      } else {
        final currentValue = context.getVariable(name);
        final newValue = applyAssignmentOp(currentValue, stmt.operator, value);
        context.updateVariable(name, newValue);
      }
    } else if (target is IndexExpression) {
      // Handle indexed assignment (e.g., arr[0] = 5, arr[i][j] += 1)
      final indices = <int>[];

      // Extract all indices from the IndexExpression
      for (final indexExpr in target.indices) {
        indices.add(await _evaluator.evaluate(indexExpr) as int);
      }

      // Get variable name from the base expression
      final baseExpr = target.expression;
      if (baseExpr is! IdentifierExpression) {
        throw InterpreterException(
          'Invalid assignment target: must be array access',
          baseExpr,
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
            baseExpr,
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
          baseExpr,
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
        final newValue = applyAssignmentOp(currentValue, stmt.operator, value);
        list[lastIndex] = newValue;
      }
    }
  }

  Future<void> _executeIf(IfStatement stmt, StateContext context) async {
    if (await _conditionToBool(stmt.condition, context)) {
      await _executeWithScope(stmt.ifBody, context);
    } else if (stmt.elseBody != null) {
      await _executeWithScope(stmt.elseBody!, context);
    }
  }

  Future<void> _executeWithScope(
    List<Statement> body,
    StateContext context,
  ) async {
    context.pushScope();
    try {
      for (final s in body) {
        await _executeStatementAsync(s, context);
      }
    } finally {
      context.popScope();
    }
  }

  Future<void> _executeFor(ForStatement stmt, StateContext context) async {
    final rangeValue = await _evaluator.evaluate(stmt.range);
    final Iterable<dynamic> values = switch (rangeValue) {
      RangeResult r => r.values,
      Iterable r => r,
      _ => throw InterpreterException(
        'For loop range must be an iterable or range, got $rangeValue',
        stmt.range,
      ),
    };

    for (final val in values) {
      final shouldBreak = await _executeLoopBody(
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

  Future<void> _executeWhile(WhileStatement stmt, StateContext context) async {
    while (await _conditionToBool(stmt.condition, context)) {
      final shouldBreak = await _executeLoopBody(stmt.body, context);
      if (shouldBreak) break;
    }
  }

  /// Executes a loop body, handling break/continue exceptions.
  /// Returns true if the loop should break, false otherwise.
  Future<bool> _executeLoopBody(
    List<Statement> body,
    StateContext context, {
    void Function()? onScopeEnter,
  }) async {
    context.pushScope();
    onScopeEnter?.call();
    try {
      for (final statement in body) {
        await _executeStatementAsync(statement, context);
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

  Future<bool> _conditionToBool(
    Expression condition,
    StateContext context,
  ) async {
    final result = await _evaluator.evaluate(condition);
    return toBool(result);
  }

  void _executeGateDefinition(GateStatement stmt, StateContext context) {
    context.symbols.declareGate(stmt.name, stmt);
  }

  void _executeSubroutineDefinition(
    SubroutineDefinition stmt,
    StateContext context,
  ) {
    context.symbols.declareSubroutine(stmt.name, stmt);
  }

  /// Executes an include statement by loading the file and parsing/executing its contents.
  Future<void> _executeInclude(
    IncludeStatement stmt,
    StateContext context,
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
        node: stmt,
      );
    }
  }

  /// Registers standard OpenQASM gates as executors.
  /// This is called when `include "stdgates.inc"` is processed.
  /// At this point, quantum memory has been initialized with the correct size.
  void _registerStandardGates(StateContext context) {
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

  void _executeAlias(AliasStatement stmt, StateContext context) {
    throw UnimplementedError('AliasStatement not yet implemented');
  }

  Future<void> _executeConstant(
    ConstantDeclaration stmt,
    StateContext context,
  ) async {
    final value = await _evaluator.evaluate(stmt.value);
    context.symbols.declareConstant(stmt.name, value);
  }

  void _executeIO(IOStatement stmt, StateContext context) {
    switch (stmt.direction) {
      case .input:
        final val = context.loadInputVariable(stmt.name);
        context.symbols.declareVariable(stmt.name, val);
      case .output:
        // output is not supported yet
        break;
    }
  }

  void _executeExtern(ExternStatement stmt, StateContext context) {
    // Extern declarations are no-ops
  }

  Future<void> _executeExpressionStatement(
    ExpressionStatement stmt,
    StateContext context,
  ) async {
    await _evaluator.evaluate(stmt.expression);
  }
}
