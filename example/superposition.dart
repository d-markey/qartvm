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

  final qmem = QMemorySpace.zero(3);
  final qa = qmem.createRegister('a', at: 0);
  final qb = qmem.createRegister('b', at: 1);
  final qc = qmem.createRegister('c', at: 2);
  final gateBuilder = QGateBuilder.get(qmem.size);
  final circuit = QCircuit(gateBuilder);
  circuit.hadamard({0, 2});

  describe(circuit);
  draw(circuit, qmem: qmem);

  print('Initial states');
  print(' * amplitudes:    ${amplInfo(qmem, fractionDigits: 6)}');
  print(' * probabilities: ${probInfo(qmem, fractionDigits: 2)}');
  circuit.execute(qmem);
  print('Final states');
  print(' * amplitudes:    ${amplInfo(qmem, fractionDigits: 6)}');
  print(' * probabilities: ${probInfo(qmem, fractionDigits: 2)}');

  print('');

  final a = qa.read();

  print('measured qubit 0 = $a');
  print(
      ' * amplitudes after measurement of qubit 0: ${amplInfo(qmem, fractionDigits: 6)}');
  print(
      ' * probabilities after measurement of qubit 0: ${probInfo(qmem, fractionDigits: 6)}');

  final b = qb.read();

  print('measured qubit 1 = $b');
  print(
      ' * amplitudes after measurement of qubit 1: ${amplInfo(qmem, fractionDigits: 6)}');
  print(
      ' * probabilities after measurement of qubit 1: ${probInfo(qmem, fractionDigits: 6)}');

  final c = qc.read();

  print('measured qubit 2 = $c');
  print(
      ' * amplitudes after measurement of qubit 2: ${amplInfo(qmem, fractionDigits: 6)}');
  print(
      ' * probabilities after measurement of qubit 2: ${probInfo(qmem, fractionDigits: 6)}');
}
