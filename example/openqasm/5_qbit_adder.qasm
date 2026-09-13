OPENQASM 3.0;
include "stdgates.inc";

// input values
input int a_in;
input int b_in;

// --- CUSTOM QUANTUM GATES ---
gate maj c_in, a, b {
    cx b, a;
    cx b, c_in;
    ccx a, c_in, b;
}
gate uma c_in, a, b {
    ccx a, c_in, b;
    cx b, c_in;
    cx c_in, a;
}

// --- WRITE integers TO quantum registers ----
// OpenQASM 3.0 uses Little-Endian: reg[0] is the LSB (2^0).
def write_int(int n, qubit[5] reg) {
    for int i in [0 : 4] {
        if ((n >> i) & 1) { x reg[i]; }
    }
}

// --- REGISTERS ---
qubit[6] qa; // stores a_in initially, then final sum + carry-out
qubit[5] qb; // stores b_in
qubit carry_in;

// --- INITIALIZATION ---
write_int(a_in, qa);
write_int(b_in, qb);

// --- STEP 1: RIPPLE CARRY FORWARD ---
maj carry_in, qa[0], qb[0];
maj qb[0], qa[1], qb[1];
maj qb[1], qa[2], qb[2];
maj qb[2], qa[3], qb[3];
maj qb[3], qa[4], qb[4];

// --- STEP 2: OVERFLOW ---
cx qb[4], qa[5];

// --- STEP 3: UNCOMPUTE & SUM ---
uma qb[3], qa[4], qb[4];
uma qb[2], qa[3], qb[3];
uma qb[1], qa[2], qb[2];
uma qb[0], qa[1], qb[1];
uma carry_in, qa[0], qb[0];

// --- MEASURE ---
// Direct register measurement returns the integer value (LSB at index 0)
int res = measure qa;
