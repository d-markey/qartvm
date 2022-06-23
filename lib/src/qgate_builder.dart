import 'dart:math' as math;

import 'exceptions.dart';
import 'math/complex.dart';
import 'math/complex_matrix.dart';

// ignore: non_constant_identifier_names
Complex get _0 => Complex.zero;
// ignore: non_constant_identifier_names
Complex get _1 => Complex.one;
// ignore: non_constant_identifier_names
Complex get _i => Complex.i;

String _key(Iterable<int> qubits) => (qubits.toList()..sort()).join('-');

class _Operators {
  static final I = ComplexMatrix([
    [_1, _0],
    [_0, _1]
  ]);

  // PROJECTORS

  static final p1 = ComplexMatrix([
        [_0],
        [_1]
      ]) *
      ComplexMatrix([
        [_0, _1]
      ]);

  // HADAMARD

  static final H = ComplexMatrix([
    [_1, _1],
    [_1, -_1]
  ]).mul(math.sqrt1_2);

  // PAULI

  static final X = ComplexMatrix([
    [_0, _1],
    [_1, _0]
  ]);

  static final Y = ComplexMatrix([
    [_0, -_i],
    [_i, _0]
  ]);

  static final Z = ComplexMatrix([
    [_1, _0],
    [_0, -_1]
  ]);

  // ignore: non_constant_identifier_names
  static final SqrtX = ComplexMatrix([
    [_1 + _i, _1 - _i],
    [_1 - _i, _1 + _i]
  ]).div(2);

  // PHASE

  static ComplexMatrix phase(double radians) => ComplexMatrix([
        [_1, _0],
        [_0, Complex(re: math.cos(radians), im: math.sin(radians))]
      ]);

  static final S = ComplexMatrix([
    [_1, _0],
    [_0, _i]
  ]);

  static final T = ComplexMatrix([
    [_1, _0],
    [_0, (_1 + _i) * math.sqrt1_2]
  ]);

  // ROTATION

  static ComplexMatrix rotationX(double radians) => ComplexMatrix([
        [_1 * math.cos(radians / 2), -_i * math.sin(radians / 2)],
        [-_i * math.sin(radians / 2), _1 * math.cos(radians / 2)]
      ]);

  static ComplexMatrix rotationY(double radians) => ComplexMatrix([
        [_1 * math.cos(radians / 2), -_1 * math.sin(radians / 2)],
        [_1 * math.sin(radians / 2), _1 * math.cos(radians / 2)]
      ]);

  static ComplexMatrix rotationZ(double radians) => ComplexMatrix([
        [Complex.polar(radius: 1, angle: -radians / 2), _0],
        [_0, Complex.polar(radius: 1, angle: radians / 2)]
      ]);
}

class _DisengageableCache {
  _DisengageableCache({bool enabled = true})
      : _cache = enabled ? <String, ComplexMatrix>{} : null;

  final Map<String, ComplexMatrix>? _cache;

  bool get enabled => _cache != null;

  ComplexMatrix? operator [](String key) => _cache?[key];

  ComplexMatrix putIfAbsent(String key, ComplexMatrix Function() builder) =>
      _cache?.putIfAbsent(key, builder) ?? builder();
}

/// Class used to build [QCircuitGate] matrices for [QCircuit] of size [size]
class ParallelGateBuilder {
  ParallelGateBuilder._(this.size, {bool withCache = false})
      : _cache = _DisengageableCache(enabled: withCache);

  /// Size of the [QCircuit] for which this builder can build matrices
  final int size;

  final _DisengageableCache _cache;

