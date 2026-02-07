import '../../qregister.dart';
import '../parser/ast_nodes.dart';
import '_execution_context.dart';
import '_expression_evaluator.dart';
import '_gate_executor.dart';
import '_qbit_resolver.dart';
import 'exceptions.dart';

/// Maps OpenQASM gate names to QCircuit operations.
class GateMapper {
  GateMapper(this.context, this.evaluator, {required this.statementExecutor}) {
    _qbitResolver = QbitResolver(context, evaluator.evaluate);
  }

  final ExecutionContext context;
  final ExpressionEvaluator evaluator;
  final void Function(List<Statement>, ExecutionContext) statementExecutor;
  late final QbitResolver _qbitResolver;

  /// Executes a gate call statement.
  void executeGateCall(GateCallStatement stmt) {
    // Evaluate parameters if present
    final params = stmt.arguments
        ?.map((arg) => evaluator.evaluate(arg) as num)
        .toList();

    // Resolve qubit arguments to addresses
    final qubitAddresses = _qbitResolver.resolveAll(stmt.qubits);

    // Apply the gate
    applyGate(stmt.name, qubitAddresses, params, stmt.modifiers);
  }

  /// Applies a gate to the quantum memory.
  void applyGate(
    String gateName,
    List<int> qubits,
    List<num>? params,
    List<GateModifier>? modifiers,
  ) {
    final qmem = context.quantumMemory;
    if (qmem == null) {
      throw GateExecutionException(
        'Cannot apply gate: no quantum memory initialized',
      );
    }

    // Extract control information, power factor, and inverse flag from modifiers
    final controlInfo = _extractControlInfo(modifiers);
    final powerFactor = _extractPowerFactor(modifiers);
    final isInverse = _extractInverseFlag(modifiers);

    // Apply control qubits if needed
    if (controlInfo != null) {
      // Apply controlled gate multiple times based on power factor
      for (int i = 0; i < powerFactor; i++) {
        _applyControlledGate(
          gateName,
          qubits,
          params,
          controlInfo,
          isInverse: isInverse,
        );
      }
      return;
    }

    // Apply gate multiple times based on power factor
    for (int i = 0; i < powerFactor; i++) {
      _applySingleGateExecution(gateName, qubits, params, isInverse: isInverse);
    }
  }

  /// Executes a single application of a gate (called potentially multiple times by pow modifier).
  /// Looks up the gate executor (built-in or custom) from the symbol table and executes it.
  void _applySingleGateExecution(
    String gateName,
    List<int> qubits,
    List<num>? processedParams, {
    bool isInverse = false,
  }) {
    // Handle inverse gate mapping for non-parameterized gates
    String actualGateName = gateName;
    if (isInverse) {
      final inverseMappings = {'s': 'sdg', 'sdg': 's', 't': 'tdg', 'tdg': 't'};
      final lowerName = gateName.toLowerCase();
      if (inverseMappings.containsKey(lowerName)) {
        actualGateName = inverseMappings[lowerName]!;
      }
    }

    // Try to find the gate executor in the symbol table
    var executor = context.symbols.lookupGateExecutor(actualGateName);

    if (executor != null) {
      // Found a registered executor (built-in or custom)
      final finalParams = isInverse && !_hasInverseMapping(gateName)
          ? _invertParams(actualGateName, processedParams)
          : processedParams;
      executor.execute(qubits, finalParams);
      return;
    }

    // Fall back to custom gate definitions (for gates not yet converted to executors)
    final gateDef = context.symbols.lookupGate(gateName);
    if (gateDef != null) {
      _executeCustomGate(gateDef, qubits, processedParams);
      return;
    }

    throw GateExecutionException('Unknown gate: $gateName');
  }

  /// Checks if a gate has a dedicated inverse mapping (like s → sdg).
  bool _hasInverseMapping(String gateName) {
    final lowerName = gateName.toLowerCase();
    return lowerName == 's' ||
        lowerName == 'sdg' ||
        lowerName == 't' ||
        lowerName == 'tdg';
  }

  /// Inverts parameters for inverse gates.
  /// For rotation gates, negates the angle. For other gates, returns params unchanged.
  List<num>? _invertParams(String gateName, List<num>? params) {
    if (params == null || params.isEmpty) return params;

    final name = gateName.toLowerCase();

    // Gates with angles that should be negated for inverse
    if (name == 'rx' ||
        name == 'ry' ||
        name == 'rz' ||
        name == 'phase' ||
        name == 'p' ||
        name == 'u1' ||
        name == 'xx' ||
        name == 'yy' ||
        name == 'zz') {
      return [-(params[0]), ...params.skip(1)];
    }

    // For other parameterized gates, return unchanged
    return params;
  }

