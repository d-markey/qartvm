import 'package:qartvm/qartvm.dart';

import 'utils.dart';

void main() {
  print('');
  print('USING STANDARD GATES');

  final fredkinCircuitWithStandardGates = QCircuit(size: 3);
  fredkinCircuitWithStandardGates.controlledNot(2, 1);
  fredkinCircuitWithStandardGates.toffoli(0, 1, 2);
  fredkinCircuitWithStandardGates.controlledNot(2, 1);

  describe(fredkinCircuitWithStandardGates);
  draw(fredkinCircuitWithStandardGates);
  verifyFredkin(fredkinCircuitWithStandardGates);

  print('');
  print('USING CUSTOM GATE');

  final cnot21 = QGates.controlled(3).not(2, 1);
  final toffoli012 = QGates.highLevel(3).toffoli(0, 1, 2);
  // Here, the custom Fredkin gate matrix is computed by multiplying
  // the matrices of the standard gates that make it up.
  // The Fredkin matrix (hard-coded) could have been provided as well.
  final myFredkinGate = cnot21 * toffoli012 * cnot21;
  final fredkinType = QGateType('My Fredkin gate', 'MY-C-SWAP');
  final fredkinCircuitWithCustomGate = QCircuit(size: 3);
  fredkinCircuitWithCustomGate.custom({1, 2}, myFredkinGate,
      controls: {0}, type: fredkinType);

  print(myFredkinGate.toStringIndent(1));
  describe(fredkinCircuitWithCustomGate);
  draw(fredkinCircuitWithCustomGate);
  verifyFredkin(fredkinCircuitWithCustomGate);

  print('');
  print('USING BUILT-IN GATE');

  final fredkinCircuitWithBuiltInGate = QCircuit(size: 3);
  fredkinCircuitWithBuiltInGate.fredkin(0, 1, 2);

  describe(fredkinCircuitWithBuiltInGate);
  draw(fredkinCircuitWithBuiltInGate);
  verifyFredkin(fredkinCircuitWithBuiltInGate);
}

void verifyFredkin(QCircuit circuit) {
  // truth table from 000 (0) to 111 (7)
  for (var i = 0; i <= 7; i++) {
    final qreg = QRegister(qbits(i, 3));

    final initial = qreg.probabilities;
    final init = initial.entries.singleWhere((e) => e.value > 0).key;

    circuit.execute(qreg);

    final outcomes = qreg.probabilities;
    final outcome = outcomes.entries.singleWhere((e) => e.value > 0).key;

    bool ok;
    if (init[0] == '0') {
      // qubits unchanged
      ok = (init == outcome);
    } else {
      // qubits 1 & 2 swapped
      ok = (init[1] == outcome[2] && init[2] == outcome[1]);
    }

    print(
        'Initial: ${stateInfo(initial)} => Outcome: ${stateInfo(outcomes)}: ${ok ? 'OK' : 'KO'}');
    if (!ok) throw InvalidQubitException();
  }
}
