import 'dart:math' as math;

import 'math/complex.dart';
import 'math/complex_dense_matrix.dart';
import 'math/complex_matrix.dart';
import 'math/complex_sparse_matrix.dart';
import 'qstate.dart';
import 'utils/cache_entry_stat.dart';
import 'utils/disengageable_cache.dart';
import 'utils/exceptions.dart';

// ignore: non_constant_identifier_names
final _0 = Complex.zero;
// ignore: non_constant_identifier_names
final _1 = Complex.one;
final _i = Complex.i;

String _key(Iterable<QbitAddress> qbits) => (qbits.toList()..sort()).join('-');

class _Operators {
  static final identity = ComplexSparseMatrix.identity;

  static final ComplexMatrix I = ComplexDenseMatrix([
    [_1, _0],
    [_0, _1],
  ]);

  // HADAMARD

  static final ComplexMatrix H = ComplexDenseMatrix([
    [_1, _1],
    [_1, -_1],
  ]).mul(math.sqrt1_2);

  // PAULI

  static final ComplexMatrix X = ComplexDenseMatrix([
    [_0, _1],
    [_1, _0],
  ]);

  static final ComplexMatrix Y = ComplexDenseMatrix([
    [_0, -_i],
    [_i, _0],
  ]);

  static final ComplexMatrix Z = ComplexDenseMatrix([
    [_1, _0],
    [_0, -_1],
  ]);

  // ignore: non_constant_identifier_names
  static final ComplexMatrix SqrtX = ComplexDenseMatrix([
    [_1 + _i, _1 - _i],
    [_1 - _i, _1 + _i],
  ]).div(2);

  // PHASE

  static ComplexMatrix phase(double radians) => ComplexDenseMatrix([
    [_1, _0],
    [_0, Complex(re: math.cos(radians), im: math.sin(radians))],
  ]);

  static final ComplexMatrix S = ComplexDenseMatrix([
    [_1, _0],
    [_0, _i],
  ]);

  static final ComplexMatrix T = ComplexDenseMatrix([
    [_1, _0],
    [_0, (_1 + _i) * math.sqrt1_2],
  ]);

  // ROTATION

  static ComplexMatrix rotationX(double radians) => ComplexDenseMatrix([
    [_1 * math.cos(radians / 2), -_i * math.sin(radians / 2)],
    [-_i * math.sin(radians / 2), _1 * math.cos(radians / 2)],
  ]);

  static ComplexMatrix rotationY(double radians) => ComplexDenseMatrix([
    [_1 * math.cos(radians / 2), -_1 * math.sin(radians / 2)],
    [_1 * math.sin(radians / 2), _1 * math.cos(radians / 2)],
  ]);

  static ComplexMatrix rotationZ(double radians) => ComplexDenseMatrix([
    [Complex.polar(radius: 1, angle: -radians / 2), _0],
    [_0, Complex.polar(radius: 1, angle: radians / 2)],
  ]);
}

/// Class used to build [QCircuitGate] matrices for [QCircuit] of size [size]
class ParallelGateBuilder {
  ParallelGateBuilder._(this.size, {bool withCache = false})
    : _cache = DisengageableCache(
        enabled: withCache,
        maxEntries: (size * 3) ~/ 4,
      );

  /// Size of the [QCircuit] for which this builder can build matrices
  final int size;

  final DisengageableCache<ComplexMatrix> _cache;

