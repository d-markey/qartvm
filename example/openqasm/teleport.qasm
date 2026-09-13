OPENQASM 3.0;
include "stdgates.inc";

// --- Main Program ---
qubit alice;
qubit bob;
qubit anc;

def teleport_global() {
    h anc;
    cx anc, bob;
    
    cx alice, anc;
    h alice;
    
    bit c0 = measure alice;
    bit c1 = measure anc;
    
    if (c1 == 1) { x bob; }
    if (c0 == 1) { z bob; }
}

bit final_check;

// 1. Prepare a state to teleport on alice
// Let's teleport the |-> state
x alice;
h alice;

// 2. Call the subroutine
teleport_global();

// 3. Verify on Bob's qubit
// To verify |->, apply H and check for '1'
h bob;
final_check = measure bob;
