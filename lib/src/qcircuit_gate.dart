import 'dart:math' as math;

import 'exceptions.dart';
import 'math/complex_matrix.dart';
import 'qcircuit.dart';
import 'qgate_type.dart';
import 'qmemory_space.dart';

/// Class representing a Quantum gate in a Quantum [QCircuit]
class QCircuitGate {
  QCircuitGate._(this.circuit, this._labelFormat, this._params, this.type,
      Set<int>? controls, this._qubits, this._matrix)
      : assert(_matrix != null ||
            (type == QGateType.measure || type == QGateType.separator)),
        assert(_qubits.isNotEmpty ||
            (type == QGateType.measure || type == QGateType.separator)),
        assert(controls == null ||
            controls.isEmpty ||
            (type != QGateType.measure && type != QGateType.separator)),
        _controls = (controls?.isEmpty ?? true) ? null : controls;

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

  /// Builds a separation gate
  /// [circuit] refers to the circuit the gate is part of
  /// [label] is a description of the gate
  QCircuitGate.separation({required QCircuit circuit, String? label})
      : this._(circuit, label, null, QGateType.separator, null, const {}, null);

  QCircuitGate copy(QCircuit circuit,
      {Set<int>? controls,
      bool dagger = false,
      String? label,
      QGateType? type,
      Map<String, dynamic>? params}) {
    switch (type) {
      case QGateType.measure:
        if (dagger) {
          throw InvalidOperationException(
              'Measurement gates are not reservible');
        }
        if (controls != null || controls!.isNotEmpty) {
          throw InvalidOperationException(
              'Measurement gates cannot be controlled');
        }
        return QCircuitGate.measure(_qubits,
            circuit: circuit, label: _labelFormat);
      case QGateType.separator:
        return QCircuitGate.separation(circuit: circuit, label: _labelFormat);
      default:
        var m = _matrix!;
        if (dagger) {
          m = m.dagger();
        }
        String? l;
        if (type == null) {
          if (label == null || label.isEmpty) {
            l = labelFormat.trim();
            if (dagger) {
              if (l.isEmpty) {
                l = '(inverse)';
              } else if (l == '(inverse)') {
                l = '';
              } else if (l.endsWith(' (inverse)')) {
                l = l.substring(0, l.length - ' (inverse)'.length);
              } else {
                l = '$l (inverse)';
              }
            }
          } else {
            l = label;
          }
        }
        if (controls != null) {
          m = circuit.gateBuilder.controlled
              .build(_qubits, m, controls: controls);
        }
        Set<int>? ctrl;
        if (_controls != null) {
          ctrl ??= <int>{};
          ctrl.addAll(_controls!);
        }
        if (controls != null) {
          ctrl ??= <int>{};
          ctrl.addAll(controls);
        }
        if (params == null) {
          params = _params;
        } else if (_params != null) {
          params = _params!..addAll(params);
        }
        return QCircuitGate(type ?? this.type, m, _qubits,
            circuit: circuit,
            controls: ctrl,
            label: (type != null || l == null || l.isEmpty) ? null : l,
            params: params);
    }
  }

  final Map<String, dynamic>? _params;

  /// Set of parameters associated to the gate
  Iterable<MapEntry<String, dynamic>> get params =>
      _params?.entries ?? const [];

  final String? _labelFormat;

  String get labelFormat {
    var l = _labelFormat;
    if (l == null) {
      switch (type) {
        case QGateType.separator:
          l = '';
          break;
        case QGateType.measure:
          l = _qubits.isEmpty ? 'measure all qubits' : 'measure $_qubits';
          break;
        default:
          l = (_controls == null)
              ? '${type.getLabel(params)} on $_qubits'
              : '${type.getLabel(params)} on $_qubits controlled by $_controls';
          break;
      }
    }
    return l;
  }

  /// Returns the gate's formatted label
  String get label {
    var l = labelFormat;
    final params = _params?.keys.toList();
    if (params != null) {
      params.sort((a, b) => b.length - a.length);
      for (var param in params) {
        l = l.replaceAll('[$param]', _format(param));
      }
    }
    return l;
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

  /// Applies this gate on Quantum memory [qmem]
  void apply(QMemorySpace qmem) {
    switch (type) {
      case QGateType.separator:
        // nothing to do
        break;
      case QGateType.measure:
        qmem.measure(qubits: _qubits.toSet());
        break;
      default:
        qmem.applyGate(_matrix!, _qubits.toSet());
        break;
    }
  }

  String _format(String key) {
    var v = _params?[key];
    if (key == 'angle' && v is double) {
      v /= math.pi;
      v = '$v pi';
    }
    return v?.toString() ?? 'NULL';
  }

  @override
  String toString() => label;
}
