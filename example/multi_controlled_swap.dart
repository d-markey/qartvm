import 'package:qartvm/qartvm.dart';

import 'utils.dart';

void main() {
  var size = 6;

  final gateBuilder = QGateBuilder.get(size);

  // swap qubits 4 & 5 controlled by qubits 0, 1, 2 & 3
  final controls = {0, 1, 2, 3};
  final targets = {4, 5};

  // build uncontrolled swap gate for target qubits
  final swap = gateBuilder.highLevel.swap(targets);
  // control the swap matrix with the control qubits
  final mcSwap =
      gateBuilder.controlled.build(targets, swap, controls: controls);
  print('mcSwap = ${mcSwap.toStringIndent(indent: 2, hideZeroes: true)}');

  final mcSwapGate = QGateType('Multi-controlled SWAP', 'MC-SWAP');

  final circuit = QCircuit(gateBuilder);
  circuit.custom(targets, mcSwap, controls: controls, type: mcSwapGate);

  describe(circuit);
  draw(circuit);
  verify(circuit, controls, targets);
}

void verify(QCircuit circuit, Set<int> controls, Set<int> targets) {
  final a = targets.first, b = targets.last;
  final maxState = 1 << circuit.size;
  final qubits = List.filled(circuit.size, Qbit.zero);

  var ko = 0;
  for (var n = 0; n < maxState; n++) {
    qubits.setRange(0, qubits.length, Qbit.fromInt(n, count: circuit.size));

    final qmem = QMemorySpace(qubits);
    final initialStates = probInfo(qmem);
    final init = qmem.probabilities.entries.singleWhere((e) => e.value > 0).key;

    circuit.execute(qmem);
    final finalStates = probInfo(qmem);
    final outcome =
        qmem.probabilities.entries.singleWhere((e) => e.value > 0).key;

    final mustSwap = controls.every((q) => init[q] == '1');
    final swapped = (outcome[a] == init[b] && outcome[b] == init[a]);
    final unchanged = (init == outcome);

    if (mustSwap && !swapped) {
      print('ERROR! SWAP EXPECTED:');
      print('   Initial states: $initialStates');
      print('   Final states: $finalStates');
      ko++;
    } else if (!mustSwap && !unchanged) {
      print('ERROR! SWAP UNEXPECTED:');
      print('   Initial states: $initialStates}');
      print('   Final states: $finalStates}');
      ko++;
    }
  }
  if (ko == 0) {
    print('All checks passed');
  } else {
    throw Exception('$ko check${ko > 1 ? 's' : ''} failed');
  }
}
