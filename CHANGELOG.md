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