  /// Executes a custom gate definition with the given qubits and parameters.
  void _executeCustomGate(
    GateStatement gateDef,
    List<int> qubits,
    List<num>? params,
  ) {
    // Validate qubit count matches gate definition
    if (gateDef.qubits.length != qubits.length) {
      throw GateExecutionException(
        'Gate "${gateDef.name}" expects ${gateDef.qubits.length} qubit(s), '
        'but ${qubits.length} were provided',
      );
    }

    // Validate parameter count matches gate definition
    final expectedParamCount = gateDef.parameters?.length ?? 0;
    final actualParamCount = params?.length ?? 0;
    if (expectedParamCount != actualParamCount) {
      throw GateExecutionException(
        'Gate "${gateDef.name}" expects $expectedParamCount parameter(s), '
        'but $actualParamCount were provided',
      );
    }

    // Create a new scope for the gate execution
    context.symbols.pushScope();

    try {
      // Bind gate parameters to evaluated values
      if (gateDef.parameters != null && params != null) {
        for (int i = 0; i < gateDef.parameters!.length; i++) {
          final paramName = gateDef.parameters![i];
          final paramValue = params[i];
          context.symbols.declareVariable(paramName, paramValue);
        }
      }

      // Bind gate qubits to the provided qubit addresses
      for (int i = 0; i < gateDef.qubits.length; i++) {
        final qubitName = gateDef.qubits[i];
        final qubitAddress = qubits[i];
        // Create a single-qubit register for the parameter
        final register = QRegisterImpl.ctor(qubitName, context.quantumMemory!, [
          qubitAddress,
        ]);
        context.symbols.declareQubit(qubitName, register);
      }

      // Execute the gate body statements
      statementExecutor(gateDef.body, context);
    } finally {
      // Pop the gate scope
      context.symbols.popScope();
    }
  }

  /// Extracts control information from gate modifiers.
  ///
  /// Returns a ControlInfo object if ctrl or negctrl modifiers are present,
  /// null otherwise.
  ControlInfo? _extractControlInfo(List<GateModifier>? modifiers) {
    if (modifiers == null) return null;

    for (final modifier in modifiers) {
      if (modifier.type == 'ctrl' || modifier.type == 'negctrl') {
        final isNegated = modifier.type == 'negctrl';

        // Default control count is 1
        int controlCount = 1;
        if (modifier.expression != null) {
          controlCount = (evaluator.evaluate(modifier.expression) as num)
              .toInt();
        }

        return ControlInfo(controlCount: controlCount, isNegated: isNegated);
      }
    }

    return null;
  }

  /// Extracts the power factor from gate modifiers.
  ///
  /// Returns the power value (how many times to apply the gate).
  /// Default is 1 if no pow modifier is present.
  int _extractPowerFactor(List<GateModifier>? modifiers) {
    if (modifiers == null) return 1;

    for (final modifier in modifiers) {
      if (modifier.type == 'pow') {
        if (modifier.expression != null) {
          return (evaluator.evaluate(modifier.expression) as num).toInt();
        }
      }
    }

    return 1;
  }

  /// Extracts the inverse flag from gate modifiers.
  ///
  /// Returns true if an inv modifier is present, false otherwise.
  bool _extractInverseFlag(List<GateModifier>? modifiers) {
    if (modifiers == null) return false;

    for (final modifier in modifiers) {
      if (modifier.type == 'inv') {
        return true;
      }
    }

    return false;
  }

  /// Applies a gate with control modifiers.
  ///
  /// In OpenQASM, ctrl @ gate_name q0, q1, q2 means:
  /// - q0 is the control qubit
  /// - q1, q2, ... are the target qubits
  /// For multiple controls: ctrl(n) @ gate_name c0, c1, ..., cn, t0, t1, ...
  /// where c0...cn are control qubits and t0...tn are target qubits
  void _applyControlledGate(
    String gateName,
    List<int> allQubits,
    List<num>? params,
    ControlInfo controlInfo, {
    bool isInverse = false,
  }) {
    if (allQubits.length <= controlInfo.controlCount) {
      throw GateExecutionException(
        'ctrl modifier requires at least ${controlInfo.controlCount} control qubit(s) '
        'and 1 target qubit, but got ${allQubits.length} qubit(s)',
      );
    }

    final qmem = context.quantumMemory!;

    // Split qubits into controls and targets
    final controlQubits = allQubits.sublist(0, controlInfo.controlCount);
    final targetQubits = allQubits.sublist(controlInfo.controlCount);

    // Handle inverse gate mapping for non-parameterized gates
    String actualGateName = gateName;
    if (isInverse) {
      final inverseMappings = {'s': 'sdg', 'sdg': 's', 't': 'tdg', 'tdg': 't'};
      final lowerName = gateName.toLowerCase();
      if (inverseMappings.containsKey(lowerName)) {
        actualGateName = inverseMappings[lowerName]!;
      }
    }

    // Look up the gate executor
    final executor = context.symbols.lookupGateExecutor(actualGateName);
    if (executor == null) {
      throw GateExecutionException('Unknown gate: $actualGateName');
    }

    // Wrap executor with control modifier
    // ControlledGateExecutor handles both single and multiple controls,
    // as well as negated controls via X-flipping
    final controlledExecutor = ControlledGateExecutor(
      innerExecutor: executor,
      controlQubits: controlQubits,
      isNegated: controlInfo.isNegated,
      qmem: qmem,
      controlCount: controlInfo.controlCount,
    );

    // Handle inverse if needed (only for parameterized gates)
    final finalParams = isInverse && !_hasInverseMapping(gateName)
        ? _invertParams(actualGateName, params)
        : params;

    // Execute with control
    controlledExecutor.execute(targetQubits, finalParams);
  }
}

/// Information about control modifiers for a gate.
class ControlInfo {
  final int controlCount;
  final bool isNegated;

  ControlInfo({required this.controlCount, required this.isNegated});
}