  /// Builds a matrix for a [gate] operating on [qubits].
  /// [gate] may be a 2x2 matrix in which case the full transformation matrix will be computed as the tensor
  /// product of [gate] for qubits in [qubits], and the 2x2 identity matrix for other qubits.
  /// Alternatively, [gate] may also be a square matrix of size 2^[size] in which case it is returned as is.
  /// [qubits] are not used when [gate] is not a 2x2 matrix.
  ComplexMatrix build(Set<int> qubits, ComplexMatrix gate) {
    if (gate.rows == 2 && gate.columns == 2) {
      var fullGate = qubits.contains(0) ? gate : _Operators.I;
      for (var i = 1; i < size; i++) {
        fullGate = ComplexMatrix.tensor(
            fullGate, qubits.contains(i) ? gate : _Operators.I);
      }
      return fullGate;
    } else {
      final fullSize = 1 << size;
      if (gate.rows != fullSize || gate.columns != fullSize) {
        throw InvalidOperationException(
            'The gate\'s matrix must be 2x2 or ${fullSize}x$fullSize');
      }
      return gate;
    }
  }

  /// Builds a Hadamard matrix operating on supplied [qubits].
  ComplexMatrix hadamard(Set<int> qubits) => _cache.putIfAbsent(
      'H-${_key(qubits)}', () => build(qubits, _Operators.H));

  /// Builds a Pauli X (NOT) matrix operating on supplied [qubits].
  ComplexMatrix pauliX(Set<int> qubits) => _cache.putIfAbsent(
      'X-${_key(qubits)}', () => build(qubits, _Operators.X));

  /// Builds a Pauli X (NOT) matrix operating on supplied [qubits].
  ComplexMatrix not(Set<int> qubits) => pauliX(qubits);

  /// Builds a Pauli Y matrix operating on supplied [qubits].
  ComplexMatrix pauliY(Set<int> qubits) => _cache.putIfAbsent(
      'Y-${_key(qubits)}', () => build(qubits, _Operators.Y));

  /// Builds a Pauli Z matrix operating on supplied [qubits].
  ComplexMatrix pauliZ(Set<int> qubits) => _cache.putIfAbsent(
      'Z-${_key(qubits)}', () => build(qubits, _Operators.Z));

  /// Builds a 'square root of NOT' matrix operating on supplied [qubits].
  ComplexMatrix squareRootOfX(Set<int> qubits) => _cache.putIfAbsent(
      'SQRTX-${_key(qubits)}', () => build(qubits, _Operators.SqrtX));

  /// Builds a phase matrix operating on supplied [qubits] with angle [radians].
  ComplexMatrix phase(double radians, Set<int> qubits) => _cache.putIfAbsent(
      'PHASE-$radians-${_key(qubits)}',
      () => build(qubits, _Operators.phase(radians)));

  /// Builds a phase S matrix operating on supplied [qubits].
  ComplexMatrix phaseS(Set<int> qubits) => _cache.putIfAbsent(
      'S-${_key(qubits)}', () => build(qubits, _Operators.S));

  /// Builds a phase T matrix operating on supplied [qubits].
  ComplexMatrix phaseT(Set<int> qubits) => _cache.putIfAbsent(
      'T-${_key(qubits)}', () => build(qubits, _Operators.T));

  /// Builds a X-rotation matrix operating on supplied [qubits] with angle [radians].
  ComplexMatrix rotationX(double radians, Set<int> qubits) =>
      _cache.putIfAbsent('ROTx-$radians-${_key(qubits)}',
          () => build(qubits, _Operators.rotationX(radians)));

  /// Builds a Y-rotation matrix operating on supplied [qubits] with angle [radians].
  ComplexMatrix rotationY(double radians, Set<int> qubits) =>
      _cache.putIfAbsent('ROTy-$radians-${_key(qubits)}',
          () => build(qubits, _Operators.rotationY(radians)));

  /// Builds a Z-rotation matrix operating on supplied [qubits] with angle [radians].
  ComplexMatrix rotationZ(double radians, Set<int> qubits) =>
      _cache.putIfAbsent('ROTz-$radians-${_key(qubits)}',
          () => build(qubits, _Operators.rotationZ(radians)));
}

/// Class used to build controlled [QCircuitGate] matrices for [QCircuit] of size [size]
class ControlledGateBuilder {
  ControlledGateBuilder._(this.size, {bool withCache = false})
      : _cache = _DisengageableCache(enabled: withCache),
        _p1cache = _DisengageableCache(enabled: withCache);

