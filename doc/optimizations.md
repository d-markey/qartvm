# QARTVM Performance Optimizations

This document tracks the "special recipes" and architectural optimizations implemented to enable high-efficiency quantum simulation in `qartvm`, specifically allowing complex algorithms like Shor's to run on standard hardware.

## 1. Memory Optimizations (Breaking the $2^N$ Matrix Barrier)

### Local Gate Application
*   **Problem**: Standard simulators create a transformation matrix of size $2^N \times 2^N$. For $N=25$, a single matrix requires $>30$ GB of RAM.
*   **Solution**: For circuits where $N > 20$, the engine bypasses global matrix construction. Instead of expanding a gate (like Toffoli) to the full Hilbert space, it returns a local $2^k \times 2^k$ matrix (where $k$ is the number of qubits involved).
*   **Implementation**: `QMemorySpace._applyLocalGate` identifies bit-slices in the state vector and applies the small local matrix directly to the relevant amplitudes.
*   **Impact**: Reduced RAM usage for $N=25$ from **32+ GB** to **~1.5 GB**.

### Automatic Cache Safeguard
*   **Optimization**: The gate cache in `OpenQASMInterpreter` and `QGateBuilder` is automatically disabled or limited for circuits $>20$ qubits. This prevents the "Memory Explosion" that occurs when caching large sparse matrices.

---

## 2. Speed Optimizations (The "Formula 1" Engine)

### Constant-Time Bit-Spreading (The Subtract-AND Trick)
*   **Problem**: Finding all base indices in the state vector where target qubits are $|0\rangle$ usually requires an $O(N)$ loop of bit-shifts per iteration.
*   **Solution**: Implemented the mathematical identity: `baseIndex = (baseIndex - ~targetMask) & ~targetMask`.
*   **Impact**: This allows the simulator to jump to the next valid amplitude slice in **constant time $O(1)$** using just 3 CPU instructions, bypassing millions of loop cycles per gate call.

### Zero-Allocation Inner Loop
*   **Problem**: Dart's object allocation for `Complex` numbers inside $O(2^N)$ loops causes massive Garbage Collection (GC) pressure.
*   **Solution**: The simulation loop in `_applyLocalGate` works directly on the underlying `Float64List` of the state vector. It "gathers" amplitudes into local `double` variables, performs manual complex multiplication (`ac-bd + (ad+bc)i`), and "scatters" them back.
*   **Impact**: Eliminated millions of object allocations per gate, reducing $N=21$ Ripple-Carry runtime from **77 minutes to 17 minutes**.

### Sparse-First Local Math
*   **Optimization**: Even in the local path ($2^k \times 2^k$), the engine now pre-extracts non-zero entries of the gate. For a Toffoli gate ($8\times8$), this reduces the inner math from **64** complex operations to just **8**.

---

## 3. Algorithmic Refinements for Shor's Algorithm

### Identity Short-Circuiting
*   **Optimization**: The modular exponentiation generators (Synthesis, QFT, Ripple) now detect when a modular multiplier is an identity operation ($a^{2^j} \equiv 1 \pmod N$) and omit the corresponding gates entirely.

### Correct Adjoint/Uncomputation Logic
*   **Fix**: Implemented the correct adjoint sequences for the Cuccaro Ripple-Carry adder (`maj_dg` and `uma_dg`) and Draper QFT adder.
*   **Fix**: Ensured that "underflow" ancilla qubits (`aux`) are explicitly unentangled (reset to $|0\rangle$) after modular additions. Without this, interference decoherence prevents the correct probability peaks from forming.

### Simulator-Specific Register Sizing
*   **Optimization**: Reduced the control register size ($nx$) for small $N$ simulations (e.g., $nx=4$ for $N=15$). This provides enough precision for the Continued Fraction algorithm to identify the order $r$ while significantly accelerating the simulation by reducing the state vector size.