  /// Builds a matrix for a [gate] operating on [qbits].
  /// [gate] may be a 2x2 matrix in which case the full transformation matrix will be computed as the tensor
  /// product of [gate] for qubits in [qbits], and the 2x2 identity matrix for other qubits.
  /// Alternatively, [gate] may also be a square matrix of size 2^[size] in which case it is returned as is.
  /// [qbits] are not used when [gate] is not a 2x2 matrix.
  ComplexMatrix build(Set<QbitAddress> qbits, ComplexMatrix gate) {
    if (gate.rows == 2 && gate.columns == 2) {
      // Fast path for large circuits: return local 2x2 matrix.
      // QCircuitGate.apply will handle the broadcasting to multiple qubits.
      if (size > 20) return gate;

      if (qbits.length == 1) {
        final targetBit = qbits.single.bigEndianMask(size);
        final dim = 1 << size, builder = ComplexSparseMatrixBuilder(dim, dim);

        if (gate.isDiagonal) {
          // Pure diagonal gate (Phase, Z, RZ, etc.)
          final u00 = gate.get(0, 0), u11 = gate.get(1, 1);
          for (var r = 0; r < dim; r++) {
            final val = ((r & targetBit) == 0) ? u00 : u11;
            builder.append(r, r, val);
          }
        } else {
          // General 2x2 single-qubit gate (Hadamard, Pauli-X, Pauli-Y, RX, RY, etc.)
          final u00 = gate.get(0, 0), u01 = gate.get(0, 1);
          final u10 = gate.get(1, 0), u11 = gate.get(1, 1);
          for (var r = 0; r < dim; r++) {
            if ((r & targetBit) == 0) {
              builder.append(r, r, u00);
              builder.append(r, r | targetBit, u01);
            } else {
              builder.append(r, r & ~targetBit, u10);
              builder.append(r, r, u11);
            }
          }
        }

        return builder.build();
      }

      var fullGate = qbits.contains(0) ? gate : _Operators.I;
      for (var i = 1; i < size; i++) {
        fullGate = qbits.contains(i)
            ? ComplexSparseMatrix.tensor(fullGate, gate)
            : ComplexSparseMatrix.tensorIdentity2(fullGate);
      }
      return fullGate;
    } else {
      final fullSize = 1 << size;
      if (gate.rows != fullSize || gate.columns != fullSize) {
        throw InvalidOperationException(
          'The gate\'s matrix must be 2x2 or ${fullSize}x$fullSize',
        );
      }
      return gate;
    }
  }

  /// Builds a Hadamard matrix operating on supplied [qbits].
  ComplexMatrix hadamard(Set<QbitAddress> qbits) =>
      _cache.putIfAbsent('H->${_key(qbits)}', () => build(qbits, _Operators.H));

  /// Builds a Pauli X (NOT) matrix operating on supplied [qbits].
  ComplexMatrix pauliX(Set<QbitAddress> qbits) =>
      _cache.putIfAbsent('X->${_key(qbits)}', () => build(qbits, _Operators.X));

  /// Builds a Pauli X (NOT) matrix operating on supplied [qbits].
  ComplexMatrix not(Set<QbitAddress> qbits) => pauliX(qbits);

  /// Builds a Pauli Y matrix operating on supplied [qbits].
  ComplexMatrix pauliY(Set<QbitAddress> qbits) =>
      _cache.putIfAbsent('Y->${_key(qbits)}', () => build(qbits, _Operators.Y));

  /// Builds a Pauli Z matrix operating on supplied [qbits].
  ComplexMatrix pauliZ(Set<QbitAddress> qbits) =>
      _cache.putIfAbsent('Z->${_key(qbits)}', () => build(qbits, _Operators.Z));

  /// Builds a 'square root of NOT' matrix operating on supplied [qbits].
  ComplexMatrix squareRootOfX(Set<QbitAddress> qbits) => _cache.putIfAbsent(
    'SQRTX->${_key(qbits)}',
    () => build(qbits, _Operators.SqrtX),
  );

  /// Builds a phase matrix operating on supplied [qbits] with angle [radians].
  ComplexMatrix phase(double radians, Set<QbitAddress> qbits) =>
      _cache.putIfAbsent(
        'P-$radians->${_key(qbits)}',
        () => build(qbits, _Operators.phase(radians)),
      );

  /// Builds a phase S matrix operating on supplied [qbits].
  ComplexMatrix phaseS(Set<QbitAddress> qbits) =>
      _cache.putIfAbsent('S->${_key(qbits)}', () => build(qbits, _Operators.S));

  /// Builds a phase T matrix operating on supplied [qbits].
  ComplexMatrix phaseT(Set<QbitAddress> qbits) =>
      _cache.putIfAbsent('T->${_key(qbits)}', () => build(qbits, _Operators.T));

