# Complex Matrix Abstraction and Optimization Plan

## 1. Objective

Provide a common `ComplexMatrix` abstraction while preserving the existing quantum simulation API and the dense/sparse implementations that are now in place.

The current concrete implementations are:

```text
ComplexMatrix        public abstraction
ComplexDenseMatrix   dense array-backed implementation
ComplexSparseMatrix  sparse CSR-backed implementation used by default
ComplexVector        dense vector derived from ComplexDenseMatrix
```

The design no longer relies on a builder-level representation selector. The default implementation path is sparse for gate construction and tensor products, while `det` and `inverse` still fall back to dense conversion when the algorithm requires it.

The performance priority remains matrix-vector application in quantum gates, while preserving numeric behavior and mutable semantics of the current API.

## 2. Current State

### 2.1 `ComplexMatrix`

`lib/src/math/complex_matrix.dart` currently provides the common contract:

- dimension validation and metadata;
- storage-agnostic `get`/`set` operations;
- copy, clone, and serialization helpers;
- arithmetic and scalar operations;
- transposition, conjugation, and dagger;
- determinant and inversion via dense fallback for sparse matrices;
- equality and formatting helpers.

The abstraction is implemented by `ComplexDenseMatrix` and `ComplexSparseMatrix`, and `deserialize` selects the concrete type based on the serialized payload.

### 2.2 `ComplexDenseMatrix`

The dense implementation remains the baseline for algorithms that are easiest to express on a direct array layout. It preserves the historical behavior of determinant, inversion, and direct element access.

### 2.3 `ComplexSparseMatrix`

`ComplexSparseMatrix` stores non-zero entries in CSR format:

```text
rowOffsets    length rows + 1
columnIndices length of non-zero values
values        length of non-zero values
```

The invariant is that zero entries are never stored. This makes row-wise traversal efficient and keeps sparse operations focused on non-zero data.

### 2.4 `ComplexVector`

`ComplexVector` derives from `ComplexDenseMatrix` and preserves the vector-specific constructors and current API shape.

## 3. Current Architecture

### 3.1 Public Contract

`ComplexMatrix` exposes the common behavior used throughout the project:

- `rows`, `columns`, `isSquare`;
- `get(row, column)` and necessary mutation operations;
- `clone`, `copy`, `copyFrom`, `copyTo`;
- `add`, `sub`, `neg`, `mul`, `div`;
- `det`, `inverse`, `transpose`, `dagger`, `conjugate`;
- `equals`, `toStringIndent`, `serialize`;
- operators `+`, `-`, `*`, `/`.

The public factory patterns continue to work through the concrete classes without requiring a global choice at the builder level.

### 3.2 Sparse-By-Default Behavior

The implementation now uses `ComplexSparseMatrix` by default in the places that construct or compose gate matrices. For example, the tensor operation is implemented as a static factory on `ComplexSparseMatrix`:

```dart
static ComplexSparseMatrix tensor(ComplexMatrix a, ComplexMatrix b) {
  // sparse-aware construction
}
```

This is the current default for gate composition in `lib/src/qgate_builder.dart`, where full gate matrices are built using `ComplexSparseMatrix.tensor(...)`.

### 3.3 Dense Fallbacks

Some algorithms remain dense-oriented because they are easier to reason about and more efficient with direct array access. In particular:

- `ComplexDenseMatrix.det` remains the dense implementation;
- `ComplexSparseMatrix.det` and `ComplexSparseMatrix.inverse()` temporarily convert the sparse matrix to dense before computing the result;
- this avoids fill-in issues during Gaussian elimination and preserves correctness without introducing more complex sparse elimination logic.

## 4. API Compatibility

### 4.1 Construction Patterns

`ComplexMatrix` is an abstract contract and does not currently expose the legacy public factory constructors described in earlier drafts. Construction is done through the concrete implementations:

```dart
final dense = ComplexDenseMatrix.generate(rows, columns, (r, c) => value);
final sparse = ComplexSparseMatrix.generate(rows, columns, (r, c) => value);

final zeroDense = ComplexDenseMatrix.zero(rows, columns);
final zeroSparse = ComplexSparseMatrix.zero(rows, columns);

final identity = ComplexSparseMatrix.identity(size);
```

`ComplexMatrix.base` exists only as an internal debug hook for warning output and is not part of the supported public API; it should not be documented as a supported constructor pattern.

### 4.2 Mutable Operations

The `add`, `sub`, `neg`, `mul`, and `div` methods mutate the current object and return it. This behavior remains the expected API contract.

