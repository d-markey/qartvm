import 'package:qartvm/qartvm.dart';

import 'utils.dart';

void main() {
  // Controlled swap using 2 CNOT and 1 TOFFOLI
  //
  //  0 ---------------- X -----------------
  //         -----                -----
  //  1 ----| NOT |----- X ------| NOT |----
  //         -----                -----
  //                  --------
  //  2 ------ X ----| CC-NOT |---- X ------
  //                  --------
  final gateBuilder = QGateBuilder.get(3);

  print('');
  print('USING STANDARD GATES');

  final fredkinCircuitWithStandardGates = QCircuit(gateBuilder);
  fredkinCircuitWithStandardGates.not(1, controls: 2);
  fredkinCircuitWithStandardGates.toffoli(2, controls: {0, 1});
  fredkinCircuitWithStandardGates.not(1, controls: 2);

  describe(fredkinCircuitWithStandardGates);
  draw(fredkinCircuitWithStandardGates);
  verifyFredkin(fredkinCircuitWithStandardGates);

  print('');
  print('USING CUSTOM GATE');

  final cnot21 = gateBuilder.controlled.not({1}, controls: {2});
  final toffoli012 = gateBuilder.highLevel.toffoli(2, controls: {0, 1});
  // Here, the custom Fredkin gate matrix is computed by multiplying
  // the matrices of the standard gates that make it up.
  // The Fredkin matrix (hard-coded) could have been provided as well.
  final myFredkinGate = cnot21 * toffoli012 * cnot21;
  final fredkinType = QGateType('My Fredkin gate', 'MY-C-SWAP');
  final fredkinCircuitWithCustomGate = QCircuit(gateBuilder);
  fredkinCircuitWithCustomGate.custom({1, 2}, myFredkinGate,
      controls: {0}, type: fredkinType);

  print(myFredkinGate.toStringIndent(indent: 1, hideZeroes: true));
  describe(fredkinCircuitWithCustomGate);
  draw(fredkinCircuitWithCustomGate);
  verifyFredkin(fredkinCircuitWithCustomGate);

  print('');
  print('USING BUILT-IN GATE');

  final fredkinCircuitWithBuiltInGate = QCircuit(gateBuilder);
  fredkinCircuitWithBuiltInGate.fredkin({1, 2}, control: 0);

  describe(fredkinCircuitWithBuiltInGate);
  draw(fredkinCircuitWithBuiltInGate);
  verifyFredkin(fredkinCircuitWithBuiltInGate);
}

void verifyFredkin(QCircuit circuit) {
  // truth table from 000 (0) to 111 (7)
  for (var i = 0; i <= 7; i++) {
    final qmem = QMemorySpace(Qbit.fromInt(i, count: 3).toList());

    final initial = probInfo(qmem);
    final init = qmem.probabilities.entries.singleWhere((e) => e.value > 0).key;

    circuit.execute(qmem);

    final outcomes = probInfo(qmem);
    final outcome =
        qmem.probabilities.entries.singleWhere((e) => e.value > 0).key;

    bool ok;
    if (init[0] == '0') {
      // qubits unchanged
      ok = (init == outcome);
    } else {
      // qubits 1 & 2 swapped
      ok = (init[1] == outcome[2] && init[2] == outcome[1]);
    }

    print('Initial: $initial => Final: $outcomes: ${ok ? 'OK' : 'KO'}');
    if (!ok) {
      throw Exception(
          'C-SWAP gate failure for $init: unexpected result $outcome');
    }
  }
}
