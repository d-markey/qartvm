import 'dart:math' as math;

import 'math/complex_matrix.dart';
import 'qcircuit.dart';
import 'qgate_type.dart';
import 'qregister.dart';

/// Class representing a Quantum gate in a Quantum [QCircuit]
class QCircuitGate {
  QCircuitGate._(this.circuit, this._label, this._params, this.type,
      Set<int>? controls, this._qubits, this._matrix)
      : assert(_matrix != null || type == QGateType.measure),
        assert(_qubits.isNotEmpty || type == QGateType.measure),
        _controls = controls?.isEmpty ?? true ? null : controls;

  /// Builds a Quantum gate described by its [type], [matrix], [qubits] it operates on and eventual [controls] qubits
  /// [circuit] refers to the circuit the gate is part of
  /// [label] is a description of the gate with optional paramaters [params]
  /// [type] can be any [QGateType] value except [QGateType.measure]
  QCircuitGate(QGateType type, ComplexMatrix matrix, Set<int> qubits,
      {required QCircuit circuit,
      Set<int>? controls,
      String? label,
      Map<String, dynamic>? params})
      : this._(circuit, label, params, type, controls, qubits, matrix);

  /// Builds a measurement gate acting on qubits [qubits]
  /// if [qubits] is null or empty, all qubits will be measured (and its quantum state destroyed)
  /// [circuit] refers to the circuit the gate is part of
  /// [label] is a description of the gate
  QCircuitGate.measure(Set<int>? qubits,
      {required QCircuit circuit, String? label})
      : this._(circuit, label, null, QGateType.measure, null,
            qubits ?? Iterable<int>.generate(circuit.size).toSet(), null);

  final Map<String, dynamic>? _params;

  /// Set of parameters associated to the gate
  Iterable<MapEntry<String, dynamic>> get params =>
      _params?.entries ?? const [];

  final String? _label;

  /// Returns the gate's formatted label
  String get label {
    var l = _label;
    if (l == null) {
      if (type == QGateType.measure) {
        l = _qubits.isEmpty ? 'measure all qubits' : 'measure $_qubits';
      } else {
        l = (_controls == null)
            ? '${type.getLabel(params)} on $_qubits'
            : '${type.getLabel(params)} on $_qubits controlled by $_controls';
      }
    } else if (_params != null) {
      final keys = _params!.keys.toList();
      keys.sort((a, b) => b.length - a.length);
      for (var k in keys) {
        l = l!.replaceAll('[$k]', _format(_params!, k));
      }
    }
    return l!;
  }

  /// Returns the gate's type
  final QGateType type;

  /// Returns the [QCircuit] containing this gate
  final QCircuit circuit;

  final Set<int> _qubits;

  /// Return the list of qubits on which the gate operates -- the state of these qubits may be modified by the gate
  Iterable<int> get qubits => _qubits;

  final Set<int>? _controls;

  /// Returns the list of control qubits controlling the gate -- the state of these qubits are not modified by the gate
  Iterable<int> get controls => _controls ?? const [];

  final ComplexMatrix? _matrix;

  /// Returns the [ComplexMatrix] representing the action of the gate on the full [circuit].
  /// This is a square matrix of size 2^[circuit].[QCircuit.size]
  ComplexMatrix? get matrix => _matrix?.clone();

  /// Flag indicating whether the gate operates on a single-qubit without entanglement
  /// Returns `true` iif [qubits] contains only 1 qubit and there is no [controls] qubits
  bool get isUnitary =>
      (_qubits.length == 1 && (_controls?.isEmpty ?? true)) || type.isUnitary;

  /// Applies this gate on Quantum register [qreg]
  void apply(QRegister qreg) {
    if (type == QGateType.measure) {
      qreg.measure(qubits: _qubits.toSet());
    } else {
      qreg.applyGate(_matrix!, _qubits.toSet());
    }
  }

  String _format(Map<String, dynamic> params, String key) {
    var v = params[key];
    if (key == 'angle' && v is double) {
      v /= math.pi;
      v = '$v pi';
    }
    return v?.toString() ?? 'NULL';
  }

  @override
  String toString() => label;
}
