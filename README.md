qartvm (pronounced '*kar-toom*', like the capital of Sudan) is a quantum computing simulation package for Dart & Flutter.

# Features

* Quantum circuit definition

* Buit-in quantum gates:
  * Hadamard
  * Pauli X (NOT), Y, Z
  * Phase S, T & custom
  * Parallel single-qubit gates
  * Controlled gates (single-qubit with single qubit control)
  * Higher-level gates:
    * swap
    * Toffoli (CC-NOT)
    * Fredkin (C-SWAP)
    * Quantum Fourrier Transform (QFT) and inverse QFT

* Custom quantum gates

* Quantum register (n-qubits)

# Examples

Some examples are provided in the [`/example`](https://github.com/d-markey/qartvm/tree/main/example) folder.

## [Bell State](https://github.com/d-markey/qartvm/blob/main/example/bell_state.dart)

```dart
  final circuit = QCircuit(size: 2);
  circuit.hadamard(0);
  circuit.controlledNot(0, 1);

  describe(circuit);
  draw(circuit);

  final qreg = QRegister.zero(2);
  print('Initial states');
  print(' * amplitudes:    ${amplInfo(qreg.amplitudes, fractionDigits: 6)}');
  print(' * probabilities: ${probInfo(qreg.probabilities, fractionDigits: 2)}');
  circuit.execute(qreg);
  print('Final states');
  print(' * amplitudes:    ${amplInfo(qreg.amplitudes, fractionDigits: 6)}');
  print(' * probabilities: ${probInfo(qreg.probabilities, fractionDigits: 2)}');
```

Output:

```
 * hadamard on [0]
 * pauliX on [1] controlled by [0]
          ---
   0 ----| H |---- X ------
          ---
                 -----
   1 -----------| NOT |----
                 -----
Initial states
 * amplitudes:    00 (1.000000)
 * probabilities: 00 (100.00 %)
Final states
 * amplitudes:    00 (0.707107), 11 (0.707107)
 * probabilities: 00 (50.00 %), 11 (50.00 %)
```

## [Qubit Full Adder](https://github.com/d-markey/qartvm/blob/main/example/one_qubit_full_adder.dart)

```dart
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
```

Output:

```
 * toffoli on [3] controlled by [0, 1]
 * pauliX on [1] controlled by [0]
 * toffoli on [3] controlled by [1, 2]
 * pauliX on [2] controlled by [1]
 * pauliX on [1] controlled by [0]

   0 ======= X ======== X =========================== X ======

                      -----                         -----
   1 ======= X ======| NOT |===== X ======== X ====| NOT |====
                      -----                         -----
                                           -----
   2 ============================ X ======| NOT |=============
                                           -----
          --------             --------
   3 ====| CC-NOT |===========| CC-NOT |======================
          --------             --------
[0/0] Initial: 0000 (100 %)
[0/0] Outcome: 0000 (100 %)
[0/0] 0 + 0 = 0
[0/1] Initial: 0100 (100 %)
[0/1] Outcome: 0110 (100 %)
[0/1] 0 + 1 = 1
[1/0] Initial: 1000 (100 %)
[1/0] Outcome: 1010 (100 %)
[1/0] 1 + 0 = 1
[1/1] Initial: 1100 (100 %)
[1/1] Outcome: 1101 (100 %)
[1/1] 1 + 1 = 2
```

## [Addition of 2 2-qubit registers](https://github.com/d-markey/qartvm/blob/main/example/two_qubit_full_adder.dart)

```dart
  // qubit #   =  input bit /  result bit
  //    0      =      a0    /    (a+b)0
  //    1      =      a1    /    (a+b)1
  //    2      =      a2    /    (a+b)2 (carry)
  //    3      =      b0    /      b0
  //    4      =      b1    /      b1
  //    5      =      |0>                           (suppressed as this qubit is useless)
  final circuit = QCircuit(size: 5);

  circuit.qft([2, 1, 0]);

  // circuit.controlledPhase(5, 2, math.pi); // suppressed because qubit 5 is always |0>
  circuit.controlledPhase(4, 2, math.pi / 2);
  circuit.controlledPhase(3, 2, math.pi / 4);

  circuit.controlledPhase(4, 1, math.pi);
  circuit.controlledPhase(3, 1, math.pi / 2);

  circuit.controlledPhase(3, 0, math.pi);

  circuit.invQft([2, 1, 0]);

  describe(circuit);
  draw(circuit);

  final sw = Stopwatch();

  sw.start();
  verifyAddition(circuit);
  sw.stop();
  print('Completed in ${sw.elapsed} before compilation, total executions = $_nbExec (${sw.elapsedMicroseconds.toDouble() / _nbExec} µs/execution)');

  circuit.compile();

  describe(circuit);
  draw(circuit);

  sw.reset();
  sw.start();
  verifyAddition(circuit);
  sw.stop();
  print('Completed in ${sw.elapsed} after compilation, total executions = $_nbExec (${sw.elapsedMicroseconds.toDouble() / _nbExec} µs/execution)');
```

Output:

```
 * qft on [2, 1, 0]
 * phase 0.5 pi on [2] controlled by [4]
 * phase 0.25 pi on [2] controlled by [3]
 * phase 1.0 pi on [1] controlled by [4]
 * phase 0.5 pi on [1] controlled by [3]
 * phase 1.0 pi on [0] controlled by [3]
 * invqft on [2, 1, 0]
          -----                                                                 -----------    ---------     
   0 ----| QFT |---------------------------------------------------------------| P(1.0 pi) |--| INV-QFT |----
         |     |                                                                -----------   |         |    
         |     |                                  -----------    -----------                  |         |    
   1 ----| QFT |---------------------------------| P(1.0 pi) |--| P(0.5 pi) |-----------------| INV-QFT |----
         |     |                                  -----------    -----------                  |         |    
         |     |   -----------    ------------                                                |         |    
   2 ----| QFT |--| P(0.5 pi) |--| P(0.25 pi) |-----------------------------------------------| INV-QFT |----
          -----    -----------    ------------                                                 ---------

   3 --------------------------------- X ---------------------------- X ------------ X ----------------------


   4 ------------------ X ---------------------------- X ----------------------------------------------------

[0/0] Outcome: 0 + 0 = {0: 100}
[0/1] Outcome: 0 + 1 = {1: 100}
[0/2] Outcome: 0 + 2 = {2: 100}
[0/3] Outcome: 0 + 3 = {3: 100}
[1/0] Outcome: 1 + 0 = {1: 100}
[1/1] Outcome: 1 + 1 = {2: 100}
[1/2] Outcome: 1 + 2 = {3: 100}
[1/3] Outcome: 1 + 3 = {4: 100}
[2/0] Outcome: 2 + 0 = {2: 100}
[2/1] Outcome: 2 + 1 = {3: 100}
[2/2] Outcome: 2 + 2 = {4: 100}
[2/3] Outcome: 2 + 3 = {5: 100}
[3/0] Outcome: 3 + 0 = {3: 100}
[3/1] Outcome: 3 + 1 = {4: 100}
[3/2] Outcome: 3 + 2 = {5: 100}
[3/3] Outcome: 3 + 3 = {6: 100}
[4/0] Outcome: 4 + 0 = {4: 100}
[4/1] Outcome: 4 + 1 = {5: 100}
[4/2] Outcome: 4 + 2 = {6: 100}
[4/3] Outcome: 4 + 3 = {7: 100}
Completed in 0:00:01.382940 before compilation, total executions = 12000 (115.245 µs/execution)
 * qft on [2, 1, 0] followed by phase 0.5 pi on [2] controlled by [4] followed by phase 0.25 pi on [2] controlled by [3] followed by phase 1.0 pi on [1] controlled by [4] followed by phase 0.5 pi on [1] controlled by [3] followed by phase 1.0 pi on [0] controlled by [3] followed by invqft on [2, 1, 0]
          ----------
   0 ----| COMPILED |----
         |          |
         |          |
   1 ----| COMPILED |----
         |          |
         |          |
   2 ----| COMPILED |----
          ----------

   3 -------- X ---------


   4 -------- X ---------

[0/0] Outcome: 0 + 0 = {0: 100}
[0/1] Outcome: 0 + 1 = {1: 100}
[0/2] Outcome: 0 + 2 = {2: 100}
[0/3] Outcome: 0 + 3 = {3: 100}
[1/0] Outcome: 1 + 0 = {1: 100}
[1/1] Outcome: 1 + 1 = {2: 100}
[1/2] Outcome: 1 + 2 = {3: 100}
[1/3] Outcome: 1 + 3 = {4: 100}
[2/0] Outcome: 2 + 0 = {2: 100}
[2/1] Outcome: 2 + 1 = {3: 100}
[2/2] Outcome: 2 + 2 = {4: 100}
[2/3] Outcome: 2 + 3 = {5: 100}
[3/0] Outcome: 3 + 0 = {3: 100}
[3/1] Outcome: 3 + 1 = {4: 100}
[3/2] Outcome: 3 + 2 = {5: 100}
[3/3] Outcome: 3 + 3 = {6: 100}
[4/0] Outcome: 4 + 0 = {4: 100}
[4/1] Outcome: 4 + 1 = {5: 100}
[4/2] Outcome: 4 + 2 = {6: 100}
[4/3] Outcome: 4 + 3 = {7: 100}
Completed in 0:00:00.425942 after compilation, total executions = 12000 (35.49516666666667 µs/execution)
```

## [Qubit Teleportation](https://github.com/d-markey/qartvm/blob/main/example/qubit_teleportation.dart)

```dart
  final circuit = QCircuit(size: 3);
  circuit.hadamard(1);
  circuit.controlledNot(1, 2);
  circuit.controlledNot(0, 1);
  circuit.hadamard(0);
  circuit.measure(qubits: {0});
  circuit.measure(qubits: {1});
  circuit.controlledNot(1, 2);
  circuit.controlledPauliZ(0, 2);

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
```

Output:

```
Verification before compilation
 * hadamard on [1]
 * pauliX on [2] controlled by [1]
 * pauliX on [1] controlled by [0]
 * hadamard on [0]
 * measure [0]
 * measure [1]
 * pauliX on [2] controlled by [1]
 * pauliZ on [2] controlled by [0]
                                   ---
   0 ---------------------- X ----| H |---[ / ]---------------------- X -----
                                   ---
          ---             -----
   1 ----| H |---- X ----| NOT |-------------------[ / ]----- X -------------
          ---             -----
                 -----                                      -----    ---
   2 -----------| NOT |------------------------------------| NOT |--| Z |----
                 -----                                      -----    ---
Initial states: 000 (0.467916 + 0.773411 i), 100 (-0.427065 + 0.022487 i)
   Alice: 0 (81.71 %) / 1 (18.29 %)
Final states: 100 (0.467916 + 0.773411 i), 101 (-0.427065 + 0.022487 i)
   Bob  : 0 (81.71 %) / 1 (18.29 %)

Verification after compilation
 * hadamard on [1] followed by pauliX on [2] controlled by [1] followed by pauliX on [1] controlled by [0] followed by hadamard on [0]
 * measure [0, 1]
 * pauliX on [2] controlled by [1] followed by pauliZ on [2] controlled by [0]
          ----------
   0 ----| COMPILED |---[ / ]------- X ---------
         |          |
         |          |
   1 ----| COMPILED |---[ / ]------- X ---------
         |          |
         |          |            ----------
   2 ----| COMPILED |-----------| COMPILED |----
          ----------             ----------
Initial states: 000 (-0.131496 + 0.329310 i), 100 (0.892845 + 0.277653 i)
   Alice: 0 (12.57 %) / 1 (87.43 %)
Final states: 000 (-0.131496 + 0.329310 i), 001 (0.892845 + 0.277653 i)
   Bob  : 0 (12.57 %) / 1 (87.43 %)
```

## [Custom Gate (Fredkin example)](https://github.com/d-markey/qartvm/blob/main/example/fredkin_implementation.dart)

```dart
  print('');
  print('USING STANDARD GATES');

  final fredkinCircuitWithStandardGates = QCircuit(size: 3);
  fredkinCircuitWithStandardGates.controlledNot(2, 1);
  fredkinCircuitWithStandardGates.toffoli(0, 1, 2);
  fredkinCircuitWithStandardGates.controlledNot(2, 1);

  describe(fredkinCircuitWithStandardGates);
  draw(fredkinCircuitWithStandardGates);
  verifyFredkin(fredkinCircuitWithStandardGates);

  print('');
  print('USING CUSTOM GATE');

  final cnot21 = QGates.controlled(3).not(2, 1);
  final toffoli012 = QGates.highLevel(3).toffoli(0, 1, 2);
  // Here, the custom Fredkin gate matrix is computed by multiplying
  // the matrices of the standard gates that make it up.
  // The Fredkin matrix (hard-coded) could have been provided as well.
  final myFredkinGate = cnot21 * toffoli012 * cnot21;
  final fredkinType = QGateType('My Fredkin gate', 'MY-C-SWAP');
  final fredkinCircuitWithCustomGate = QCircuit(size: 3);
  fredkinCircuitWithCustomGate.custom({1, 2}, myFredkinGate, controls: {0}, type: fredkinType);

  print(myFredkinGate.toStringIndent(1));
  describe(fredkinCircuitWithCustomGate);
  draw(fredkinCircuitWithCustomGate);
  verifyFredkin(fredkinCircuitWithCustomGate);

  print('');
  print('USING BUILT-IN GATE');

  final fredkinCircuitWithBuiltInGate = QCircuit(size: 3);
  fredkinCircuitWithBuiltInGate.fredkin(0, 1, 2);

  describe(fredkinCircuitWithBuiltInGate);
  draw(fredkinCircuitWithBuiltInGate);
  verifyFredkin(fredkinCircuitWithBuiltInGate);
```

Output:

```
USING STANDARD GATES
 * pauliX on [1] controlled by [2]       
 * toffoli on [2] controlled by [0, 1]   
 * pauliX on [1] controlled by [2]       

   0 ================ X =================

          -----                -----
   1 ====| NOT |===== X ======| NOT |====
          -----                -----
                   --------
   2 ====== X ====| CC-NOT |==== X ======
                   --------
Initial: 000 (100 %) => Outcome: 000 (100 %): OK
Initial: 001 (100 %) => Outcome: 001 (100 %): OK
Initial: 010 (100 %) => Outcome: 010 (100 %): OK
Initial: 011 (100 %) => Outcome: 011 (100 %): OK
Initial: 100 (100 %) => Outcome: 100 (100 %): OK
Initial: 101 (100 %) => Outcome: 110 (100 %): OK
Initial: 110 (100 %) => Outcome: 101 (100 %): OK
Initial: 111 (100 %) => Outcome: 111 (100 %): OK

USING CUSTOM GATE
   [
      [1, 0, 0, 0, 0, 0, 0, 0],
      [0, 1, 0, 0, 0, 0, 0, 0],
      [0, 0, 1, 0, 0, 0, 0, 0],
      [0, 0, 0, 1, 0, 0, 0, 0],
      [0, 0, 0, 0, 1, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 1, 0],
      [0, 0, 0, 0, 0, 1, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 1]
   ]
 * My Fredkin gate on [1, 2] controlled by [0]

   0 ========= X =========

          -----------
   1 ====| MY-C-SWAP |====
         |           |    
         |           |
   2 ====| MY-C-SWAP |====
          -----------
Initial: 000 (100 %) => Outcome: 000 (100 %): OK
Initial: 001 (100 %) => Outcome: 001 (100 %): OK
Initial: 010 (100 %) => Outcome: 010 (100 %): OK
Initial: 011 (100 %) => Outcome: 011 (100 %): OK
Initial: 100 (100 %) => Outcome: 100 (100 %): OK
Initial: 101 (100 %) => Outcome: 110 (100 %): OK
Initial: 110 (100 %) => Outcome: 101 (100 %): OK
Initial: 111 (100 %) => Outcome: 111 (100 %): OK

USING BUILT-IN GATE
 * fredkin on [1, 2] controlled by [0]

   0 ======= X ========

          --------
   1 ====| C-SWAP |====
         |        |
         |        |
   2 ====| C-SWAP |====
          --------
Initial: 000 (100 %) => Outcome: 000 (100 %): OK
Initial: 001 (100 %) => Outcome: 001 (100 %): OK
Initial: 010 (100 %) => Outcome: 010 (100 %): OK
Initial: 011 (100 %) => Outcome: 011 (100 %): OK
Initial: 100 (100 %) => Outcome: 100 (100 %): OK
Initial: 101 (100 %) => Outcome: 110 (100 %): OK
Initial: 110 (100 %) => Outcome: 101 (100 %): OK
Initial: 111 (100 %) => Outcome: 111 (100 %): OK
```
