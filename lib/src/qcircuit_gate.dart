import 'dart:math' as math;

import 'math/complex_matrix.dart';
import 'qcircuit.dart';
import 'qgate_type.dart';

class QCircuitGate {
  QCircuitGate._(this.circuit, this._label, this.params, this.type,
      List<int>? controls, this.qubits, this.matrix)
      : assert(matrix != null || type == QGateType.measure),
        assert(qubits.isNotEmpty || type == QGateType.measure),
        controls = controls?.isEmpty ?? true ? null : controls;

  QCircuitGate(QGateType type, ComplexMatrix matrix, List<int> qubits,
      {required QCircuit circuit,
      List<int>? controls,
      String? label,
      Map<String, dynamic>? params})
      : this._(circuit, label, params, type, controls, qubits, matrix);

  QCircuitGate.measure(List<int>? qubits,
      {required QCircuit circuit, String? label})
      : this._(circuit, label, null, QGateType.measure, null,
            qubits ?? List.generate(circuit.size, (i) => i), null);

  final String? _label;

  String? get label {
    if (_label == null) {
      return null;
    } else {
      var l = _label!;
      if (params != null) {
        final keys = params!.keys.toList();
        keys.sort((a, b) => b.length - a.length);
        for (var k in keys) {
          l.replaceAll('[$k]', _format(params!, k));
        }
      }
      return l;
    }
  }

  final QGateType type;
  final ComplexMatrix? matrix;
  final QCircuit circuit;
  final List<int> qubits;
  final List<int>? controls;
  final Map<String, dynamic>? params;

  bool get isUnitary => qubits.length == 1 || type.isUnitary;

  String _format(Map<String, dynamic> params, String key) {
    var v = params[key];
    if (key == 'angle' && v is double) {
      v /= math.pi;
      v = '$v pi';
    }
    return v?.toString() ?? 'NULL';
  }

  @override
  String toString() {
    if (type == QGateType.measure) {
      return qubits.isEmpty ? 'measure all qubits' : 'measure $qubits';
    } else {
      return controls == null
          ? '${type.getLabel(params)} on $qubits'
          : '${type.getLabel(params)} on $qubits controlled by $controls';
    }
  }
}