  /// Builds a X-rotation matrix operating on supplied [qbits] with angle [radians].
  ComplexMatrix rotationX(double radians, Set<QbitAddress> qbits) =>
      _cache.putIfAbsent(
        'ROTx-$radians->${_key(qbits)}',
        () => build(qbits, _Operators.rotationX(radians)),
      );

  /// Builds a Y-rotation matrix operating on supplied [qbits] with angle [radians].
  ComplexMatrix rotationY(double radians, Set<QbitAddress> qbits) =>
      _cache.putIfAbsent(
        'ROTy-$radians->${_key(qbits)}',
        () => build(qbits, _Operators.rotationY(radians)),
      );

  /// Builds a Z-rotation matrix operating on supplied [qbits] with angle [radians].
  ComplexMatrix rotationZ(double radians, Set<QbitAddress> qbits) =>
      _cache.putIfAbsent(
        'ROTz-$radians->${_key(qbits)}',
        () => build(qbits, _Operators.rotationZ(radians)),
      );
}

/// Class used to build controlled [QCircuitGate] matrices for [QCircuit] of size [size]
class ControlledGateBuilder {
  ControlledGateBuilder._(this.size, {bool withCache = false})
    : _cache = DisengageableCache(
        enabled: withCache,
        maxEntries: (size * 3) ~/ 4,
      ),
      _p1cache = DisengageableCache(
        enabled: withCache,
        maxEntries: (size * 3) ~/ 4,
      ),
      _p0cache = DisengageableCache(
        enabled: withCache,
        maxEntries: (size * 3) ~/ 4,
      );

  /// Size of the [QCircuit] for which this builder can build matrices
  final int size;

  final DisengageableCache<ComplexMatrix> _cache;
  final DisengageableCache<ComplexMatrix> _p1cache;
  final DisengageableCache<ComplexMatrix> _p0cache;

