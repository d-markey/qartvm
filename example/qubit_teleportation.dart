import 'package:qartvm/qartvm.dart';

import 'utils.dart';

void main() {
  final circuit = QCircuit(size: 3);
  circuit.hadamard(1);
  circuit.controlledNot(1, 2);
  circuit.controlledNot(0, 1);
  circuit.hadamard(0);
  circuit.measure(qubits: {0, 1});
  circuit.controlledNot(1, 2);
  circuit.controlledPauliZ(0, 2);

  describe(circuit);
  draw(circuit);

  final qreg = QRegister([Qbit.random(), Qbit.zero, Qbit.zero]);

  print('Initial state ${stateInfo(qreg.probabilities)}');
  final alice0 = qreg.getPropability('0..');
  final alice1 = qreg.getPropability('1..');
  print(
      '   Alice: 0 (${(alice0 * 100).toStringAsFixed(2)} %) / 1 (${(alice1 * 100).toStringAsFixed(2)} %)');

  circuit.execute(qreg);

  print('Possible states: ${stateInfo(qreg.probabilities)}');
  final bob0 = qreg.getPropability('..0');
  final bob1 = qreg.getPropability('..1');
  print(
      '   Bob  : 0 (${(bob0 * 100).toStringAsFixed(2)} %) / 1 (${(bob1 * 100).toStringAsFixed(2)} %)');
}