  /// Size of the [QCircuit] for which this builder can build matrices
  final int size;

  final _DisengageableCache _cache;
  final _DisengageableCache _p1cache;

  /// Builds a matrix for a [gate] operating on [qubits] and controlled by [controls].
  /// [gate] may be a 2x2 matrix in which case the full uncontrolled transformation matrix will be computed as
  /// the tensor product of [gate] for qubits in [qubits], and the 2x2 identity matrix for other qubits.
  /// Alternatively, [gate] may also be a square matrix of size 2^[size] in which case it is used as is.
  /// [qubits] are not used when [gate] is not a 2x2 matrix.
  /// The resulting matrix is obtained by multiplying the projection matrix corresponding to state |1> for all
  /// [controls] qubits with the uncontrolled transformation matrix, and using the identity matrix for all other
  /// states.
  ComplexMatrix build(Set<int> qubits, ComplexMatrix gate,
      {required Set<int> controls}) {
    if (controls.any((c) => c < 0 || size <= c)) {
      throw InvalidOperationException(
          'Invalid control qubits: ${controls.where((c) => c < 0 || size <= c)}');
    }
    if (qubits.any((q) => q < 0 || size <= q)) {
      throw InvalidOperationException(
          'Invalid qubits: ${qubits.where((c) => c < 0 || size <= c)}');
    }

    // compute projector when all control qubits are set
    var p1 = _p1cache.putIfAbsent(_key(controls), () {
      var p = controls.contains(0) ? _Operators.p1 : _Operators.I;
      for (var i = 1; i < size; i++) {
        p = ComplexMatrix.tensor(
            p, controls.contains(i) ? _Operators.p1 : _Operators.I);
      }
      return p;
    });
    // projector for other cases
    final p0 = ComplexMatrix.identity(p1.rows).sub(p1);

    // compute transformation
    ComplexMatrix m1;
    if (gate.rows == 2 && gate.columns == 2) {
      if (qubits.length != 1) {
        throw InvalidOperationException(
            'A unitary gate can only be applied on a single qubit');
      }
      m1 = QGateBuilder.get(size, withCache: _cache.enabled)
          .parallel
          .build(qubits, gate);
    } else {
      if (gate.rows != p1.rows || gate.columns != p1.columns) {
        throw InvalidOperationException(
            'The gate\'s matrix must be 2x2 or ${p1.rows}x${p1.columns}');
      }
      m1 = gate;
    }

    // compose transformation with projectors
    return p1.clone().mul(m1).add(p0);
  }

  /// Builds a Hadamard matrix operating on supplied [qubits] and controlled by [controls].
  ComplexMatrix hadamard(Set<int> qubits, {required Set<int> controls}) =>
      _cache.putIfAbsent('H-${_key(controls)}->${_key(qubits)}',
          () => build(qubits, _Operators.H, controls: controls));

  /// Builds a Pauli X matrix operating on supplied [qubits] and controlled by [controls].
  ComplexMatrix pauliX(Set<int> qubits, {required Set<int> controls}) =>
      _cache.putIfAbsent('X-${_key(controls)}->${_key(qubits)}',
          () => build(qubits, _Operators.X, controls: controls));

  /// Builds a Pauli X (NOT) matrix operating on supplied [qubits] and controlled by [controls].
  ComplexMatrix not(Set<int> qubits, {required Set<int> controls}) =>
      pauliX(qubits, controls: controls);

  /// Builds a Pauli Y matrix operating on supplied [qubits] and controlled by [controls].
  ComplexMatrix pauliY(Set<int> qubits, {required Set<int> controls}) =>
      _cache.putIfAbsent('Y-${_key(controls)}->${_key(qubits)}',
          () => build(qubits, _Operators.Y, controls: controls));

  /// Builds a Pauli Z matrix operating on supplied [qubits] and controlled by [controls].
  ComplexMatrix pauliZ(Set<int> qubits, {required Set<int> controls}) =>
      _cache.putIfAbsent('Z-${_key(controls)}->${_key(qubits)}',
          () => build(qubits, _Operators.Z, controls: controls));

