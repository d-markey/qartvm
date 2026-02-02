import '../../qmemory_space.dart';
import '../../qcircuit.dart';
import '../../qgate_builder.dart';
import '../parser/ast_nodes.dart';
import '_execution_context.dart';
import '_expression_evaluator.dart';
import '_qbit_resolver.dart';

/// Maps OpenQASM gate names to QCircuit operations.
class GateMapper {
  GateMapper(this.context, this.evaluator) {
    _qbitResolver = QbitResolver(context, evaluator.evaluate);
  }

  final ExecutionContext context;
  final ExpressionEvaluator evaluator;
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

    switch (gateName.toLowerCase()) {
      // Single-qubit gates
      case 'h':
        _applySingleQubitGate(
          qmem,
          qubits,
          (circuit, q) => circuit.hadamard(q),
        );
      case 'x':
        _applySingleQubitGate(qmem, qubits, (circuit, q) => circuit.pauliX(q));
      case 'y':
        _applySingleQubitGate(qmem, qubits, (circuit, q) => circuit.pauliY(q));
      case 'z':
        _applySingleQubitGate(qmem, qubits, (circuit, q) => circuit.pauliZ(q));
      case 's':
        _applySingleQubitGate(qmem, qubits, (circuit, q) => circuit.phaseS(q));
      case 't':
        _applySingleQubitGate(qmem, qubits, (circuit, q) => circuit.phaseT(q));

      // Parameterized single-qubit gates
      case 'rx':
        final angle = _getParam(params, 0, 'RX').toDouble();
        _applySingleQubitGate(
          qmem,
          qubits,
          (circuit, q) => circuit.rotationX(angle, q),
        );
      case 'ry':
        final angle = _getParam(params, 0, 'RY').toDouble();
        _applySingleQubitGate(
          qmem,
          qubits,
          (circuit, q) => circuit.rotationY(angle, q),
        );
      case 'rz':
        final angle = _getParam(params, 0, 'RZ').toDouble();
        _applySingleQubitGate(
          qmem,
          qubits,
          (circuit, q) => circuit.rotationZ(angle, q),
        );
      case 'phase':
      case 'p':
        final angle = _getParam(params, 0, 'Phase').toDouble();
        _applySingleQubitGate(
          qmem,
          qubits,
          (circuit, q) => circuit.phase(angle, q),
        );

      // Two-qubit gates
      case 'cx':
      case 'cnot':
        _checkQubitCount(qubits, 2, 'CX');
        _applyTwoQubitGate(
          qmem,
          qubits[0],
          qubits[1],
          (circuit, ctrl, tgt) => circuit.pauliX(tgt, controls: {ctrl}),
        );
      case 'cy':
        _checkQubitCount(qubits, 2, 'CY');
        _applyTwoQubitGate(
          qmem,
          qubits[0],
          qubits[1],
          (circuit, ctrl, tgt) => circuit.pauliY(tgt, controls: {ctrl}),
        );
      case 'cz':
        _checkQubitCount(qubits, 2, 'CZ');
        _applyTwoQubitGate(
          qmem,
          qubits[0],
          qubits[1],
          (circuit, ctrl, tgt) => circuit.pauliZ(tgt, controls: {ctrl}),
        );
      case 'swap':
        _checkQubitCount(qubits, 2, 'SWAP');
        _applySwapGate(qmem, qubits[0], qubits[1]);

      // Three-qubit gates
      case 'ccx':
      case 'toffoli':
        _checkQubitCount(qubits, 3, 'CCX');
        _applyToffoliGate(qmem, qubits[0], qubits[1], qubits[2]);

      default:
        // Try to find custom gate definition
        final gateDef = context.symbols.lookupGate(gateName);
        if (gateDef != null) {
          throw GateExecutionException(
            'Custom gate execution not yet implemented: $gateName',
          );
        }
        throw GateExecutionException('Unknown gate: $gateName');
    }

    // TODO: Handle gate modifiers (inv, ctrl, pow)
    if (modifiers != null && modifiers.isNotEmpty) {
      throw GateExecutionException('Gate modifiers not yet supported');
    }
  }

  num _getParam(List<num>? params, int index, String gate) {
    if (params == null || params.length <= index) {
      throw GateExecutionException(
        '$gate gate requires parameter at index $index',
      );
    }
    return params[index];
  }

  void _checkQubitCount(List<int> qubits, int expected, String gate) {
    if (qubits.length != expected) {
      throw GateExecutionException(
        '$gate gate requires exactly $expected qubits, got ${qubits.length}',
      );
    }
  }

  /// Applies a single-qubit gate to one or more qubits.
  void _applySingleQubitGate(
    QMemorySpace qmem,
    List<int> qubits,
    void Function(QCircuit, int) applyFn,
  ) {
    if (qubits.isEmpty) return;

    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);

    for (final qubit in qubits) {
      applyFn(circuit, qubit);
    }
    circuit.execute(qmem);
  }

  /// Applies a two-qubit gate.
  void _applyTwoQubitGate(
    QMemorySpace qmem,
    int control,
    int target,
    void Function(QCircuit, int, int) applyFn,
  ) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    applyFn(circuit, control, target);
    circuit.execute(qmem);
  }

  /// Applies a swap gate.
  void _applySwapGate(QMemorySpace qmem, int qubit1, int qubit2) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    circuit.swap({qubit1, qubit2});
    circuit.execute(qmem);
  }

  /// Applies a Toffoli gate.
  void _applyToffoliGate(
    QMemorySpace qmem,
    int control1,
    int control2,
    int target,
  ) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    circuit.toffoli(target, controls: {control1, control2});
    circuit.execute(qmem);
  }
}

/// Exception thrown during gate execution.
class GateExecutionException implements Exception {
  GateExecutionException(this.message);
  final String message;

  @override
  String toString() => 'GateExecutionException: $message';
}
