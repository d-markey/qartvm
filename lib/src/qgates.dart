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

class _Operators {
  static final I = ComplexMatrix([
    [_1, _0],
    [_0, _1]
  ]);

  // PROJECTORS

  static final p0 = ComplexMatrix([
        [_1],
        [_0]
      ]) *
      ComplexMatrix([
        [_1, _0]
      ]);
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
  ]).div(math.sqrt2);

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
    [_0, Complex(re: math.sqrt1_2, im: math.sqrt1_2)]
  ]);
}

class UnitaryGates {
  UnitaryGates(this.size);

  final int size;

  final _cache = <String, ComplexMatrix>{};

  ComplexMatrix unitaryGate(int qubit, ComplexMatrix unitaryGate) =>
      QGates.parallel(size).parallelGate({qubit}, unitaryGate);

  ComplexMatrix hadamard(int qubit) =>
      _cache.putIfAbsent('H-$qubit}', () => unitaryGate(qubit, _Operators.H));

  ComplexMatrix pauliX(int qubit) =>
      _cache.putIfAbsent('X-$qubit', () => unitaryGate(qubit, _Operators.X));

  ComplexMatrix not(int qubit) => pauliX(qubit);

  ComplexMatrix pauliY(int qubit) =>
      _cache.putIfAbsent('Y-$qubit', () => unitaryGate(qubit, _Operators.Y));

  ComplexMatrix pauliZ(int qubit) =>
      _cache.putIfAbsent('Z-$qubit', () => unitaryGate(qubit, _Operators.Z));

  ComplexMatrix squareRootOfX(int qubit) => _cache.putIfAbsent(
      'SQRTX-$qubit', () => unitaryGate(qubit, _Operators.SqrtX));

  ComplexMatrix phase(int qubit, double radians) => _cache.putIfAbsent(
      'PHASE-$qubit-$radians',
      () => unitaryGate(qubit, _Operators.phase(radians)));

  ComplexMatrix phaseS(int qubit) =>
      _cache.putIfAbsent('S-$qubit', () => unitaryGate(qubit, _Operators.S));

  ComplexMatrix phaseT(int qubit) =>
      _cache.putIfAbsent('T-$qubit', () => unitaryGate(qubit, _Operators.T));
}

class ParallelGates {
  ParallelGates(this.size);

  final int size;

  final _cache = <String, ComplexMatrix>{};

  ComplexMatrix parallelGate(Set<int> qubits, ComplexMatrix unitaryGate) {
    var circuit = qubits.contains(0) ? unitaryGate : _Operators.I;
    for (var i = 1; i < size; i++) {
      if (qubits.contains(i)) {
        circuit = ComplexMatrix.tensor(circuit, unitaryGate);
      } else {
        circuit = ComplexMatrix.tensor(circuit, _Operators.I);
      }
    }
    return circuit;
  }

  ComplexMatrix hadamard(Set<int> qubits) => _cache.putIfAbsent(
      'H-${(qubits.toList()..sort()).join('-')}',
      () => parallelGate(qubits, _Operators.H));

  ComplexMatrix pauliX(Set<int> qubits) => _cache.putIfAbsent(
      'X-${(qubits.toList()..sort()).join('-')}',
      () => parallelGate(qubits, _Operators.X));

  ComplexMatrix not(Set<int> qubits) => pauliX(qubits);

  ComplexMatrix pauliY(Set<int> qubits) => _cache.putIfAbsent(
      'Y-${(qubits.toList()..sort()).join('-')}',
      () => parallelGate(qubits, _Operators.Y));

  ComplexMatrix pauliZ(Set<int> qubits) => _cache.putIfAbsent(
      'Z-${(qubits.toList()..sort()).join('-')}',
      () => parallelGate(qubits, _Operators.Z));

  ComplexMatrix squareRootOfX(Set<int> qubits) => _cache.putIfAbsent(
      'SQRTX-${(qubits.toList()..sort()).join('-')}',
      () => parallelGate(qubits, _Operators.SqrtX));

  ComplexMatrix phase(Set<int> qubits, double radians) => _cache.putIfAbsent(
      'PHASE-${(qubits.toList()..sort()).join('-')}',
      () => parallelGate(qubits, _Operators.phase(radians)));

