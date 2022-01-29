import 'package:qartvm/qartvm.dart';

import 'utils.dart';

void main() {
  // Bell state (superposition + entanglement)
  //
  //         ---
  //  0 ----| H |---- X ------
  //         ---
  //                -----
  //  1 -----------| NOT |----
  //                -----

  final circuit = QCircuit(size: 2);
  circuit.hadamard(0);
  circuit.not(1, controls: 0);

  describe(circuit);
  draw(circuit);

  final qreg = QRegister.zero(circuit.size);
  print('Initial states');
  print(' * amplitudes:    ${amplInfo(qreg.amplitudes, fractionDigits: 6)}');
  print(' * probabilities: ${probInfo(qreg.probabilities, fractionDigits: 2)}');

  circuit.execute(qreg);

  print('Final states');
  print(' * amplitudes:    ${amplInfo(qreg.amplitudes, fractionDigits: 6)}');
  print(' * probabilities: ${probInfo(qreg.probabilities, fractionDigits: 2)}');

  print('');

  final a = qreg.read(qubits: [0]);

  print('measured qubit 0 = $a');
  print(
      ' * amplitudes after measurement of qubit 0: ${amplInfo(qreg.amplitudes, fractionDigits: 6)}');
  print(
      ' * probabilities after measurement of qubit 0: ${probInfo(qreg.probabilities, fractionDigits: 6)}');

  final b = qreg.read(qubits: [1]);

  if (a != b) {
    throw Exception('Measurement of qubit 1 yielded unexpected result $b');
  }
}
