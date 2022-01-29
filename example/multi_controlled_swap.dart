import 'package:qartvm/qartvm.dart';

import 'utils.dart';

void main() {
  var size = 6;

  final highLevelBuilder = QGateBuilder.highLevel(size);
  final controlledBuilder = QGateBuilder.controlled(size);

  // swap qubits 4 & 5 controlled by qubits 0, 1, 2 & 3
  final controls = {0, 1, 2, 3};
  final targets = {4, 5};

  // build uncontrolled swap gate for target qubits
  final swap = highLevelBuilder.swap(targets);
  // control the swap matrix with the control qubits
  final mcSwap = controlledBuilder.build(targets, swap, controls: controls);
  print('mcSwap = ${mcSwap.toStringIndent(2, hideZeroes: true)}');

  final mcSwapGate = QGateType('Multi-controlled SWAP', 'MC-SWAP');

  final circuit = QCircuit(size: size);
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

    final qreg = QRegister(qubits);
    final initialStates = qreg.probabilities;
    final init = initialStates.entries.singleWhere((e) => e.value > 0).key;

    circuit.execute(qreg);
    final finalStates = qreg.probabilities;
    final outcome = finalStates.entries.singleWhere((e) => e.value > 0).key;

    final mustSwap = controls.every((q) => init[q] == '1');
    final swapped = (outcome[a] == init[b] && outcome[b] == init[a]);
    final unchanged = (init == outcome);

    if (mustSwap && !swapped) {
      print('ERROR! SWAP EXPECTED:');
      print('   Initial states: ${probInfo(initialStates)}');
      print('   Final states: ${probInfo(finalStates)}');
      ko++;
    } else if (!mustSwap && !unchanged) {
      print('ERROR! SWAP UNEXPECTED:');
      print('   Initial states: ${probInfo(initialStates)}');
      print('   Final states: ${probInfo(finalStates)}');
      ko++;
    }
  }
  print(ko == 0 ? 'All checks passed' : '$ko check${ko > 1 ? 's' : ''} failed');
}
