## 0.9.1

Math optimizations:
- Implement sparse matrices.

OpenQASM update:
- Add support for external constants (provided at runtime).

Implement Shor algorithm (see `example\openqasm\shor_factorization.dart`):
- Usage: `dart run shor_factorization.dart "13 * 3"`
- The quantum part is implemented dynamically as a QASM program
- The classical route is ignored to force quantum evaluation

## 0.9.0

Added OpenQASM 3.0 support:
- `OpenQASMParser`: provides an ANTLR4-based parser for OpenQASM 3.0 source code.
- `OpenQASMInterpreter`: an asynchronous interpreter to execute OpenQASM 3.0 programs.
    - support for quantum and classical memory spaces.
    - support for complex control flow: `if/else`, `for` loops, `while` loops, `break` and `continue`.
    - support for `gate` and `def` (subroutines) declarations.
    - included standard gate library (`stdgates.inc`) with native optimizations for most common gates.
    - supports program observers for step-by-step execution monitoring.
    - extensible `IncludeProvider` for loading external files.

Other changes:
- `QCircuit`: Added ASCII drawer support via `QCircuitAsciiDrawer`.
- `ComplexMatrix`: Performance optimizations for matrix operations.
- Improved exception handling for quantum circuit operations.

## 0.0.5

`qgate_builder.dart` (was `qgates.dart`)
- Refactored gate builders used when adding a gate to a circuit
    * unitary gates = parallel gates operating on one qubit
    * controlled gates can now be controlled by several qubits

`qcircuit.dart`
- Simplify `QCircuit` APIs to support parallel and controlled gates via a single method.
    * changed `hadamard()`, `pauliX()`, ... to accept a single or a set of qubits as input, optionaly controlled by a single or a set of qubits
    * removed `parallelHadamard()`, `controlledHadamard()`, `parallelPauliX()`, `controlledPauliX()`, ...
- Added step-by-step execution to facilitate diagnostics during execution.
- Added the possibility to compile a circuit:
    * successive measurement gates are reduced to a single step measuring several qubits.
    * successive quantum gates are reduced to a single quantum gate obtained by multiplying the gate's matrices together.
    * at the end of the compilation process, the circuit is reduced to a sequence of quantum / measurement gates
    * if there is no measurement gate, it is reduced to a single quantum gate

`example`
- Added examples for addition of 2-qubits and 3-qubits values via QFT.

## 0.0.1

- Initial version.
