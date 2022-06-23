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

  final qmem = QMemorySpace.zero(3);

  final alice = qmem.createRegister('Alice', at: 0);
  final bob = qmem.createRegister('Bob', at: 2);

  final gateBuilder = QGateBuilder.get(qmem.size);

  final circuit = QCircuit(gateBuilder);
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
  draw(circuit, qmem: qmem);
  checkTeleportation(circuit, qmem, alice, bob);

  circuit.compile();

  print('');
  print('Verification after compilation');
  describe(circuit);
  draw(circuit);
  checkTeleportation(circuit, qmem, alice, bob);
}

void checkTeleportation(
    QCircuit circuit, QMemorySpace qmem, QRegister alice, QRegister bob) {
  // initialize Alice's qubit with a random state
  final qmem = QMemorySpace([Qbit.random(), Qbit.zero, Qbit.zero]);

  qmem.initialize({
    alice: [Qbit.random()],
    bob: [Qbit.zero],
  });

  print('Initial states: ${amplInfo(qmem, fractionDigits: 6)}');
  final alice0 = qmem.getPropability('0..');
  final alice1 = qmem.getPropability('1..');
  print(
      '   Alice: 0 (${percent(alice0, fractionDigits: 2)}) / 1 (${percent(alice1, fractionDigits: 2)})');

  circuit.execute(qmem);

  // Bob's qubit will have same probabilities as Alice's initial qubit
  print('Final states: ${amplInfo(qmem, fractionDigits: 6)}');
  final bob0 = qmem.getPropability('..0');
  final bob1 = qmem.getPropability('..1');
  print(
      '   Bob  : 0 (${percent(bob0, fractionDigits: 2)}) / 1 (${percent(bob1, fractionDigits: 2)})');

  if ((bob0 - alice0).abs() > 1e-9 || (bob1 - alice1).abs() > 1e-9) {
    throw Exception('Teleportation failed');
  }
}
