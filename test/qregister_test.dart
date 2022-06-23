import 'package:test/test.dart';

import 'package:qartvm/qartvm.dart';

import 'complex_matcher.dart';

void main() {
  group('Quantum Register', () {
    group('Initialization', () {
      test('bytes', () {
        final qmem = QMemorySpace.zero(8);
        final qa = qmem.createRegister('a', addresses: [3, 2, 1, 0]);
        final qb = qmem.createRegister('b', from: 7, to: 4);
        qmem.initialize({
          qa: 6,
          qb: 7,
        });
        var probs = qmem.probabilities;
        var sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['01101110'], closeTo(1, 1e-9));
        expect(qa.read(), equals(6));
        expect(qb.read(), equals(7));
        qmem.initialize({
          qa: 7,
          qb: 6,
        });
        probs = qmem.probabilities;
        sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['11100110'], closeTo(1, 1e-9));
        expect(qa.read(), equals(7));
        expect(qb.read(), equals(6));
      });

      test('Qubit', () {
        final qmem = QMemorySpace.zero(8);
        final qa = qmem.createRegister('a', from: 3, to: 0);
        final qb = qmem.createRegister('b', addresses: [7, 6, 5, 4]);
        qmem.initialize({
          qa: Qbit.one,
          qb: Qbit.zero,
        });
        var probs = qmem.probabilities;
        var sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['11110000'], closeTo(1, 1e-9));
        qmem.initialize({
          qa: Qbit.zero,
          qb: Qbit.one,
        });
        probs = qmem.probabilities;
        sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00001111'], closeTo(1, 1e-9));
      });

      test('Qubits', () {
        final qmem = QMemorySpace.zero(8);
        final qa = qmem.createRegister('a', addresses: [3, 2, 1, 0]);
        final qb = qmem.createRegister('b', addresses: [7, 6, 5, 4]);
        qmem.initialize({
          qa: [Qbit.one, Qbit.one, Qbit.one, Qbit.zero],
          qb: [Qbit.zero, Qbit.zero, Qbit.one, Qbit.one],
        });
        var probs = qmem.probabilities;
        var sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['01111100'], closeTo(1, 1e-9));
        qmem.initialize({
          qa: [Qbit.one, Qbit.zero, Qbit.one, Qbit.one],
          qb: [Qbit.one, Qbit.zero, Qbit.zero, Qbit.one],
        });
        probs = qmem.probabilities;
        sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['11011001'], closeTo(1, 1e-9));
      });

      test('function', () {
        final qmem = QMemorySpace.zero(8);
        final qa = qmem.createRegister('a', from: 3, to: 0);
        final qb = qmem.createRegister('b', from: 7, to: 4);
        qmem.initialize({
          qa: () => 5,
          qb: () => 12,
        });
        final probs = qmem.probabilities;
        final sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['10100011'], closeTo(1, 1e-9));
        expect(qa.read(), equals(5));
        expect(qb.read(), equals(12));
      });

      test('partial', () {
        final qmem = QMemorySpace.one(8);
        final qa = qmem.createRegister('a', addresses: [3, 2, 1, 0]);
        final qb = qmem.createRegister('b', addresses: [7, 6, 5, 4]);

        var probs = qmem.probabilities;
        var sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(qmem.getPropability('1111 1111'), closeTo(1, 1e-9));
        expect(qa.read(), equals(15));
        expect(qb.read(), equals(15));

        qmem.initialize({
          qa: 5,
        });
        probs = qmem.probabilities;
        sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(qmem.getPropability('1010 0000'), closeTo(1, 1e-9));
        expect(qa.read(), equals(5));
        expect(qb.read(), equals(0));

        qmem.initialize();
        probs = qmem.probabilities;
        sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(qmem.getPropability('0000 0000'), closeTo(1, 1e-9));
        expect(qa.read(), equals(0));
        expect(qb.read(), equals(0));

        qmem.initialize({
          qa: 5,
          6: Qbit.one,
        });
        probs = qmem.probabilities;
        sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(qmem.getPropability('1010 0010'), closeTo(1, 1e-9));
        expect(qa.read(), equals(5));
        expect(qb.read(), equals(4));
      });
    });

    group('Read', () {
      test('QFT inverse', () {
        final nqubits = 7;
        final qft = QGateBuilder.get(nqubits)
            .highLevel
            .qft(Iterable<int>.generate(nqubits).toList());

        final tc = qft.transpose().conjugate();
        var p = qft * tc;
        expect(
            p,
            complexMatrixEquals(ComplexMatrix.identity(1 << nqubits),
                precision: 1e-9));

        final inv = QGateBuilder.get(nqubits)
            .highLevel
            .invqft(Iterable<int>.generate(nqubits).toList());
        p = qft * inv;
        expect(
            p,
            complexMatrixEquals(ComplexMatrix.identity(1 << nqubits),
                precision: 1e-9));
      });
    });
  });
}
