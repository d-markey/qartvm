import 'package:qartvm/qartvm.dart';

import 'utils.dart';

void main() {
  final circuit = QCircuit(size: 2);
  circuit.hadamard(0);
  circuit.controlledNot(0, 1);

  describe(circuit);
  draw(circuit);

  final qreg = QRegister.zero(2);

  circuit.execute(qreg);

  print('Possible states: ${stateInfo(qreg.probabilities)}');

  qreg.measure();

  print('Measured ${stateInfo(qreg.probabilities)}');
}
