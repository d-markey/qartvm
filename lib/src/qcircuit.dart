import 'math/complex_matrix.dart';
import 'exceptions.dart';
import 'qcircuit_gate.dart';
import 'qgate_type.dart';
import 'qgates.dart';
import 'qregister.dart';

class QCircuit {
  QCircuit({required this.size});

  final int size;

  final gates = <QCircuitGate>[];

  final _listeners =
      <void Function(int step, QCircuitGate? gate, QRegister qreg)>[];

  late final _unitary = QGates.unitary(size);
  late final _parallel = QGates.parallel(size);
  late final _controlled = QGates.controlled(size);
  late final _highLevel = QGates.highLevel(size);

  Iterable<String> describe() sync* {
    for (var gate in gates) {
      yield gate.toString();
    }
  }

  QCircuit measure({Set<int>? qubits, String? label}) {
    gates.add(
        QCircuitGate.measure(qubits?.toList(), circuit: this, label: label));
    return this;
  }

  QCircuit _addGate(QGateType type, ComplexMatrix matrix, List<int> qubits,
      {List<int>? controls, Map<String, dynamic>? params, String? label}) {
    if (!matrix.square || matrix.rows != (1 << size)) {
      throw InvalidOperationException(
          'Invalid gate ${matrix.rows}x${matrix.columns} for $qubits-qubit circuit');
    }
    gates.add(QCircuitGate(type, matrix, qubits,
        controls: controls, circuit: this, params: params, label: label));
    return this;
  }

  QCircuit unitaryCustom(int qubit, ComplexMatrix unitaryGate,
      {QGateType type = QGateType.custom,
      Map<String, dynamic>? params,
      String? label}) {
    assert(type.isCustom);
    return _addGate(type, _unitary.unitaryGate(qubit, unitaryGate), [qubit],
        params: params, label: label);
  }

  QCircuit hadamard(int qubit, {String? label}) =>
      _addGate(QGateType.hadamard, _unitary.hadamard(qubit), [qubit],
          label: label);

  QCircuit pauliX(int qubit, {String? label}) =>
      _addGate(QGateType.pauliX, _unitary.pauliX(qubit), [qubit], label: label);

  QCircuit not(int qubit, {String? label}) => pauliX(qubit, label: label);

  QCircuit pauliY(int qubit, {String? label}) =>
      _addGate(QGateType.pauliY, _unitary.pauliY(qubit), [qubit], label: label);

  QCircuit pauliZ(int qubit, {String? label}) =>
      _addGate(QGateType.pauliZ, _unitary.pauliZ(qubit), [qubit], label: label);

  QCircuit squareRootOfX(int qubit, {String? label}) =>
      _addGate(QGateType.squareRootOfX, _unitary.squareRootOfX(qubit), [qubit],
          label: label);

  QCircuit sqrtOfNot(int qubit, {String? label}) =>
      squareRootOfX(qubit, label: label);

  QCircuit phase(int qubit, double radians, {String? label}) =>
      _addGate(QGateType.phase, _unitary.phase(qubit, radians), [qubit],
          label: label, params: {'angle': radians});

  QCircuit phaseS(int qubit, {String? label}) =>
      _addGate(QGateType.phaseS, _unitary.phaseS(qubit), [qubit], label: label);

  QCircuit phaseT(int qubit, {String? label}) =>
      _addGate(QGateType.phaseT, _unitary.phaseT(qubit), [qubit], label: label);

  QCircuit parallelCustom(Set<int> qubits, ComplexMatrix unitaryGate,
      {QGateType type = QGateType.custom,
      Map<String, dynamic>? params,
      String? label}) {
    assert(type.isCustom);
    return _addGate(
        type, _parallel.parallelGate(qubits, unitaryGate), qubits.toList(),
        params: params, label: label);
  }

  QCircuit parallelHadamard(Set<int> qubits, {String? label}) =>
      _addGate(QGateType.hadamard, _parallel.hadamard(qubits), qubits.toList(),
          label: label);

  QCircuit parallelPauliX(Set<int> qubits, {String? label}) =>
      _addGate(QGateType.pauliX, _parallel.pauliX(qubits), qubits.toList(),
          label: label);

  QCircuit parallelNot(Set<int> qubits, {String? label}) =>
      parallelPauliX(qubits);

  QCircuit parallelPauliY(Set<int> qubits, {String? label}) =>
      _addGate(QGateType.pauliY, _parallel.pauliY(qubits), qubits.toList(),
          label: label);

  QCircuit parallelPauliZ(Set<int> qubits, {String? label}) =>
      _addGate(QGateType.pauliZ, _parallel.pauliZ(qubits), qubits.toList(),
          label: label);

  QCircuit parallelSquareRootOfX(Set<int> qubits, {String? label}) => _addGate(
      QGateType.squareRootOfX, _parallel.squareRootOfX(qubits), qubits.toList(),
      label: label);

  QCircuit parallelSqrtOfNot(Set<int> qubits, {String? label}) =>
      parallelSquareRootOfX(qubits, label: label);

