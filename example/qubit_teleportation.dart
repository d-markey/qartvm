import 'package:qartvm/qartvm.dart';

import 'utils.dart';

void main() {
  // Qubit teleportation
  //
  // Protocol:
  // * ALICE owns qubit 0 (here simulated by a random qubit)
  // * TELAMON creates a Bell state with qubits 1 & 2 (entanglement)
  // * TELAMON gives qubit 1 to ALICE and qubit 2 to BOB
  // * ALICE applies a Pauli X operation on qubit 1 controlled by her qubit 0 (entanglement) then qubit 0 goes through a Hadamard gate
  // * ALICE measures her results (qubits 0 & 1) and sends the outcomes to BOB (quantum states are destroyed on ALICE's side)
  // * BOB performs some operations on qubit 2 depending on ALICE's results
  // * BOB's qubit 2 is now in the initial state of qubit 0
  //
  //                                           ---
  //  ALICE    0 ---------------------- X ----| H |---[ / ]---------------------- X -----  --> measured (destroyed)
  //                                           ---
  //                  ---             -----
  //  TELAMON  1 ----| H |---- X ----| NOT |-------------------[ / ]----- X -------------  --> measured (destroyed)
  //                  ---             -----
  //                         -----                                      -----    ---
  //  BOB      2 -----------| NOT |------------------------------------| NOT |--| Z |----  --> "copy" of ALICE's qubit 0
  //                         -----                                      -----    ---
  //
  final circuit = QCircuit(size: 3);
  circuit.hadamard(1);
  circuit.not(2, controls: 1);
  circuit.not(1, controls: 0);
  circuit.hadamard(0);
  circuit.measure({0});
  circuit.measure({1});
  circuit.not(2, controls: {1});
  circuit.pauliZ(2, controls: {0});

  print('');
  print('Verification before compilation');
  describe(circuit);
  draw(circuit);
  checkTeleportation(circuit);

  circuit.compile();

  print('');
  print('Verification after compilation');
  describe(circuit);
  draw(circuit);
  checkTeleportation(circuit);
}

void checkTeleportation(QCircuit circuit) {
  // initialize Alice's qubit with a random state
  final qreg = QRegister([Qbit.random(), Qbit.zero, Qbit.zero]);

  print('Initial states: ${amplInfo(qreg.amplitudes, fractionDigits: 6)}');
  final alice0 = qreg.getPropability('0..');
  final alice1 = qreg.getPropability('1..');
  print(
      '   Alice: 0 (${percent(alice0, fractionDigits: 2)}) / 1 (${percent(alice1, fractionDigits: 2)})');

  circuit.execute(qreg);

  // Bob's qubit will have same probabilities as Alice's initial qubit
  print('Final states: ${amplInfo(qreg.amplitudes, fractionDigits: 6)}');
  final bob0 = qreg.getPropability('..0');
  final bob1 = qreg.getPropability('..1');
  print(
      '   Bob  : 0 (${percent(bob0, fractionDigits: 2)}) / 1 (${percent(bob1, fractionDigits: 2)})');

  if ((bob0 - alice0).abs() > 1e-9 || (bob1 - alice1).abs() > 1e-9) {
    throw Exception('Teleportation failed');
  }

  print('');

  final a = qreg.read(qubits: [0]);
  final b = qreg.read(qubits: [2]);

  print(
      'States after measurement: ${amplInfo(qreg.amplitudes, fractionDigits: 6)}');
  print(
      'Probabilities after measurement: ${probInfo(qreg.probabilities, fractionDigits: 6)}');

  // measurements may be different between Alice and Bob because Alice's qubit state has been destroyed in the process
  print('Alice = $a, Bob = $b');
}
