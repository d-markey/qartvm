# AGENTS.md - Developer Guide for AI Agents

This document provides context, architectural overview, and guidelines for contributing to the `qartvm` project.

## 1. Project Overview

`qartvm` (pronounced '*kar-toom*') is a quantum computing simulation package for Dart & Flutter. It supports quantum circuit definition, built-in and custom gates, and execution via a state-vector simulator.

- **Primary Goal**: Provide a flexible and efficient environment for simulating quantum algorithms.
- **Key Features**: Parallel and controlled gates, circuit compilation, ASCII drawing, and OpenQASM 3.0 support.

## 2. Core Architecture

### Quantum Circuit (`QCircuit`)
The `QCircuit` class is the central point for defining quantum algorithms.
- Use `gateBuilder` to add gates (Hadamard, Pauli, Rotations, etc.).
- `separation()` adds visual separators.
- `measure()` adds measurement gates.
- `compile()` optimizes the circuit by merging consecutive non-measurement gates.

### Quantum Memory (`QMemorySpace` / `QRegister`)
- `QMemorySpace` handles the underlying state vector (amplitudes).
- `QRegister` is a higher-level abstraction for a set of qubits.
- Initial states are usually `zero` (all |0>).

### OpenQASM 3.0
- `OpenQASMParser`: Converts QASM source to an AST.
- `OpenQASMInterpreter`: Asynchronously executes the AST.
- Support for `stdgates.inc` via `DefaultIncludeProvider`.

## 3. Codebase Structure

- `lib/src/`: Core implementation.
    - `math/`: Complex numbers and matrix arithmetic.
    - `openqasm/`: Parser, interpreter, and grammar.
- `test/`: Comprehensive unit tests.
    - `openqasm/`: Tests for the QASM interpreter and parser.
- `example/`: Practical examples (Bell state, Bernstein-Vazirani, Grover, etc.).
- `tools/`: Utility scripts and ANTLR4 grammar files.

## 4. Development Guidelines

### Accuracy & Testing
- **Verify results**: Quantum mechanics is counter-intuitive. Always run existing tests (`dart test`) after modifications.
- **Test varied states**: Ensure unit tests do not only operate on **computational basis states** like `|0>` or `|1>`. Relative phase and entanglement are only detectable (and thus verifiable) when the system is in a **superposition** (like `|+>`), as basis states do not exhibit the quantum interference necessary to catch subtle implementation errors.
- **Precision**: Use `Complex` and `ComplexMatrix` for all quantum operations to maintain numerical stability.

### Performance
- **Matrix Multiplication**: Avoid unnecessary matrix allocations. Use `ComplexMatrix.copy()`, `mul()`, and other in-place operations when possible.
- **Compilation**: Encourage the use of `QCircuit.compile()` for performance-critical scenarios.

### OpenQASM Compatibility
- When adding new gates to the core, consider if they should be mapped in the `OpenQASMInterpreter`'s standard gate library.

## 5. Helpful Tools for Agents

- **Diagnostics**: Use `QCircuitAsciiDrawer` to visualize circuits during debugging.
- **Documentation**: Refer to `README.md` for high-level usage and `CHANGELOG.md` for recent feature updates.
- **GitHub Discussions**: Check for existing issues or patterns if you encounter complex quantum logic.

## 6. Communication
When proposing changes, explain the quantum logic behind them, as it helps human reviewers verify the correctness of the simulation.