  /// Builds a 'square root of NOT' matrix operating on supplied [qubits] and controlled by [controls].
  ComplexMatrix squareRootOfX(Set<int> qubits, {required Set<int> controls}) =>
      _cache.putIfAbsent('SQRTX-${_key(controls)}->${_key(qubits)}',
          () => build(qubits, _Operators.SqrtX, controls: controls));

  /// Builds a phase matrix operating on supplied [qubits] with angle [radians] and controlled by [controls].
  ComplexMatrix phase(double radians, Set<int> qubits,
          {required Set<int> controls}) =>
      _cache.putIfAbsent('PHASE-$radians-${_key(controls)}->${_key(qubits)}',
          () => build(qubits, _Operators.phase(radians), controls: controls));

  /// Builds a phase S matrix operating on supplied [qubits] and controlled by [controls].
  ComplexMatrix phaseS(Set<int> qubits, {required Set<int> controls}) =>
      _cache.putIfAbsent('S-${_key(controls)}->${_key(qubits)}',
          () => build(qubits, _Operators.S, controls: controls));

  /// Builds a phase T matrix operating on supplied [qubits] and controlled by [controls].
  ComplexMatrix phaseT(Set<int> qubits, {required Set<int> controls}) =>
      _cache.putIfAbsent('T-${_key(controls)}->${_key(qubits)}',
          () => build(qubits, _Operators.T, controls: controls));

  /// Builds a X-rotation matrix operating on supplied [qubits] with angle [radians] and controlled by [controls].
  ComplexMatrix rotationX(double radians, Set<int> qubits,
          {required Set<int> controls}) =>
      _cache.putIfAbsent(
          'Rx-$radians-${_key(controls)}->${_key(qubits)}',
          () =>
              build(qubits, _Operators.rotationX(radians), controls: controls));

  /// Builds a Y-rotation matrix operating on supplied [qubits] with angle [radians] and controlled by [controls].
  ComplexMatrix rotationY(double radians, Set<int> qubits,
          {required Set<int> controls}) =>
      _cache.putIfAbsent(
          'Ry-$radians-${_key(controls)}->${_key(qubits)}',
          () =>
              build(qubits, _Operators.rotationY(radians), controls: controls));

  /// Builds a Z-rotation matrix operating on supplied [qubits] with angle [radians] and controlled by [controls].
  ComplexMatrix rotationZ(double radians, Set<int> qubits,
          {required Set<int> controls}) =>
      _cache.putIfAbsent(
          'Rz-$radians-${_key(controls)}->${_key(qubits)}',
          () =>
              build(qubits, _Operators.rotationZ(radians), controls: controls));
}

/// Class used to build high-level gate matrices for [QCircuit] of size [size]
class HighLevelGateBuilder {
  HighLevelGateBuilder._(this.size, {bool withCache = false})
      : _cache = _DisengageableCache(enabled: withCache);

  /// Size of the [QCircuit] for which this builder can build matrices
  final int size;

  final _DisengageableCache _cache;

  /// Builds a Toffoli (CC-NOT) matrix operating on supplied [qubit] and controlled by [controls].
  /// [controls] must be a set of 2 qubits.
  ComplexMatrix toffoli(int qubit, {required Set<int> controls}) =>
      _cache.putIfAbsent('TOFFOLI-${_key(controls)}->$qubit', () {
        if (controls.length != 2) {
          throw InvalidOperationException(
              'Toffoli gate requires 2 control qubits');
        }
        final builder = QGateBuilder.get(size, withCache: _cache.enabled);
        return builder.controlled
            .build({qubit}, builder.parallel.not({qubit}), controls: controls);
      });

