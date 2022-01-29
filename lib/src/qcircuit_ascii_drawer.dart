import 'qcircuit.dart';
import 'qcircuit_gate.dart';
import 'qgate_type.dart';

/// A quantum circuit ASCII drawer
class QCircuitAsciiDrawer {
  /// Returns a set of strings representing the [circuit]
  Iterable<String> draw(QCircuit circuit) {
    final nbQubits = circuit.size;
    final lines = <StringBuffer>[];
    var idx = 0;
    for (var i = 0; i < nbQubits; i++) {
      final n = i < 10 ? ' $i' : '$i';
      lines.add(StringBuffer('      '));
      lines.add(StringBuffer('$n ---'));
      lines.add(StringBuffer('      '));
    }
    final gateDrawer = _QCircuitGateAsciiDrawer();
    for (var gate in circuit.gates) {
      idx = 0;
      for (var l in gateDrawer.draw(gate)) {
        lines[idx++].write(l);
      }
    }
    idx = 0;
    for (var i = 0; i < nbQubits; i++) {
      lines[idx++].write('   ');
      lines[idx++].write('---');
      lines[idx++].write('   ');
    }
    return lines.map((sb) => sb.toString());
  }
}

class _QCircuitGateAsciiDrawer {
  Iterable<String> draw(QCircuitGate gate) sync* {
    if (gate.type == QGateType.measure) {
      for (var i = 0; i < gate.circuit.size; i++) {
        if (gate.qubits.isEmpty || gate.qubits.contains(i)) {
          yield '         ';
          yield '--[ / ]--';
          yield '         ';
        } else {
          yield '         ';
          yield '---------';
          yield '         ';
        }
      }
    } else {
      final symbol = gate.type.getSymbol(gate.params);
      final box = '-| $symbol |-';
      final cbox = ' | ${' ' * symbol.length} | ';
      final border = '  ${'-' * (box.length - 4)}  ';
      final blanks = ' ' * box.length;
      final wire = '-' * box.length;
      var ctrl = '-' * ((box.length - 3) ~/ 2);
      if (ctrl.length + ctrl.length + 3 == blanks.length) {
        ctrl = '$ctrl X $ctrl';
      } else {
        ctrl = '$ctrl X -$ctrl';
      }
      for (var i = 0; i < gate.circuit.size; i++) {
        if (gate.controls.contains(i)) {
          yield blanks;
          yield ctrl;
          yield blanks;
        } else if (gate.qubits.contains(i)) {
          final last = gate.isUnitary || !gate.qubits.any((_) => _ > i);
          final first = gate.isUnitary || !gate.qubits.any((_) => _ < i);
          yield first ? border : cbox;
          yield box;
          yield last ? border : cbox;
        } else {
          yield blanks;
          yield wire;
          yield blanks;
        }
      }
    }
  }
}
