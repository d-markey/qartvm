import 'package:qartvm/qartvm.dart';

import 'utils.dart';

void main() {
  final circuit = QCircuit(size: 4);
  circuit.toffoli(0, 1, 3);
  circuit.controlledNot(0, 1);
  circuit.toffoli(1, 2, 3);
  circuit.controlledNot(1, 2);
  circuit.controlledNot(0, 1);

  describe(circuit);
  draw(circuit);

  for (var a = 0; a <= 1; a++) {
    for (var b = 0; b <= 1; b++) {
      final qreg = QRegister([
        if (a == 1) Qbit.one else Qbit.zero,
        if (b == 1) Qbit.one else Qbit.zero,
        Qbit.zero,
        Qbit.zero
      ]);

      print('[$a/$b] Initial: ${stateInfo(qreg.probabilities)}');

      circuit.execute(qreg);

      print('[$a/$b] Outcome: ${stateInfo(qreg.probabilities)}');

      final result = qreg.read(qubits: [3, 2]);

      print('[$a/$b] $a + $b = $result');
    }
  }
}
