import 'package:qartvm/qartvm.dart';

import 'utils.dart';

void main() {
  // 1-qubit full adder

  //  0 = a0 ------- X -------- X --------------------------- X ------  --> a0
  //                          -----                         -----
  //  1 = b0 ------- X ------| NOT |----- X -------- X ----| NOT |----  --> b0
  //                          -----                         -----
  //                                               -----
  //  2      ---------------------------- X ------| NOT |-------------  --> (a+b)0
  //                                               -----
  //              --------             --------
  //  3      ----| CC-NOT |-----------| CC-NOT |----------------------  --> (a+b)1 = carry
  //              --------             --------

  final circuit = QCircuit(size: 4);
  circuit.toffoli(3, controls: {0, 1});
  circuit.not(1, controls: 0);
  circuit.toffoli(3, controls: {1, 2});
  circuit.not(2, controls: 1);
  circuit.not(1, controls: 0);

  describe(circuit);
  draw(circuit);

  for (var a = 0; a <= 1; a++) {
    for (var b = 0; b <= 1; b++) {
      final qreg = QRegister([
        ...Qbit.fromInt(a, count: 1),
        ...Qbit.fromInt(b, count: 1),
        Qbit.zero,
        Qbit.zero
      ]);

      print('[$a/$b] Initial states: ${probInfo(qreg.probabilities)}');

      circuit.execute(qreg);

      print('[$a/$b] Final states: ${probInfo(qreg.probabilities)}');

      final result = qreg.read(qubits: [3, 2]);

      print('[$a/$b] Outcome: $a + $b = $result');
    }
  }
}
