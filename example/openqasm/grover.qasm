OPENQASM 3;
include "stdgates.inc";

input int target;

qubit[2] q;
bit[2] result;

// 1. Initialize uniform superposition
h q;

// 2. Oracle: mark |target⟩ by phase flip
// We flip qubits that should be 0 in the target state so that
// the target state becomes |11> for the cz gate.
if ((target & 1) == 0) { x q[0]; }
if ((target & 2) == 0) { x q[1]; }

cz q[0], q[1];

if ((target & 1) == 0) { x q[0]; }
if ((target & 2) == 0) { x q[1]; }

// 3. Diffuser (inversion about the mean)
h q;
x q;
cz q[0], q[1];
x q;
h q;

// 4. Measure
measure q -> result;