  /// Builds a matrix for a [gate] operating on [qbits] and controlled by [controls].
  /// [gate] may be a 2x2 matrix in which case the full uncontrolled transformation matrix will be computed as
  /// the tensor product of [gate] for qubits in [qbits], and the 2x2 identity matrix for other qubits.
  /// Alternatively, [gate] may also be a square matrix of size 2^[size] in which case it is used as is.
  /// [qbits] are not used when [gate] is not a 2x2 matrix.
  /// The resulting matrix is obtained by multiplying the projection matrix corresponding to state |1> for all
  /// [controls] qubits with the uncontrolled transformation matrix, and using the identity matrix for all other
  /// states.
  ComplexMatrix build(
    Set<QbitAddress> qbits,
    ComplexMatrix gate, {
    required Set<QbitAddress> controls,
  }) {
    final invalidControls = controls.where(
      (c) => c.index < 0 || size <= c.index,
    );
    if (invalidControls.isNotEmpty) {
      throw InvalidOperationException(
        'Invalid control qubits: $invalidControls',
      );
    }
    final invalidQbits = qbits.where((q) => q.index < 0 || size <= q.index);
    if (invalidQbits.isNotEmpty) {
      throw InvalidOperationException('Invalid qubits: $invalidQbits');
    }

    // 2. FAST PATH: Diagonal 2x2 Target Gates (Phase, Rz, Z, S, T, etc.)
    if (gate.rows == 2 &&
        gate.columns == 2 &&
        gate.isDiagonal &&
        qbits.length == 1) {
      final targetBit = qbits.single.bigEndianMask(size);

      // Extract target diagonal values U_00 and U_11
      final u0 = gate.get(0, 0), u1 = gate.get(1, 1);

      // Build control bitmask. Qubit 0 is the most-significant bit in this project,
      // so each control/target bit must be aligned to the corresponding position in the
      // state index (e.g. q0 -> bit size-1, q(size-1) -> bit 0).
      final mask = controls.bigEndianMask(size);

      // Direct O(2^N) diagonal construction: replaces QGateBuilder expansion + p1.mul(m1).add(p0)
      return ComplexSparseMatrix.diagonal(
        1 << size,
        (i) => ((i & mask) != mask)
            // P0 subspace (at least one control qubit is not 1): Unchanged state
            ? Complex.one
            // otherwise ALL control qubits are 1: Apply target gate U to target qubit bit
            : (((i & targetBit) != 0) ? u1 : u0),
      );
    }

    // 3. FAST PATH for large circuits: build a local controlled matrix
    if (size > 20 && gate.rows == 2 && gate.columns == 2 && qbits.length == 1) {
      final k = controls.length + 1;
      final dim = 1 << k;
      final mask = (1 << k) - 1; // all controls + target

      final u0 = gate.get(0, 0), u1 = gate.get(1, 1);
      final u01 = gate.get(0, 1), u10 = gate.get(1, 0);

      return ComplexSparseMatrix.generate(dim, dim, (r, c) {
        // If not in the "all controls = 1" subspace, it's identity
        if ((r >> 1) != (mask >> 1)) {
          return (r == c) ? Complex.one : Complex.zero;
        }
        if ((c >> 1) != (mask >> 1)) {
          return Complex.zero;
        }

        // In the subspace, apply the target gate
        final rBit = r & 1, cBit = c & 1;
        if (rBit == 0) {
          return (cBit == 0) ? u0 : u01;
        }
        return (cBit == 0) ? u10 : u1;
      });
    }

    // compute projector when all control qubits are set
    // For large circuits, we skip global projectors to avoid OOM
    if (size > 20) {
      final k = controls.length + qbits.length;
      final dim = 1 << k;
      final controlMask = ((1 << controls.length) - 1) << qbits.length;

      // Ensure 'gate' is local to targets
      final targetGate = (gate.rows == 2 && qbits.length == 1)
          ? gate
          : (gate.rows == (1 << qbits.length)
                ? gate
                : throw InvalidOperationException(
                    'Gate matrix size ${gate.rows} does not match targets ${qbits.length}',
                  ));

      final targetDim = 1 << qbits.length;

      return ComplexSparseMatrix.generate(dim, dim, (r, c) {
        final rCtrl = (r & controlMask) >> qbits.length;
        final cCtrl = (c & controlMask) >> qbits.length;
        final allCtrlSet = (controlMask >> qbits.length);

        if (rCtrl != allCtrlSet || cCtrl != allCtrlSet) {
          return (r == c) ? Complex.one : Complex.zero;
        }

        return targetGate.get(r & (targetDim - 1), c & (targetDim - 1));
      });
    }

    var p1 = _p1cache.putIfAbsent('P1:${_key(controls)}', () {
      // bitmask for active control bits. Qubit 0 is the MSB in the state index, so each
      // control bit must be positioned accordingly when we test the index bits.
      final mask = controls.bigEndianMask(size);

      return ComplexSparseMatrix.diagonal(
        1 << size,
        (i) => ((i & mask) == mask) ? Complex.one : Complex.zero,
      );
    });

    // projector for other cases
    final p0 = _p0cache.putIfAbsent(
      'P0:${_key(controls)}',
      () => _Operators.identity(p1.rows).sub(p1),
    );

    // compute transformation
    ComplexMatrix m1;
    if (gate.rows == 2 && gate.columns == 2) {
      if (qbits.length != 1) {
        throw InvalidOperationException(
          'A unitary gate can only be applied on a single qubit',
        );
      }
      m1 = QGateBuilder.get(
        size,
        withCache: _cache.enabled,
      ).parallel.build(qbits, gate);
    } else {
      if (gate.rows != p1.rows || gate.columns != p1.columns) {
        throw InvalidOperationException(
          'The gate\'s matrix must be 2x2 or ${p1.rows}x${p1.columns}',
        );
      }
      m1 = gate;
    }

    // compose transformation with projectors
    return p1.clone().mul(m1).add(p0);
  }

  /// Builds a Hadamard matrix operating on supplied [qbits] and controlled by [controls].
  ComplexMatrix hadamard(
    Set<QbitAddress> qbits, {
    required Set<QbitAddress> controls,
  }) => _cache.putIfAbsent(
    'H-${_key(controls)}->${_key(qbits)}',
    () => build(qbits, _Operators.H, controls: controls),
  );

