import 'dart:math' as math;

import 'math/complex_matrix.dart';
import 'qcircuit.dart';
import 'qgate_type.dart';
import 'qmemory_space.dart';
import 'qstate.dart';
import 'utils/exceptions.dart';

/// Class representing a Quantum gate in a Quantum [QCircuit]
class QCircuitGate {
  QCircuitGate._(
    this.circuit,
    this._labelFormat,
    this._params,
    this.type,
    Set<QbitAddress>? controls,
    this._qbits,
    this._matrix,
  ) : assert(
        _matrix != null ||
            (type == QGateType.measure || type == QGateType.separator),
      ),
      assert(
        _qbits.isNotEmpty ||
            (type == QGateType.measure || type == QGateType.separator),
      ),
      assert(
        controls == null ||
            controls.isEmpty ||
            (type != QGateType.measure && type != QGateType.separator),
      ),
      _controls = (controls?.isEmpty ?? true) ? null : controls;

  /// Builds a Quantum gate described by its [type], [matrix], [qbits] it operates on and eventual [controls] qubits
  /// [circuit] refers to the circuit the gate is part of
  /// [label] is a description of the gate with optional paramaters [params]
  /// [type] can be any [QGateType] value except [QGateType.measure]
  QCircuitGate(
    QGateType type,
    ComplexMatrix matrix,
    Set<QbitAddress> qbits, {
    required QCircuit circuit,
    Set<QbitAddress>? controls,
    String? label,
    Map<String, dynamic>? params,
  }) : this._(circuit, label, params, type, controls, qbits, matrix);

  /// Builds a measurement gate acting on qubits [qbits]
  /// if [qbits] is null or empty, all qubits will be measured (and its quantum state destroyed)
  /// [circuit] refers to the circuit the gate is part of
  /// [label] is a description of the gate
  QCircuitGate.measure(
    Set<QbitAddress>? qbits, {
    required QCircuit circuit,
    String? label,
  }) : this._(
         circuit,
         label,
         null,
         QGateType.measure,
         null,
         qbits ?? Iterable<QbitAddress>.generate(circuit.size).toSet(),
         null,
       );

  /// Builds a separation gate
  /// [circuit] refers to the circuit the gate is part of
  /// [label] is a description of the gate
  QCircuitGate.separation({required QCircuit circuit, String? label})
    : this._(circuit, label, null, QGateType.separator, null, const {}, null);

  QCircuitGate copy(
    QCircuit circuit, {
    Set<QbitAddress>? controls,
    bool dagger = false,
    String? label,
    QGateType? type,
    Map<String, dynamic>? params,
  }) {
    switch (type) {
      case QGateType.measure:
        if (dagger) {
          throw InvalidOperationException(
            'Measurement gates are not reservible',
          );
        }
        if (controls != null || controls!.isNotEmpty) {
          throw InvalidOperationException(
            'Measurement gates cannot be controlled',
          );
        }
        return QCircuitGate.measure(
          _qbits,
          circuit: circuit,
          label: _labelFormat,
        );
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
          m = circuit.gateBuilder.controlled.build(
            _qbits,
            m,
            controls: controls,
          );
        }

        Set<QbitAddress>? ctrl = {...?_controls, ...?controls};
        if (ctrl.isEmpty) ctrl = null;

        Map<String, dynamic>? prms = {...?_params, ...?params};
        if (prms.isEmpty) prms = null;

        return QCircuitGate(
          type ?? this.type,
          m,
          _qbits,
          circuit: circuit,
          controls: ctrl,
          label: (type != null || l == null || l.isEmpty) ? null : l,
          params: prms,
        );
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
          l = _qbits.isEmpty ? 'measure all qubits' : 'measure $_qbits';
          break;
        default:
          l = (_controls == null)
              ? '${type.getLabel(params)} on $_qbits'
              : '${type.getLabel(params)} on $_qbits controlled by $_controls';
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

  final Set<QbitAddress> _qbits;

  /// Return the list of qubits on which the gate operates -- the state of these qubits may be modified by the gate
  Iterable<QbitAddress> get qbits => _qbits;

  final Set<QbitAddress>? _controls;

  /// Returns the list of control qubits controlling the gate -- the state of these qubits are not modified by the gate
  Iterable<QbitAddress> get controls => _controls ?? const [];

  final ComplexMatrix? _matrix;

  /// Returns the [ComplexMatrix] representing the action of the gate on the full [circuit].
  /// This is a square matrix of size 2^[circuit].[QCircuit.size]
  ComplexMatrix? get matrix => _matrix?.clone();

  /// Flag indicating whether the gate operates on a single-qubit without entanglement
  /// Returns `true` iif [qbits] contains only 1 qubit and there is no [controls] qubits
  bool get isUnitary =>
      (_qbits.length == 1 && (_controls?.isEmpty ?? true)) || type.isUnitary;

  /// Applies this gate on Quantum memory [qmem]
  void apply(QMemorySpace qmem) {
    switch (type) {
      case QGateType.separator:
        // nothing to do
        break;
      case QGateType.measure:
        qmem.measure(qbits: _qbits.toSet());
        break;
      default:
        final m = _matrix!;
        // Handle local 2x2 matrices applied to multiple qubits (Parallel broadcast)
        if (m.rows == 2 && _qbits.length > 1 && (_controls?.isEmpty ?? true)) {
          for (final q in _qbits) {
            qmem.applyGate(m, {q});
          }
        } else {
          // Combine controls and targets for local matrix application
          final controls = _controls?.toList() ?? [];
          final targets = _qbits.toList();
          final allQubits = [...controls, ...targets];
          qmem.applyGate(m, allQubits);
        }
        break;
    }
  }

  String _format(String key) {
    var v = _params?[key];
    if (key == 'angle' && v is num) {
      v = v.toDouble() / math.pi;
      v = '$v pi';
    }
    return v?.toString() ?? 'NULL';
  }

  @override
  String toString() => label;
}