  /// Builds a SWAP matrix operating on supplied [qubits].
  /// [qubits] must be a set of 2 qubits.
  ComplexMatrix swap(Set<int> qubits) =>
      _cache.putIfAbsent('SWAP-${_key(qubits)}', () {
        //
        // triple CNOT
        //
        // 0 ---*---NOT---*---
        //      |    |    |
        // 1 --NOT---*---NOT--
        //
        if (qubits.length != 2) {
          throw InvalidOperationException('Swap gates operate on 2 qubits, got $qubits');
        }
        final qb1 = {qubits.first};
        final qb2 = {qubits.last};
        final builder = QGateBuilder.get(size, withCache: _cache.enabled);
        final not12 = builder.controlled.pauliX(qb2, controls: qb1);
        final not21 = builder.controlled.pauliX(qb1, controls: qb2);
        return not12.clone().mul(not21).mul(not12);
      });

  /// Builds a Fredkin (C-SWAP) matrix operating on supplied [qubits] and controlled by [control].
  /// [qubits] must be a set of 2 qubits.
  ComplexMatrix fredkin(Set<int> qubits, {required int control}) =>
      _cache.putIfAbsent('C-SWAP-$control->${_key(qubits)}', () {
        if (qubits.length != 2) {
          throw InvalidOperationException('Fredkin gates operate on 2 qubits');
        }
        final builder = QGateBuilder.get(size, withCache: _cache.enabled);
        return builder.controlled
            .build(qubits, swap(qubits), controls: {control});
      });

  /// Builds a Fredkin (C-SWAP) matrix operating on supplied [qubits] and controlled by [control].
  /// [qubits] must be a set of 2 qubits.
  ComplexMatrix cswap(Set<int> qubits, {required int control}) =>
      fredkin(qubits, control: control);

  /// Builds a Quantum Fourrier Transform (QFT) matrix operating on supplied [qubits].
  /// [qubits] is a list as the order of qubits is important.
  /// If [reverse] is `true`, the order of the qubits after QFT will be reversed.
  ComplexMatrix qft(List<int> qubits, {bool reverse = false}) =>
      _cache.putIfAbsent('QFT-$reverse-${qubits.join('-')}', () {
        final n = qubits.length;
        final phaseShifts = List.generate(
            n + 1, (i) => _Operators.phase(2 * math.pi / (1 << i)));
        final builder = QGateBuilder.get(size, withCache: _cache.enabled);
        final res = ComplexMatrix.identity(1 << size);
        for (var i = n; i >= 1; i--) {
          final qb = {qubits[i - 1]};
          final m = builder.parallel.hadamard(qb);
          var r = 2;
          for (var j = i - 1; j >= 1; j--) {
            m.mul(builder.controlled
                .build(qb, phaseShifts[r], controls: {qubits[j - 1]}));
            r++;
          }
          res.mul(m);
        }
        if (reverse) {
          final m = n / 2;
          for (var i = 1; i <= m; i++) {
            res.mul(swap({qubits[i - 1], qubits[n - i]}));
          }
        }
        return res;
      });

  /// Builds an inverse Quantum Fourrier Transform (QFT) matrix operating on supplied [qubits].
  /// [qubits] is a list as the order of qubits is important.
  /// The matrix is built by calling [qft] and taking the conjugate transpose of the resulting matrix.
  /// If [reverse] is `true`, the order of the qubits after QFT will be reversed.
  ComplexMatrix invqft(List<int> qubits, {bool reverse = false}) =>
      _cache.putIfAbsent('INVQFT-$reverse-${qubits.join('-')}',
          () => qft(qubits, reverse: reverse).dagger());
}

/// Builder class used to compute [QCircuitGate] matrices
class QGateBuilder {
  QGateBuilder._(this.size, this.withCache);

  final int size;
  final bool withCache;

  static final List<QGateBuilder> _builders = <QGateBuilder>[];

  static QGateBuilder get(int size, {bool withCache = false}) {
    var instance = _builders.cast<QGateBuilder?>().firstWhere(
        (b) => b!.withCache == withCache && b.size == size,
        orElse: () => null);
    if (instance == null) {
      instance = QGateBuilder._(size, withCache);
      _builders.add(instance);
    }
    return instance;
  }

  late final parallel = ParallelGateBuilder._(size, withCache: withCache);

  late final controlled = ControlledGateBuilder._(size, withCache: withCache);

  late final highLevel = HighLevelGateBuilder._(size, withCache: withCache);
}
