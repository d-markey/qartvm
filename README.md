# qartvm 🧪 

[![Pub Version](https://img.shields.io/pub/v/qartvm?color=blue&style=flat-square)](https://pub.dev/packages/qartvm)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](https://opensource.org/licenses/MIT)
[![Build Status](https://img.shields.io/github/actions/workflow/status/d-markey/qartvm/dart.yml?style=flat-square)](https://github.com/d-markey/qartvm/actions)

**qartvm** (pronounced '*kar-toom*') is a high-performance, flexible Quantum Computing Simulation package for **Dart & Flutter**. Whether you are building quantum algorithms from scratch or executing OpenQASM 3.0 programs, qartvm provides the tools you need with a clean, expressive API.

---

## 🚀 Key Features

*   **Expressive Circuit Definition**: Build complex circuits with ease using a fluent API.
*   **Comprehensive Gate Library**:
    *   **Standard**: Hadamard, Pauli (X, Y, Z), Phase (S, T), Rotations (RX, RY, RZ).
    *   **High-Level**: Swap, Toffoli (CC-NOT), Fredkin (C-SWAP).
    *   **Advanced**: Quantum Fourier Transform (QFT) and Inverse QFT.
*   **OpenQASM 3.0 Support**: Full support for parsing and interpreting OpenQASM 3.0 source code.
*   **Low-Level "Bare" Engine**: Direct access to the underlying state vector and register management.
*   **Circuit Compilation**: Optimize and merge non-measurement gates for maximum simulation performance.
*   **Visualization**: Built-in ASCII drawer for quick circuit debugging and visualization in the console.

---

## 📦 Quick Start

### Installation

Add `qartvm` to your `pubspec.yaml`:

```yaml
dependencies:
  qartvm: ^0.9.0
```

### Your First Circuit: Bell State

Creating an entangled pair (Bell state) is straightforward:

```dart
import 'package:qartvm/qartvm.dart';

void main() {
  final circuit = QCircuit(size: 2);
  circuit.hadamard(0);
  circuit.controlledNot(0, 1);

  final qreg = QRegister.zero(2);
  circuit.execute(qreg);

  print('Final Probabilities: ${qreg.probabilities}');
  // Output: {00: 0.5, 11: 0.5}
}
```

---

## 🛠️ The "Bare" Simulation Engine

While `QCircuit` is great for high-level algorithm design, **qartvm** exposes its low-level components if you need fine-grained control over the quantum state.

### `QMemorySpace`
The heart of the simulation. It manages the underlying state vector (amplitudes) and handles the actual linear algebra operations.

```dart
// Create a 4-qubit memory space initialized to |0000>
final qmem = QMemorySpace.zero(4);

// Directly apply a complex gate matrix to specific qubits
qmem.applyGate(myCustomMatrix, {0, 1});
```

### `QRegister`
A flexible way to group and address qubits within a `QMemorySpace`.

```dart
// Create a 2-qubit register pointing to addresses 0 and 1
final alice = qmem.createRegister('alice', addresses: [0, 1]);

// Read only Alice's register (it will trigger a partial measurement)
final result = alice.read();
```

### `ComplexMatrix`
A robust math engine for quantum mechanics, optimized for complex number arithmetic.

```dart
final hadamard = ComplexMatrix.generate(2, 2, (r, c) => ...);
final tensorProd = ComplexMatrix.tensor(hadamard, identity);
```

---

## 🌌 OpenQASM 3.0 Support

**qartvm** features a full-featured OpenQASM 3.0 interpreter, allowing you to run industry-standard quantum programs directly within your Dart application.

### Basic Execution

```dart
import 'package:qartvm/openqasm.dart';

final qasmSource = '''
OPENQASM 3.0;
include "stdgates.inc";
qubit[2] q;
h q[0];
cx q[0], q[1];
''';

final program = OpenQASMParser.parse(qasmSource);
final interpreter = OpenQASMInterpreter();
final result = await interpreter.execute(program);

print('Quantum state after QASM execution: ${result.quantumMemory?.probabilities}');
```

### Advanced Features
*   **Standard Gates**: Full support for `stdgates.inc`.
*   **Custom Include Providers**: Plug in your own logic for loading include files from remote URLs, databases, or local assets.
*   **Observers**: Hook into the execution flow to monitor state transitions step-by-step.

---

## 🎨 Visualizing Circuits

Debugging quantum circuits can be tricky. Use the `QCircuitAsciiDrawer` to see what you're building:

```dart
          ---
   0 ----| H |---- X ------
          ---
                 -----
   1 -----------| NOT |----
                 -----
```

Simply call `draw(circuit)` (from the provided utilities) or use the drawer directly to render any circuit.

---

## 📚 Examples Library

Explore our comprehensive examples to learn more:

<details>
<summary><b>Fundamental Circuits</b></summary>

*   [Bell State](https://github.com/d-markey/qartvm/blob/main/example/bell_state.dart): Creating entanglement.
*   [Superposition](https://github.com/d-markey/qartvm/blob/main/example/superposition.dart): Basic Hadamard transformations.

</details>

<details>
<summary><b>Arithmetic & Algorithms</b></summary>

*   [Qubit Full Adder](https://github.com/d-markey/qartvm/blob/main/example/one_qubit_full_adder.dart): A 1-bit full adder using Toffoli gates.
*   [2-Qubit Addition](https://github.com/d-markey/qartvm/blob/main/example/two_qubit_full_adder.dart): Using QFT (Quantum Fourier Transform).
*   [Shor's Algorithm](https://github.com/d-markey/qartvm/tree/main/example/shor): Period finding and factorization.

</details>

<details>
<summary><b>Communication & Protocols</b></summary>

*   [Qubit Teleportation](https://github.com/d-markey/qartvm/blob/main/example/qubit_teleportation.dart): Transferring quantum information via entanglement.
*   [Phase Kickback](https://github.com/d-markey/qartvm/blob/main/example/phase_kickback.dart): demonstrating the phase oracle effect.

</details>

---

## ⚡ Optimization

### Circuit Compilation

For performance-critical simulations, always compile your circuit before execution. This merges consecutive non-measurement gates into single operations, significantly reducing the number of matrix multiplications.

```dart
circuit.compile(); // Optimizes the gates
circuit.execute(qreg);
```

---

## 🤝 Contributing

Contributions are welcome! Please see the [AGENTS.md](https://github.com/d-markey/qartvm/blob/main/AGENTS.md) for developer guidelines and technical architecture overview.

---

*Built with ❤️ for the Quantum Community.*