  QCircuit parallelPhase(Set<int> qubits, double radians, {String? label}) =>
      _addGate(
          QGateType.phase, _parallel.phase(qubits, radians), qubits.toList(),
          label: label, params: {'angle': radians});

  QCircuit parallelPhaseS(Set<int> qubits, {String? label}) =>
      _addGate(QGateType.phaseS, _parallel.phaseS(qubits), qubits.toList(),
          label: label);

  QCircuit parallelPhaseT(Set<int> qubits, {String? label}) =>
      _addGate(QGateType.phaseT, _parallel.phaseT(qubits), qubits.toList(),
          label: label);

  QCircuit controlledCustom(int control, int qubit, ComplexMatrix unitaryGate,
      {QGateType type = QGateType.custom,
      Map<String, dynamic>? params,
      String? label}) {
    assert(type.isCustom);
    return _addGate(
        type, _controlled.controlledGate(control, qubit, unitaryGate), [qubit],
        controls: [control], params: params, label: label);
  }

  QCircuit controlledHadamard(int control, int qubit, {String? label}) =>
      _addGate(
          QGateType.hadamard, _controlled.hadamard(control, qubit), [qubit],
          controls: [control], label: label);

  QCircuit controlledPauliX(int control, int qubit, {String? label}) =>
      _addGate(QGateType.pauliX, _controlled.pauliX(control, qubit), [qubit],
          controls: [control], label: label);

  QCircuit controlledNot(int control, int qubit, {String? label}) =>
      controlledPauliX(control, qubit, label: label);

  QCircuit controlledPauliY(int control, int qubit, {String? label}) =>
      _addGate(QGateType.pauliY, _controlled.pauliY(control, qubit), [qubit],
          controls: [control], label: label);

  QCircuit controlledPauliZ(int control, int qubit, {String? label}) =>
      _addGate(QGateType.pauliZ, _controlled.pauliZ(control, qubit), [qubit],
          controls: [control], label: label);

  QCircuit controlledSquareRootOfX(int control, int qubit, {String? label}) =>
      _addGate(QGateType.squareRootOfX,
          _controlled.squareRootOfX(control, qubit), [qubit],
          controls: [control], label: label);

  QCircuit controlledSqrtOfNot(int control, int qubit, {String? label}) =>
      controlledSquareRootOfX(control, qubit, label: label);

  QCircuit controlledPhase(int control, int qubit, double radians,
          {String? label}) =>
      _addGate(
          QGateType.phase, _controlled.phase(control, qubit, radians), [qubit],
          controls: [control], label: label, params: {'angle': radians});

  QCircuit controlledPhaseS(int control, int qubit, {String? label}) =>
      _addGate(QGateType.phaseS, _controlled.phaseS(control, qubit), [qubit],
          controls: [control], label: label);

  QCircuit controlledPhaseT(int control, int qubit, {String? label}) =>
      _addGate(QGateType.phaseT, _controlled.phaseT(control, qubit), [qubit],
          controls: [control], label: label);

  QCircuit swap(int qubit1, int qubit2, {String? label}) => _addGate(
      QGateType.swap, _highLevel.swap(qubit1, qubit2), [qubit1, qubit2],
      label: label);

  QCircuit fredkin(int control, int qubit1, int qubit2, {String? label}) =>
      _addGate(QGateType.fredkin, _highLevel.fredkin(control, qubit1, qubit2),
          [qubit1, qubit2],
          controls: [control], label: label);

  QCircuit toffoli(int control1, int control2, int qubit, {String? label}) =>
      _addGate(QGateType.toffoli, _highLevel.toffoli(control1, control2, qubit),
          [qubit],
          controls: [control1, control2], label: label);

  QCircuit qft(List<int> qubits, {String? label}) =>
      _addGate(QGateType.qft, _highLevel.qft(qubits), qubits, label: label);

  QCircuit invQft(List<int> qubits, {String? label}) =>
      _addGate(QGateType.invqft, _highLevel.invqft(qubits), qubits,
          label: label);

  QCircuit custom(Set<int> qubits, ComplexMatrix matrix,
      {QGateType type = QGateType.custom,
      Set<int>? controls,
      Map<String, dynamic>? params,
      String? label}) {
    assert(type.isCustom);
    return _addGate(type, matrix, qubits.toList(),
        controls: controls?.toList(), params: params, label: label);
  }

  QCircuit addListener(
      void Function(int step, QCircuitGate? gate, QRegister qreg) listener) {
    _listeners.add(listener);
    return this;
  }

  void _notify(int step, QCircuitGate? gate, QRegister qreg) {
    for (var listener in _listeners) {
      listener(step, gate, qreg);
    }
  }

  void execute(QRegister qreg) {
    _notify(0, null, qreg);
    for (var i = 0; i < gates.length; i++) {
      final gate = gates[i];
      if (gate.type == QGateType.measure) {
        qreg.measure(qubits: gate.qubits.toSet());
      } else {
        qreg.applyGate(gate.matrix!);
      }
      _notify(i + 1, gate, qreg);
    }
  }
}
