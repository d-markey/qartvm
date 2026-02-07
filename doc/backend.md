# QartVM Backend Documentation

The QartVM backend provides the core primitives for simulating quantum circuits. It consists of three main components that work together to represent and execute quantum operations:

1.  **QMemorySpace**: Represents the quantum state (qubits and amplitudes).
2.  **QCircuit**: Represents a sequence of quantum gates (program).
3.  **QGateBuilder**: Constructs the unitary matrices for quantum gates.

## QMemorySpace (`lib/src/qmemory_space.dart`)

`QMemorySpace` is the simulation engine. It holds the state vector of the quantum system.

### Initialization
You can initialize a memory space in several ways:

```dart
// Zero state |0...0>
var qmem = QMemorySpace.zero(3); 

// One state |1...1>
var qmem2 = QMemorySpace.one(3);

// Superposition |+> state
var qmem3 = QMemorySpace.plus(3);

// Load an integer value (basis state)
var qmem4 = QMemorySpace.load(5, size: 3); // |101>
```

### Features
-   **Registers**: You can define named registers (e.g., `q[0]`, `q[1]`) mapping to physical qubit indices.
-   **State Access**: Access amplitudes and probabilities of basis states. `qmem.probabilities` returns a map of states (e.g., "001") to their probabilities.
-   **Measurement**: 
    -   `measure(qubits)`: Collapses the wave function based on the probability of outcomes for specific qubits.
    -   `read(qubits)`: Measures and returns the integer representation of the classical result.
-   **Gate Application**: `applyGate(matrix, qubits)` applies a unitary matrix to specific qubits.

## QCircuit (`lib/src/qcircuit.dart`)

`QCircuit` represents a quantum circuit as a sequence of gates. It supports a fluent API for building circuits.

### Building Circuits
Circuits are built by chaining gate operations.

```dart
final circuit = QCircuit(gateBuilder)
  .h([0])              // Hadamard on wire 0
  .cx([0, 1])          // CNOT (Control 0, Target 1)
  .measure();          // Measure all qubits
```

### Supported Gates
The circuit supports various gate types via helper methods:
-   **Standard**: `hadamard`, `pauliX`, `pauliY`, `pauliZ`, `phase`, `rotationX/Y/Z`.
-   **Controlled**: All standard gates can be controlled using the `controls` parameter.
-   **Multi-Qubit**: `swap`, `fredkin` (CSWAP), `toffoli` (CCNOT).
-   **High-Level**: `qft` (Quantum Fourier Transform) and `invQft`.

### Compilation
`QCircuit` includes a simple compiler to optimize execution.
```dart
// Merges consecutive non-measurement gates into single matrices
// to reduce the number of matrix multiplications during simulation.
circuit.compile();
```

### Execution
Circuits can be executed on a `QMemorySpace`. supports "step-by-step" execution with observers.

```dart
circuit.execute(qmem);

// Or step-by-step
while (circuit.step(qmem)) {
  // Inspect qmem state after each gate
}
```

## QGateBuilder (`lib/src/qgate_builder.dart`)

`QGateBuilder` is responsible for generating the complex matrices corresponding to quantum gates.

### Capabilities
-   **Matrix Construction**: It constructs full system matrices from smaller gate definitions (Tensor Products).
-   **Controlled Gates**: It automatically constructs matrices for controlled gates by determining the appropriate projectors and operations.
-   **Caching**: It optionally caches generated matrices to improve performance when the same gates are used repeatedly (e.g., via `ParallelGateBuilder` and `ControlledGateBuilder`).

### Key Builders
-   `parallel`: Builds matrices for gates operating in parallel (tensor product with Identity).
-   `controlled`: Builds matrices for controlled operations (Projector |1> ⊗ U + Projector |0> ⊗ I).
-   `highLevel`: Builds matrices for complex gates like QFT or Toffoli composed of simpler primitives (cached for efficiency).
