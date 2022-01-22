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

Some examples are provided in the `/example` folder.

## Bell State

```dart
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
```

Output:

```
 * hadamard on [0]
 * pauliX on [1] controlled by [0]
          ---
   0 ====| H |==== X ======
          ---
                 -----
   1 ===========| NOT |====
                 -----
Possible states: 00 (50 %), 11 (50 %)
Measured 11 (100 %)
```

## 2-Qubit Full Adder

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

## Qubit Teleportation

```dart
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

  final qreg = QRegister([ Qbit.random(), Qbit.zero, Qbit.zero ]);

  print('Initial state ${stateInfo(qreg.probabilities)}');
  final alice0 = qreg.getPropability('0..');
  final alice1 = qreg.getPropability('1..');
  print('   Alice: 0 (${(alice0 * 100).toStringAsFixed(2)} %) / 1 (${(alice1 * 100).toStringAsFixed(2)} %)');

  circuit.execute(qreg);

  print('Possible states: ${stateInfo(qreg.probabilities)}');
  final bob0 = qreg.getPropability('..0');
  final bob1 = qreg.getPropability('..1');
  print('   Bob  : 0 (${(bob0 * 100).toStringAsFixed(2)} %) / 1 (${(bob1 * 100).toStringAsFixed(2)} %)');
```

Output:

```
 * hadamard on [1]
 * pauliX on [2] controlled by [1]
 * pauliX on [1] controlled by [0]
 * hadamard on [0]
 * measure [0, 1]
 * pauliX on [2] controlled by [1]
 * pauliZ on [2] controlled by [0]
                                   ---
   0 ====================== X ====| H |===[ / ]============= X =====
                                   ---
          ---             -----
   1 ====| H |==== X ====| NOT |==========[ / ]===== X =============
          ---             -----
                 -----                             -----    ---     
   2 ===========| NOT |===========================| NOT |==| Z |====
                 -----                             -----    ---     
Initial state 000 (81 %), 100 (19 %)
   Alice: 0 (80.75 %) / 1 (19.25 %)
Possible states: 010 (81 %), 011 (19 %)
   Bob  : 0 (80.75 %) / 1 (19.25 %)
```

## Custom Gate (Fredkin example)

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