  /// Builds a Pauli X matrix operating on supplied [qbits] and controlled by [controls].
  ComplexMatrix pauliX(
    Set<QbitAddress> qbits, {
    required Set<QbitAddress> controls,
  }) => _cache.putIfAbsent(
    'X-${_key(controls)}->${_key(qbits)}',
    () => build(qbits, _Operators.X, controls: controls),
  );

  /// Builds a Pauli X (NOT) matrix operating on supplied [qbits] and controlled by [controls].
  ComplexMatrix not(
    Set<QbitAddress> qbits, {
    required Set<QbitAddress> controls,
  }) => pauliX(qbits, controls: controls);

  /// Builds a Pauli Y matrix operating on supplied [qbits] and controlled by [controls].
  ComplexMatrix pauliY(
    Set<QbitAddress> qbits, {
    required Set<QbitAddress> controls,
  }) => _cache.putIfAbsent(
    'Y-${_key(controls)}->${_key(qbits)}',
    () => build(qbits, _Operators.Y, controls: controls),
  );

  /// Builds a Pauli Z matrix operating on supplied [qbits] and controlled by [controls].
  ComplexMatrix pauliZ(
    Set<QbitAddress> qbits, {
    required Set<QbitAddress> controls,
  }) => _cache.putIfAbsent(
    'Z-${_key(controls)}->${_key(qbits)}',
    () => build(qbits, _Operators.Z, controls: controls),
  );

  /// Builds a 'square root of NOT' matrix operating on supplied [qbits] and controlled by [controls].
  ComplexMatrix squareRootOfX(
    Set<QbitAddress> qbits, {
    required Set<QbitAddress> controls,
  }) => _cache.putIfAbsent(
    'SQRTX-${_key(controls)}->${_key(qbits)}',
    () => build(qbits, _Operators.SqrtX, controls: controls),
  );

  /// Builds a phase matrix operating on supplied [qbits] with angle [radians] and controlled by [controls].
  ComplexMatrix phase(
    double radians,
    Set<QbitAddress> qbits, {
    required Set<QbitAddress> controls,
  }) => _cache.putIfAbsent(
    'P($radians)-${_key(controls)}->${_key(qbits)}',
    () => build(qbits, _Operators.phase(radians), controls: controls),
  );

  /// Builds a phase S matrix operating on supplied [qbits] and controlled by [controls].
  ComplexMatrix phaseS(
    Set<QbitAddress> qbits, {
    required Set<QbitAddress> controls,
  }) => _cache.putIfAbsent(
    'S-${_key(controls)}->${_key(qbits)}',
    () => build(qbits, _Operators.S, controls: controls),
  );

  /// Builds a phase T matrix operating on supplied [qbits] and controlled by [controls].
  ComplexMatrix phaseT(
    Set<QbitAddress> qbits, {
    required Set<QbitAddress> controls,
  }) => _cache.putIfAbsent(
    'T-${_key(controls)}->${_key(qbits)}',
    () => build(qbits, _Operators.T, controls: controls),
  );

  /// Builds a X-rotation matrix operating on supplied [qbits] with angle [radians] and controlled by [controls].
  ComplexMatrix rotationX(
    double radians,
    Set<QbitAddress> qbits, {
    required Set<QbitAddress> controls,
  }) => _cache.putIfAbsent(
    'Rx($radians)-${_key(controls)}->${_key(qbits)}',
    () => build(qbits, _Operators.rotationX(radians), controls: controls),
  );

  /// Builds a Y-rotation matrix operating on supplied [qbits] with angle [radians] and controlled by [controls].
  ComplexMatrix rotationY(
    double radians,
    Set<QbitAddress> qbits, {
    required Set<QbitAddress> controls,
  }) => _cache.putIfAbsent(
    'Ry($radians)-${_key(controls)}->${_key(qbits)}',
    () => build(qbits, _Operators.rotationY(radians), controls: controls),
  );

  /// Builds a Z-rotation matrix operating on supplied [qbits] with angle [radians] and controlled by [controls].
  ComplexMatrix rotationZ(
    double radians,
    Set<QbitAddress> qbits, {
    required Set<QbitAddress> controls,
  }) => _cache.putIfAbsent(
    'Rz($radians)-${_key(controls)}->${_key(qbits)}',
    () => build(qbits, _Operators.rotationZ(radians), controls: controls),
  );
}

