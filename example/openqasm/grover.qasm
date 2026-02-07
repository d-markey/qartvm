OPENQASM 3;
// include "stdgates.inc";

qubit[2] q;
bit[2] result;

// 1. Initialize uniform superposition
h q[0];
h q[1];

// 2. Oracle: mark |11⟩ by phase flip
// Implemented as a controlled-Z
cz q[0], q[1];

// 3. Diffuser (inversion about the mean)
h q[0];
h q[1];

x q[0];
x q[1];

cz q[0], q[1];

x q[0];
x q[1];

h q[0];
h q[1];

// 4. Measure
measure q -> result;