Each implementation removes values that become zero, and dense/sparse variants compare logically rather than by internal storage layout.

### 4.3 Static Operations

The tensor product is currently implemented as a concrete static operation on `ComplexSparseMatrix`, and the vector-level tensor helper remains in `ComplexVector`.

This design keeps tensor composition aligned with the sparse-by-default implementation and reduces the need for representation-specific builder plumbing.

### 4.4 Equality and Precision

`equals` compares dimensions and logical values without depending on storage. A dense matrix and a mathematically identical sparse matrix therefore compare equal within the configured precision.

### 4.5 Serialization

The serialized payload includes a kind discriminator so `ComplexMatrix.deserialize` can reconstruct the appropriate concrete type. Sparse matrices currently deserialize directly to `ComplexSparseMatrix`, while dense payloads use `ComplexDenseMatrix.deserialize`.

## 5. Implementation Strategy by Phases

### Phase 0 - Reference

- Validate current behavior with `dart test` and `dart analyze`.
- Record the current shape of `ComplexVector`, serialization, and gate composition.
- Establish the dense/sparse parity baseline.

### Phase 1 - Dense Extraction

- Move the original array-backed implementation into `ComplexDenseMatrix`.
- Preserve `ComplexVector` as a dense vector specialization.
- Keep the public API stable while the abstract contract is introduced.

### Phase 2 - Abstraction and Compatibility

- Introduce `ComplexMatrix` as the common abstract type.
- Ensure dense and sparse implementations satisfy the same public contract.
- Restore the public API and adapt construction sites to the current concrete classes.

### Phase 3 - Sparse Implementation

- Add `ComplexSparseMatrix` with CSR storage.
- Implement zero and identity without dense allocation.
- Implement `get`, `set`, `clone`, `copy`, `equals`, and serialization.
- Keep the structure sparse by removing zero values during mutation.

### Phase 4 - Sparse Operations

Implement the optimized sparse paths that are already required by the quantum simulation layer:

1. sparse multiplication by vector;
2. sparse multiplication by matrix;
3. addition and subtraction by CSR row merging;
4. sparse tensor product;
5. in-place `mul` with a compatible temporary result.

For matrix-vector multiplication, the pattern is:

```text
for each row r:
    result[r] = sum(values[k] * vector[columnIndices[k]])
```

This keeps work proportional to the number of non-zero values rather than the full `rows * columns` area.

### Phase 5 - Simulation Integration

- Use sparse matrix-vector paths when applying quantum gates.
- Avoid unnecessary dense conversion for normal sparse gate application.
- Verify representative circuits, entanglement, and compiled gates.

### Phase 6 - Determinant and Inverse

- Preserve dense computation for `ComplexDenseMatrix`.
- Temporarily convert `ComplexSparseMatrix` to dense for `det` and `inverse`.
- Document the memory cost of the fallback and keep the algorithm stable.

This approach is appropriate because sparse elimination can introduce fill-in that erases the advantage of the sparse representation.

### Phase 7 - Documentation and Validation

- Update the public docs and implementation notes to reflect the sparse-by-default behavior.
- Keep documentation aligned with the current code paths, especially tensor product construction and the dense fallback for inverse/determinant operations.
- Check that examples and tests keep using the current API without requiring representation-specific builder configuration.

### Phase 8 - Benchmarks

Once the implementation is stable, benchmarks can compare dense and sparse behavior on:

- zero and identity matrices;
- one- and two-qubit gates;
- controlled gates;
- QFT and random dense matrices;
- matrix-matrix and matrix-vector multiplication;
- repeated gate application.

The goal is to document the relevance domain of each representation rather than preserve a builder-parameter selection model that no longer exists.

## 6. Test Coverage to Maintain

### Contract Tests

- invalid dimensions throw the same exceptions;
- arithmetic results preserve their mutating semantics;
- `clone` does not share mutable storage;
- `copy` rejects incompatible dimensions.

### Representation Tests

- sparse zero matrices contain no stored values;
- sparse identity matrices store only the diagonal;
- `set(row, column, Complex.zero)` removes an entry;
- dense and sparse variants generate the same logical values;
- non-zero counts stay consistent after operations.

### Numeric Tests

- complex numbers with imaginary parts;
- addition and subtraction with cancellation;
- multiplication and tensor product;
- transpose, dagger, and conjugate;
- determinant and inverse;
- dense/sparse parity with tolerance.

### Quantum Tests