  ComplexMatrix phaseS(Set<int> qubits) => _cache.putIfAbsent(
      'S-${(qubits.toList()..sort()).join('-')}',
      () => parallelGate(qubits, _Operators.S));

  ComplexMatrix phaseT(Set<int> qubits) => _cache.putIfAbsent(
      'T-${(qubits.toList()..sort()).join('-')}',
      () => parallelGate(qubits, _Operators.T));
}

class ControlledGates {
  ControlledGates(this.size);

  final int size;

  final _cache = <String, ComplexMatrix>{};

  ComplexMatrix controlledGate(
      int control, int qubit, ComplexMatrix unitaryGate) {
    if (control < 0 || size <= control) throw InvalidOperationException();
    if (qubit < 0 || size <= qubit) throw InvalidOperationException();
    var m0 = (control == 0) ? _Operators.p0 : _Operators.I;
    var m1 = (control == 0)
        ? _Operators.p1
        : (qubit == 0)
            ? unitaryGate
            : _Operators.I;
    for (var i = 1; i < size; i++) {
      if (control == i) {
        m0 = ComplexMatrix.tensor(m0, _Operators.p0);
        m1 = ComplexMatrix.tensor(m1, _Operators.p1);
      } else if (qubit == i) {
        m0 = ComplexMatrix.tensor(m0, _Operators.I);
        m1 = ComplexMatrix.tensor(m1, unitaryGate);
      } else {
        m0 = ComplexMatrix.tensor(m0, _Operators.I);
        m1 = ComplexMatrix.tensor(m1, _Operators.I);
      }
    }
    return m0 + m1;
  }

  ComplexMatrix hadamard(int control, int qubit) => _cache.putIfAbsent(
      'H-$control-$qubit', () => controlledGate(control, qubit, _Operators.H));

  ComplexMatrix pauliX(int control, int qubit) => _cache.putIfAbsent(
      'X-$control-$qubit', () => controlledGate(control, qubit, _Operators.X));

  ComplexMatrix not(int control, int qubit) => pauliX(control, qubit);

  ComplexMatrix pauliY(int control, int qubit) => _cache.putIfAbsent(
      'Y-$control-$qubit', () => controlledGate(control, qubit, _Operators.Y));

  ComplexMatrix pauliZ(int control, int qubit) => _cache.putIfAbsent(
      'Z-$control-$qubit', () => controlledGate(control, qubit, _Operators.Z));

  ComplexMatrix squareRootOfX(int control, int qubit) => _cache.putIfAbsent(
      'SQRTX-$control-$qubit',
      () => controlledGate(control, qubit, _Operators.SqrtX));

  ComplexMatrix sqrtOfNot(int control, int qubit) =>
      squareRootOfX(control, qubit);

  ComplexMatrix phase(int control, int qubit, double radians) =>
      _cache.putIfAbsent('PHASE-$control-$qubit-$radians',
          () => controlledGate(control, qubit, _Operators.phase(radians)));

  ComplexMatrix phaseS(int control, int qubit) => _cache.putIfAbsent(
      'S-$control-$qubit', () => controlledGate(control, qubit, _Operators.S));

  ComplexMatrix phaseT(int control, int qubit) => _cache.putIfAbsent(
      'T-$control-$qubit', () => controlledGate(control, qubit, _Operators.T));
}

class HighLevelGates {
  HighLevelGates(this.size) : _controlled = QGates.controlled(size);

  final int size;
  final ControlledGates _controlled;

  final _cache = <String, ComplexMatrix>{};

  ComplexMatrix toffoli(int control1, int control2, int qubit) =>
      _cache.putIfAbsent('TOFFOLI-$control1-$control2-$qubit', () {
        //
        // Sleator-Weinfurter construction:
        //
        //  0 ------------*-----------------*------*-----
        //                |                 |      |
        //  1 -----*-----NOT------*--------NOT-----|-----
        //         |              |                |
        //  2 --SqrtNOT------SqrtNOT(inv)-------SqrtNOT--
        //
        final sqnot2 = _controlled.squareRootOfX(control2, qubit);
        final sqnot2_ = _controlled.controlledGate(
            control2, qubit, _Operators.SqrtX.conjugate());
        final sqnot1 = _controlled.squareRootOfX(control1, qubit);
        final not12 = _controlled.pauliX(control1, control2);
        return sqnot2.clone().mul(not12).mul(sqnot2_).mul(not12).mul(sqnot1);
      });

