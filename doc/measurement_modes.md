# Measurement Modes in QartVM

QartVM supports two modes for measuring qubits: **Independent** and **Joint**. This document explains the differences, the implementation details, and why joint measurement is often the preferred choice for multi-qubit registers.

## Overview

Measurement in a quantum simulator involves two steps:
1.  **Selection**: Choosing a result based on the probability distribution of the current state.
2.  **Collapse**: Updating the state vector (amplitudes) to reflect the measured outcome and renormalizing.

### Independent Measurement (`QMeasureMode.independent`)

In this mode (the default), qubits are measured one by one. For each qubit:
-   The simulator calculates the probability of the qubit being in state $|0\rangle$ or $|1\rangle$.
-   A random choice is made.
-   The entire state vector is collapsed and normalized according to that single bit.
-   The process repeats for the next qubit in the set.

### Joint Measurement (`QMeasureMode.joint`)

In this mode, the simulator treats the set of qubits as a single entity:
-   It calculates the joint probability distribution for all possible configurations of the target qubits (e.g., for 3 qubits, it finds the probabilities for "000", "001", ..., "111").
-   A single random choice is made from this joint distribution.
-   The entire state vector is collapsed and normalized once based on the multi-bit result.

## Why Joint Measurement is Superior for Multi-Qubits

### 1. Performance (Efficiency)
In a state-vector simulator with $N$ qubits, calculating probabilities involves iterating over $2^N$ amplitudes.
-   **Independent**: Measuring $k$ qubits requires $k$ passes over the state vector (once per bit) and $k$ collapse operations. Complexity: $O(k \cdot 2^N)$.
-   **Joint**: Regardless of how many qubits are being measured, the simulator makes a **single pass** to accumulate the joint probabilities and a **single collapse** operation. Complexity: $O(2^N)$.
For large registers, this results in a significant speedup.

### 2. Numerical Stability
Renormalizing the state vector after each bit measurement involves dividing amplitudes by the square root of the probability. Repeating this $k$ times can accumulate small floating-point errors. Performing a single collapse reduces these scaling operations to a minimum, preserving higher precision.

### 3. Conceptual Clarity (Atomicity)
Joint measurement ensures that the correlation between entangled qubits is captured in a single atomic step. While mathematically equivalent to sequential measurement, joint measurement more closely aligns with how users think about measuring a "register" as a single classical value.

## Usage

You can control the measurement mode at the `QMemorySpace` level or override it during a `read` or `measure` call.

### Setting Default Mode
```dart
final qmem = QMemorySpace.zero(8);
qmem.measureMode = QMeasureMode.joint; // All subsequent reads will use joint mode
```

### Overriding for a Single Read
```dart
final register = qmem.createRegister('q', addresses: [0, 1, 2]);
final result = register.read(mode: QMeasureMode.joint);
```

### Direct Memory Measure
```dart
qmem.measure(qbits: {QbitAddress(0), QbitAddress(1)}, mode: QMeasureMode.joint);
```

## Implementation Details

The joint mode leverages the `getProbabilities(mask)` method of `QMemorySpace`. It uses a mask where target qubits are marked with `'*'` (match anything) and others with `'.'` (ignored). 

1.  **Mask Generation**: `{0, 1}` on a 4-qubit space becomes `**..`.
2.  **Probability Accumulation**: `getProbabilities('**..')` returns a map of all observed configurations for the first two qubits (e.g., `{"00": 0.25, "01": 0.25, "10": 0.25, "11": 0.25}`).
3.  **Selection**: A random number selects a key from the map.
4.  **Assignment**: The bits of the selected key are assigned back to the `QState` objects.
5.  **Collapse**: `_collapse()` is called once to zero out incompatible amplitudes and rescale the remaining ones.

## Next Steps: Biased Measurement (Biased Selection)

In some simulation scenarios, it is useful to "favor" certain outcomes even if they are not the most likely in the raw quantum state. This is known as **Biased Measurement** or **Importance Sampling**.

### Proposed Mechanism: `QProbabilityTransform`

We can introduce a transformation function that modifies the joint probability distribution before the random selection happens:

```dart
typedef QProbabilityTransform = Map<String, double> Function(Map<String, double> raw);
```

This transform would be applied during [Joint Measurement](#joint-measurement-qmeasuremodejoint) between the **Probability Accumulation** and **Selection** steps. After the transform, the resulting probabilities are re-normalized to sum to 1.0.

### Biasing Laws

Several mathematical laws can be used to bias the measurement:

#### 1. Poisson Bias
Useful when we want to favor outcomes near a specific value $\lambda$ (e.g., focusing on a specific frequency or result range).
$$P'_{joint}(x) \propto P_{joint}(x) \cdot \frac{\lambda^x e^{-\lambda}}{x!}$$

#### 2. Gaussian Bias
Favoring outcomes within a certain distance from a mean $\mu$ with standard deviation $\sigma$.
$$P'_{joint}(x) \propto P_{joint}(x) \cdot e^{-\frac{(x-\mu)^2}{2\sigma^2}}$$

#### 3. Amplification (Power Law)
Enhancing the peaks of the distribution to make high-probability states even more likely to be picked, or flattening the distribution to explore rare states.
$$P'_{joint}(x) \propto P_{joint}(x)^\gamma$$
- $\gamma > 1$: Sharpens the distribution (favors peaks).
- $0 < \gamma < 1$: Flattens the distribution (favors rare outcomes).

### Use Cases
- **Quantum Monte Carlo**: Selecting paths that contribute most to the variance reduction.
- **Search Optimization**: In algorithms like Grover's, biasing towards a suspected region can improve average-case performance in a noisy simulation.
- **Hardware Simulation**: Modeling T1/T2 relaxation or gate errors that systematically favor $|0\rangle$ or $|1\rangle$ states.

### Workflow Integration
The `read` and `measure` methods would accept an optional `transform` parameter.

#### Single-Qubit Reads
Biased measurement is fully compatible with single-qubit reads. By specifying `mode: QMeasureMode.joint` for a single qubit, the simulator passes a 2-entry map (`{'0': p, '1': 1-p}`) to the transform, allowing for precise control over single-bit measurement results.

#### Noise Simulation (Readout Errors)
This mechanism is ideal for simulating imperfect measurement hardware:
- **Bit-Flip Noise**: A transform that swaps a small percentage of probability between '0' and '1' outcomes.
- **Correlated Noise**: In multi-qubit registers, certain configurations (like '11') might have higher error rates due to hardware cross-talk. A joint transform can model these correlations atomically.
- **Thermal Decay**: Favoring $|0\rangle$ outcomes to simulate a system that tends to relax to the ground state during the measurement process.

```dart
// Example: 2% readout error simulation on a single qubit
final res = qmem.read(
  qbits: [0],
  mode: QMeasureMode.joint,
  transform: QBias.readoutError(p0to1: 0.02, p1to0: 0.01)
);
```