/// Class used to build high-level gate matrices for [QCircuit] of size [size]
class HighLevelGateBuilder {
  HighLevelGateBuilder._(this.size, {bool withCache = false})
    : _cache = DisengageableCache(
        enabled: withCache,
        maxEntries: (size * 3) ~/ 4,
      );

  /// Size of the [QCircuit] for which this builder can build matrices
  final int size;

  final DisengageableCache<ComplexMatrix> _cache;

  /// Builds a Toffoli (CC-NOT) matrix operating on supplied [qbit] and controlled by [controls].
  /// [controls] must be a set of 2 qubits.
  ComplexMatrix toffoli(
    QbitAddress qbit, {
    required Set<QbitAddress> controls,
  }) => _cache.putIfAbsent('TOFFOLI-${_key(controls)}->$qbit', () {
    if (controls.length != 2) {
      throw InvalidOperationException('Toffoli gate requires 2 control qubits');
    }
    final builder = QGateBuilder.get(size, withCache: _cache.enabled);
    return builder.controlled.build(
      {qbit},
      builder.parallel.not({qbit}),
      controls: controls,
    );
  });

  /// Builds a SWAP matrix operating on supplied [qbits].
  /// [qbits] must be a set of 2 qubits.
  ComplexMatrix swap(Set<QbitAddress> qbits) =>
      _cache.putIfAbsent('SWAP-${_key(qbits)}', () {
        if (qbits.length != 2) {
          throw InvalidOperationException(
            'Swap gates operate on 2 qubits, got $qbits',
          );
        }

        if (size > 20) {
          return ComplexSparseMatrix([
            [_1, _0, _0, _0],
            [_0, _0, _1, _0],
            [_0, _1, _0, _0],
            [_0, _0, _0, _1],
          ]);
        }

        final qb1 = {qbits.first};
        final qb2 = {qbits.last};
        final builder = QGateBuilder.get(size, withCache: _cache.enabled);
        final not12 = builder.controlled.pauliX(qb2, controls: qb1);
        final not21 = builder.controlled.pauliX(qb1, controls: qb2);
        return not12.clone().mul(not21).mul(not12);
      });

  /// Builds a Fredkin (C-SWAP) matrix operating on supplied [qbits] and controlled by [control].
  /// [qbits] must be a set of 2 qubits.
  ComplexMatrix fredkin(
    Set<QbitAddress> qbits, {
    required QbitAddress control,
  }) => _cache.putIfAbsent('C-SWAP-$control->${_key(qbits)}', () {
    if (qbits.length != 2) {
      throw InvalidOperationException('Fredkin gates operate on 2 qubits');
    }
    final builder = QGateBuilder.get(size, withCache: _cache.enabled);
    return builder.controlled.build(qbits, swap(qbits), controls: {control});
  });

  /// Builds a Fredkin (C-SWAP) matrix operating on supplied [qbits] and controlled by [control].
  /// [qbits] must be a set of 2 qubits.
  ComplexMatrix cswap(Set<QbitAddress> qbits, {required QbitAddress control}) =>
      fredkin(qbits, control: control);