  ComplexMatrix swap(int qubit1, int qubit2) =>
      _cache.putIfAbsent('SWAP-$qubit1-$qubit2', () {
        //
        // triple CNOT
        //
        // 0 ---*---NOT---*---
        //      |    |    |
        // 1 --NOT---*---NOT--
        //
        final not12 = _controlled.pauliX(qubit1, qubit2);
        final not21 = _controlled.pauliX(qubit2, qubit1);
        return not12.clone().mul(not21).mul(not12);
      });

  ComplexMatrix fredkin(int control, int qubit1, int qubit2) =>
      _cache.putIfAbsent('C-SWAP-$control-$qubit1-$qubit2', () {
        //
        // double CNOT with TOFFOLI in between
        //
        // 0 --------*--------
        //           |
        // 1 ---*---TOF---*---
        //      |    |    |
        // 2 --NOT--TOF--NOT--
        //
        final not12 = _controlled.pauliX(qubit1, qubit2);
        final toffoli012 = toffoli(control, qubit2, qubit1);
        return not12.clone().mul(toffoli012).mul(not12);
      });

  ComplexMatrix cswap(int control, int qubit1, int qubit2) =>
      fredkin(control, qubit1, qubit2);

  ComplexMatrix qft(List<int> qubits, {bool swap = false}) =>
      _cache.putIfAbsent('QFT-$swap-${qubits.join('-')}', () {
        final n = qubits.length;
        final rotations = List.generate(
            n + 1, (i) => _Operators.phase(2 * math.pi / (1 << i)));
        final res = ComplexMatrix.identity(1 << size);
        for (var i = n; i >= 1; i--) {
          final q = qubits[i - 1];
          final m = QGates.unitary(size).hadamard(q);
          var r = 2;
          for (var j = i - 1; j >= 1; j--) {
            m.mul(QGates.controlled(size)
                .controlledGate(qubits[j - 1], q, rotations[r]));
            r++;
          }
          res.mul(m);
        }
        if (swap) {
          for (var i = 0; i < n / 2; i++) {
            res.mul(QGates.highLevel(size).swap(qubits[i], qubits[n - 1 - i]));
          }
        }
        return res;
      });

  ComplexMatrix invqft(List<int> qubits, {bool swap = false}) =>
      _cache.putIfAbsent('INVQFT-$swap-${qubits.join('-')}',
          () => qft(qubits, swap: swap).transpose().conjugate());
}

class CustomGates {
  CustomGates(this.size);

  final int size;

  final _cache = <String, ComplexMatrix>{};

  ComplexMatrix getOrSet(String key, ComplexMatrix Function() builder) =>
      _cache.putIfAbsent(key, builder);

  ComplexMatrix? get(String key) => _cache[key];
}

class QGates {
  static final Map<int, UnitaryGates> _unitary = <int, UnitaryGates>{};

  static UnitaryGates unitary(int size) =>
      _unitary.putIfAbsent(size, () => UnitaryGates(size));

  static final Map<int, ParallelGates> _parallel = <int, ParallelGates>{};

  static ParallelGates parallel(int size) =>
      _parallel.putIfAbsent(size, () => ParallelGates(size));

  static final Map<int, ControlledGates> _controlled = <int, ControlledGates>{};

  static ControlledGates controlled(int size) =>
      _controlled.putIfAbsent(size, () => ControlledGates(size));

  static final Map<int, HighLevelGates> _highLevel = <int, HighLevelGates>{};

  static HighLevelGates highLevel(int size) =>
      _highLevel.putIfAbsent(size, () => HighLevelGates(size));

  static final Map<int, CustomGates> _custom = <int, CustomGates>{};

  static CustomGates custom(int size) =>
      _custom.putIfAbsent(size, () => CustomGates(size));
}
