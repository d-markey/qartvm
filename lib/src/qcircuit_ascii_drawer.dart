import 'qcircuit.dart';
import 'qcircuit_gate.dart';
import 'qgate_type.dart';
import 'qmemory_space.dart';
import 'qstate.dart';

/// A quantum circuit ASCII drawer
class QCircuitAsciiDrawer {
  /// Returns a set of strings representing the [circuit]
  Iterable<String> draw(QCircuit circuit, [QMemorySpace? qmem]) {
    final nbQbits = circuit.size;
    final names = Iterable.generate(
      nbQbits,
      (i) => qmem?.getLogicalName(QbitAddress(i)) ?? '#$i',
    ).toList();
    final nameWidth = names.fold<int>(
      0,
      (previousValue, element) =>
          element.length > previousValue ? element.length : previousValue,
    );

    final lines = <StringBuffer>[];
    var idx = 0;
    for (var i = 0; i < nbQbits; i++) {
      lines.add(StringBuffer('${' ' * nameWidth}    '));
      lines.add(StringBuffer('${names[i].padRight(nameWidth)} ---'));
      lines.add(StringBuffer('${' ' * nameWidth}    '));
    }

    final gateDrawer = _QCircuitGateAsciiDrawer();
    for (var gate in circuit.gates) {
      idx = 0;
      for (var l in gateDrawer.draw(gate)) {
        lines[idx++].write(l);
      }
    }
    idx = 0;
    for (var i = 0; i < nbQbits; i++) {
      lines[idx++].write('   ');
      lines[idx++].write('---');
      lines[idx++].write('   ');
    }
    idx = 0;
    for (var i = 0; i < nbQbits; i++) {
      lines[idx++].write('');
      lines[idx++].write('-- ${names[i]}');
      lines[idx++].write('');
    }
    return lines.map((sb) => sb.toString());
  }
}

class _QCircuitGateAsciiDrawer {
  Iterable<String> draw(QCircuitGate gate) sync* {
    if (gate.type == QGateType.separator) {
      for (var i = 0; i < gate.circuit.size; i++) {
        yield '   ${gate.type.symbol}   ';
        yield '---${gate.type.symbol}---';
        yield '   ${gate.type.symbol}   ';
      }
    } else if (gate.type == QGateType.measure) {
      for (var i = 0; i < gate.circuit.size; i++) {
        if (gate.qbits.isEmpty || gate.qbits.contains(i)) {
          yield '         ';
          yield '--${gate.type.symbol}--';
          yield '         ';
        } else {
          yield '         ';
          yield '--${'-' * gate.type.symbol.length}--';
          yield '         ';
        }
      }
    } else {
      final symbol = gate.type.getSymbol(gate.params);
      final box = '-| $symbol |-';
      final cbox = ' | ${' ' * symbol.length} | ';
      final border = '  ${'-' * (box.length - 4)}  ';
      final untouched = '-|${' ' * (box.length - 4)}|-';
      final blanks = ' ' * box.length;
      final wire = '-' * box.length;
      var ctrl = '-' * ((box.length - 3) ~/ 2);
      if (ctrl.length + ctrl.length + 3 == blanks.length) {
        ctrl = '$ctrl X $ctrl';
      } else {
        ctrl = '$ctrl X -$ctrl';
      }
      final min = gate.qbits.fold<int>(
        gate.circuit.size,
        (previousValue, element) =>
            element.index < previousValue ? element.index : previousValue,
      );
      final max = gate.qbits.fold<int>(
        -1,
        (previousValue, element) =>
            element.index > previousValue ? element.index : previousValue,
      );
      for (var i = 0; i < gate.circuit.size; i++) {
        if (gate.controls.contains(i)) {
          yield blanks;
          yield ctrl;
          yield blanks;
        } else if (gate.qbits.contains(i)) {
          final last = gate.isUnitary || !gate.qbits.any(($) => $.index > i);
          final first = gate.isUnitary || !gate.qbits.any(($) => $.index < i);
          yield first ? border : cbox;
          yield box;
          yield last ? border : cbox;
        } else {
          final inside = !gate.isUnitary && min < i && i < max;
          if (inside) {
            yield cbox;
            yield untouched;
            yield cbox;
          } else {
            yield blanks;
            yield wire;
            yield blanks;
          }
        }
      }
    }
  }
}