  /// Builds a Quantum Fourrier Transform (QFT) matrix operating on supplied [qbits].
  /// [qbits] is a list as the order of qubits is important.
  /// If [reverse] is `true`, the order of the qubits after QFT will be reversed.
  ComplexMatrix qft(List<QbitAddress> qbits, {bool reverse = false}) =>
      _cache.putIfAbsent('QFT-$reverse-${qbits.join('-')}', () {
        final n = qbits.length;
        final phaseShifts = List.generate(
          n + 1,
          (i) => _Operators.phase(2 * math.pi / (1 << i)),
        );

        if (size > 20) {
          // Build local QFT matrix of size 2^n
          var res = ComplexSparseMatrix.identity(1 << n);
          for (var i = n; i >= 1; i--) {
            // Apply Hadamard to qubit i-1 (local index)
            final h = _Operators.H;
            final k = n;
            final targetBit = 1 << (k - i);
            final hFull = ComplexSparseMatrix.generate(1 << k, 1 << k, (r, c) {
              if ((r & ~targetBit) != (c & ~targetBit)) return Complex.zero;
              final rBit = (r & targetBit) == 0 ? 0 : 1;
              final cBit = (c & targetBit) == 0 ? 0 : 1;
              return h.get(rBit, cBit);
            });
            res = hFull.mul(res);

            // Apply controlled phase rotations
            for (var j = i - 1; j >= 1; j--) {
              final cp = phaseShifts[i - j + 1];
              final ctrlBit = 1 << (k - j);
              final cpFull = ComplexSparseMatrix.diagonal(
                1 << k,
                (idx) => ((idx & ctrlBit) == 0 || (idx & targetBit) == 0)
                    ? Complex.one
                    : cp.get(1, 1),
              );
              res = cpFull.mul(res);
            }
          }
          if (reverse) {
            // Add local swaps
            for (var i = 1; i <= n / 2; i++) {
              final q1 = i - 1, q2 = n - i;
              final b1 = 1 << (n - 1 - q1), b2 = 1 << (n - 1 - q2);
              final sFull = ComplexSparseMatrix.generate(1 << n, 1 << n, (
                r,
                c,
              ) {
                var tr = r;
                if (((r & b1) != 0) != ((r & b2) != 0)) {
                  tr ^= (b1 | b2);
                }
                return (tr == c) ? Complex.one : Complex.zero;
              });
              res = sFull.mul(res);
            }
          }
          return res;
        }

        final builder = QGateBuilder.get(size, withCache: _cache.enabled);
        final res = _Operators.identity(1 << size);
        for (var i = n; i >= 1; i--) {
          final qb = {qbits[i - 1]};
          final m = builder.parallel.hadamard(qb);
          var r = 2;
          for (var j = i - 1; j >= 1; j--) {
            m.mul(
              builder.controlled.build(
                qb,
                phaseShifts[r],
                controls: {qbits[j - 1]},
              ),
            );
            r++;
          }
          res.mul(m);
        }
        if (reverse) {
          final m = n / 2;
          for (var i = 1; i <= m; i++) {
            res.mul(swap({qbits[i - 1], qbits[n - i]}));
          }
        }
        return res;
      });

  /// Builds an inverse Quantum Fourrier Transform (QFT) matrix operating on supplied [qbits].
  /// [qbits] is a list as the order of qubits is important.
  /// The matrix is built by calling [qft] and taking the conjugate transpose of the resulting matrix.
  /// If [reverse] is `true`, the order of the qubits after QFT will be reversed.
  ComplexMatrix invqft(List<QbitAddress> qbits, {bool reverse = false}) =>
      _cache.putIfAbsent(
        'INVQFT-$reverse-${qbits.join('-')}',
        () => qft(qbits, reverse: reverse).dagger(),
      );
}

/// Builder class used to compute [QCircuitGate] matrices
class QGateBuilder {
  QGateBuilder._(this.size, this.withCache);

  final int size;
  final bool withCache;

  static final List<QGateBuilder> _builders = <QGateBuilder>[];

  static QGateBuilder get(int size, {required bool withCache}) {
    var instance = _builders.cast<QGateBuilder?>().firstWhere(
      (b) => b != null && b.withCache == withCache && b.size == size,
      orElse: () => null,
    );
    if (instance == null) {
      instance = QGateBuilder._(size, withCache);
      _builders.add(instance);
    }
    return instance;
  }

  late final parallel = ParallelGateBuilder._(size, withCache: withCache);

  late final controlled = ControlledGateBuilder._(size, withCache: withCache);

  late final highLevel = HighLevelGateBuilder._(size, withCache: withCache);

  Iterable<CacheEntryStat> get cacheStats => parallel._cache.stats
      .followedBy(controlled._cache.stats)
      .followedBy(controlled._p1cache.stats)
      .followedBy(controlled._p0cache.stats)
      .followedBy(highLevel._cache.stats);
}