- superposition and Bell states;
- controlled gates;
- SWAP, Toffoli, and Fredkin gates;
- QFT and inverse QFT;
- measurements and compiled circuits;
- OpenQASM execution paths.

## 7. Risks and Mitigations

### Access to Private Storage

Algorithms should not depend on implementation-specific storage layout. Use the public contract or a shared internal protocol when needed.

### Densification of Results

Sparsity can be lost during operations that create many non-zero values. This is expected in some gate compositions and should be evaluated with benchmarks rather than optimized prematurely.

### Gaussian Elimination

`det` and `inverse` may densify a sparse matrix internally. The current fallback preserves correctness while avoiding more invasive sparse elimination logic.

## 8. Acceptance Criteria

The work is complete when:

- the public `ComplexMatrix` API remains stable;
- dense and sparse implementations match logically for key operations;
- sparse matrices are the default path for gate composition and tensor products;
- determinant and inverse remain correct via dense fallback;
- serialization preserves the concrete type correctly;
- simulation and OpenQASM tests continue to pass;
- documentation reflects the current sparse-by-default implementation rather than the older builder-configured model.

## 9. Retained Decisions

1. Keep the names `ComplexMatrix`, `ComplexDenseMatrix`, `ComplexSparseMatrix`, and `ComplexVector`.
2. Preserve `ComplexVector` as a dense vector specialization.
3. Keep `ComplexSparseMatrix` as the default sparse implementation for gate composition and tensor products.
4. Prefer sparse row-wise operations when possible.
5. Temporarily convert sparse matrices to dense for determinant and inverse.
6. Serialize a discriminated payload so the correct concrete implementation can be restored.
7. Keep documentation grounded in the actual implementation rather than stale abstraction plans.

## 10. Implementation Tracking

Legend for sub-steps:

- `[ ]` to do
- `[-]` in progress
- `[x]` done

### [x] Phase 0 - Reference

- `[x]` Establish the correctness and parity baseline.

### [x] Phase 1 - Dense Extraction

- `[x]` Move the dense implementation into `ComplexDenseMatrix`.
- `[x]` Preserve `ComplexVector` as a dense specialization.
- `[x]` Keep the public API stable during the transition.

### [x] Phase 2 - Abstraction and Compatibility

- `[x]` Introduce the `ComplexMatrix` abstraction.
- `[x]` Restore the public API and adapt consumer references.
- `[x]` Keep dense and sparse implementations interoperable.

### [x] Phase 3 - Sparse Implementation

- `[x]` Add `ComplexSparseMatrix`.
- `[x]` Implement CSR storage and zero-removal behavior.
- `[x]` Implement `get`, `set`, `clone`, `copy`, and equality.
- `[x]` Implement sparse serialization.

### [x] Phase 4 - Sparse Operations

- `[x]` Implement sparse multiplication by vector.
- `[x]` Implement sparse multiplication by matrix.
- `[x]` Implement addition and subtraction with sparse-aware updates.
- `[x]` Implement sparse tensor product.
- `[x]` Keep the implementation compatible with in-place scalar operations.

### [ ] Phase 5 - Simulation Integration

- `[x]` Gate application is routed through `QMemorySpace.applyGate` and `ComplexVector.transform`, which use the sparse matrix-vector path when the gate is sparse.
- `[x]` Sparse matrix multiplication and tensor composition are implemented in the current codebase.
- `[ ]` Eliminate avoidable dense conversion in all non-sparse gate paths.
- `[ ]` Verify the remaining advanced gate families and compiled circuits in the simulation layer.
- `[ ]` Run a complete sparse-vs-dense parity pass for the circuit and OpenQASM execution paths.

### [x] Phase 6 - Determinant and Inverse

- `[x]` Preserve dense determinant behavior for `ComplexDenseMatrix`.
- `[x]` Use dense conversion for `ComplexSparseMatrix.det` and `ComplexSparseMatrix.inverse()`.
- `[x]` Document the fallback as the current correctness path.

### [x] Phase 7 - Documentation and Validation

- `[x]` Align the documentation with the current implementation.
- `[x]` Remove stale references to the older builder representation selection model.
- `[x]` Confirm the sparse-by-default tensor implementation matches the codebase.

### [ ] Phase 8 - Benchmarks

- `[ ]` Measure dense versus sparse memory and runtime characteristics.
- `[ ]` Compare matrix-vector and matrix-matrix multiplication.
- `[ ]` Document the practical relevance domain of each representation.
