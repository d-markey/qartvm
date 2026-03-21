OPENQASM 3.0;
include "stdgates.inc";

// --- Main Program ---
qubit[3] my_qubits;

def teleport_global() {
    h my_qubits[1];
    cx my_qubits[1], my_qubits[2];
    
    cx my_qubits[0], my_qubits[1];
    h my_qubits[0];
    
    bit c0 = measure my_qubits[0];
    bit c1 = measure my_qubits[1];
    
    if (c1 == 1) { x my_qubits[2]; }
    if (c0 == 1) { z my_qubits[2]; }
}

bit final_check;

// 1. Prepare a state to teleport on my_qubits[0]
// Let's teleport the |-> state
x my_qubits[0];
h my_qubits[0];

// 2. Call the subroutine
teleport_global();

// 3. Verify on Bob's qubit (my_qubits[2])
// To verify |->, apply H and check for '1'
h my_qubits[2];
final_check = measure my_qubits[2];