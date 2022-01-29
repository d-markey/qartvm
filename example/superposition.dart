import 'package:qartvm/qartvm.dart';

import 'utils.dart';

void main() {
  // Superposition
  // Hadamard gates applied on qubits 1 & 2
  //
  //         ---
  //  0 ----| H |----
  //         ---
  //
  //  1 -------------
  //
  //         ---
  //  2 ----| H |----
  //         ---
  final circuit = QCircuit(size: 3);
  circuit.hadamard({0, 2});

  describe(circuit);
  draw(circuit);

  final qreg = QRegister.zero(3);
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

  print('measured qubit 1 = $b');
  print(
      ' * amplitudes after measurement of qubit 1: ${amplInfo(qreg.amplitudes, fractionDigits: 6)}');
  print(
      ' * probabilities after measurement of qubit 1: ${probInfo(qreg.probabilities, fractionDigits: 6)}');

  final c = qreg.read(qubits: [2]);

  print('measured qubit 2 = $c');
  print(
      ' * amplitudes after measurement of qubit 2: ${amplInfo(qreg.amplitudes, fractionDigits: 6)}');
  print(
      ' * probabilities after measurement of qubit 2: ${probInfo(qreg.probabilities, fractionDigits: 6)}');
}
