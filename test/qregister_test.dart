import 'package:qartvm/qartvm.dart';
import 'package:test/test.dart';

import 'math/complex_matcher.dart';

void main() {
  group('Quantum Register -', () {
    group('Initialization -', () {
      test('bytes', () {
        final qmem = QMemorySpace.zero(8);
        final qa = qmem.createRegister(
          'a',
          addresses: [Hardware.$3, Hardware.$2, Hardware.$1, Hardware.$0],
        );
        final qb = qmem.createRegister('b', from: Hardware.$7, to: Hardware.$4);
        qmem.initialize({qa: 6, qb: 7});
        var probs = qmem.probabilities;
        var sum = probs.values.reduce((s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['0110 0111'.replaceAll(' ', '')], closeTo(1, 1e-9));
        expect(qa.read(), equals(6));
        expect(qb.read(debug: true), equals(7));
        qmem.initialize({qa: 7, qb: 6});
        probs = qmem.probabilities;
        sum = probs.values.reduce((s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['0111 0110'.replaceAll(' ', '')], closeTo(1, 1e-9));
        expect(qa.read(), equals(7));
        expect(qb.read(), equals(6));
      });

      test('Qubit', () {
        final qmem = QMemorySpace.zero(8);
        final qa = qmem.createRegister('a', from: Hardware.$3, to: Hardware.$0);
        final qb = qmem.createRegister(
          'b',
          addresses: [Hardware.$7, Hardware.$6, Hardware.$5, Hardware.$4],
        );
        qmem.initialize({qa: Qbit.one, qb: Qbit.zero});
        var probs = qmem.probabilities;
        var sum = probs.values.reduce((s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['11110000'], closeTo(1, 1e-9));
        qmem.initialize({qa: Qbit.zero, qb: Qbit.one});
        probs = qmem.probabilities;
        sum = probs.values.reduce((s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00001111'], closeTo(1, 1e-9));
      });

      test('Qubits', () {
        final qmem = QMemorySpace.zero(8);
        final qa = qmem.createRegister(
          'a',
          addresses: [Hardware.$3, Hardware.$2, Hardware.$1, Hardware.$0],
        );
        final qb = qmem.createRegister(
          'b',
          addresses: [Hardware.$7, Hardware.$6, Hardware.$5, Hardware.$4],
        );
        qmem.initialize({
          qa: [Qbit.one, Qbit.one, Qbit.one, Qbit.zero],
          qb: [Qbit.zero, Qbit.zero, Qbit.one, Qbit.one],
        });
        var probs = qmem.probabilities;
        var sum = probs.values.reduce((s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['01111100'], closeTo(1, 1e-9));
        qmem.initialize({
          qa: [Qbit.one, Qbit.zero, Qbit.one, Qbit.one],
          qb: [Qbit.one, Qbit.zero, Qbit.zero, Qbit.one],
        });
        probs = qmem.probabilities;
        sum = probs.values.reduce((s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['11011001'], closeTo(1, 1e-9));
      });

      test('function - big endian', () {
        final qmem = QMemorySpace.zero(8);
        final qa = qmem.createRegister('a', from: Hardware.$3, to: Hardware.$0);
        final qb = qmem.createRegister('b', from: Hardware.$7, to: Hardware.$4);
        qmem.initialize({qa: () => 5, qb: () => 12});
        final probs = qmem.probabilities;
        final sum = probs.values.reduce((s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['0101 1100'.replaceAll(' ', '')], closeTo(1, 1e-9));
        expect(qa.read(), equals(5));
        expect(qb.read(), equals(12));
      });

      test('function - little endian', () {
        final qmem = QMemorySpace.zero(8);
        final qa = qmem.createRegister('a', from: Hardware.$0, to: Hardware.$3);
        final qb = qmem.createRegister('b', from: Hardware.$4, to: Hardware.$7);
        qmem.initialize({qa: () => 5, qb: () => 12});
        final probs = qmem.probabilities;
        final sum = probs.values.reduce((s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['1010 0011'.replaceAll(' ', '')], closeTo(1, 1e-9));
        expect(qa.read(), equals(5));
        expect(qb.read(), equals(12));
      });

      test('partial', () {
        final qmem = QMemorySpace.one(8);
        final qa = qmem.createRegister(
          'a',
          addresses: [Hardware.$3, Hardware.$2, Hardware.$1, Hardware.$0],
        );
        final qb = qmem.createRegister(
          'b',
          addresses: [Hardware.$7, Hardware.$6, Hardware.$5, Hardware.$4],
        );

        var probs = qmem.probabilities;
        var sum = probs.values.reduce((s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(qmem.getProbability('1111 1111'), closeTo(1, 1e-9));
        expect(qa.read(), equals(15));
        expect(qb.read(), equals(15));

        qmem.initialize({qa: 5});
        probs = qmem.probabilities;
        sum = probs.values.reduce((s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(qmem.getProbability('0101 0000'), closeTo(1, 1e-9));
        expect(qa.read(), equals(5));
        expect(qb.read(), equals(0));

        qmem.initialize();
        probs = qmem.probabilities;
        sum = probs.values.reduce((s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(qmem.getProbability('0000 0000'), closeTo(1, 1e-9));
        expect(qa.read(), equals(0));
        expect(qb.read(), equals(0));

        qmem.initialize({qa: 10, 6: Qbit.one});
        probs = qmem.probabilities;
        sum = probs.values.reduce((s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(qmem.getProbability('1010 0010'), closeTo(1, 1e-9));
        expect(qa.read(), equals(10));
        expect(qb.read(), equals(2));
      });
    });

    group('Read -', () {
      test('QFT inverse', () {
        final nqubits = 7;
        final qft = QGateBuilder.get(
          nqubits,
          withCache: false,
        ).highLevel.qft(Iterable<QbitAddress>.generate(nqubits).toList());

        final tc = qft.transpose().conjugate();
        var p = qft * tc;
        expect(
          p,
          complexMatrixEquals(
            ComplexSparseMatrix.identity(1 << nqubits),
            precision: 1e-9,
          ),
        );

        final inv = QGateBuilder.get(
          nqubits,
          withCache: false,
        ).highLevel.invqft(Iterable<QbitAddress>.generate(nqubits).toList());
        p = qft * inv;
        expect(
          p,
          complexMatrixEquals(
            ComplexSparseMatrix.identity(1 << nqubits),
            precision: 1e-9,
          ),
        );
      });
    });
  });
}
