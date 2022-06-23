import 'package:qartvm/qartvm.dart';
import 'package:test/test.dart';

import 'complex_matcher.dart';

void main() {
  group('Quantum Memory Space', () {
    group('Generation', () {
      test('zeroes', () {
        final qmem = QMemorySpace.zero(2);
        final probs = qmem.probabilities;
        final sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(1, 1e-9));
        expect(probs['01'], closeTo(0, 1e-9));
        expect(probs['10'], closeTo(0, 1e-9));
        expect(probs['11'], closeTo(0, 1e-9));
      });

      test('ones', () {
        final qmem = QMemorySpace.one(3);
        final probs = qmem.probabilities;
        final sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['000'], closeTo(0, 1e-9));
        expect(probs['001'], closeTo(0, 1e-9));
        expect(probs['010'], closeTo(0, 1e-9));
        expect(probs['011'], closeTo(0, 1e-9));
        expect(probs['100'], closeTo(0, 1e-9));
        expect(probs['101'], closeTo(0, 1e-9));
        expect(probs['110'], closeTo(0, 1e-9));
        expect(probs['111'], closeTo(1, 1e-9));
      });

      test('ones and zeroes', () {
        // |00>
        var qmem = QMemorySpace([Qbit.zero, Qbit.zero]);
        var probs = qmem.probabilities;
        var sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(1, 1e-9));
        expect(probs['01'], closeTo(0, 1e-9));
        expect(probs['10'], closeTo(0, 1e-9));
        expect(probs['11'], closeTo(0, 1e-9));
        // |01>
        qmem = QMemorySpace([Qbit.zero, Qbit.one]);
        probs = qmem.probabilities;
        sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(0, 1e-9));
        expect(probs['01'], closeTo(1, 1e-9));
        expect(probs['10'], closeTo(0, 1e-9));
        expect(probs['11'], closeTo(0, 1e-9));
        // |10>
        qmem = QMemorySpace([Qbit.one, Qbit.zero]);
        probs = qmem.probabilities;
        sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(0, 1e-9));
        expect(probs['01'], closeTo(0, 1e-9));
        expect(probs['10'], closeTo(1, 1e-9));
        expect(probs['11'], closeTo(0, 1e-9));
        // |11>
        qmem = QMemorySpace([Qbit.one, Qbit.one]);
        probs = qmem.probabilities;
        sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(0, 1e-9));
        expect(probs['01'], closeTo(0, 1e-9));
        expect(probs['10'], closeTo(0, 1e-9));
        expect(probs['11'], closeTo(1, 1e-9));
      });

      test('random', () {
        final q1 = Qbit.random();
        final q2 = Qbit.random();
        final q3 = Qbit.random();
        final qmem = QMemorySpace([q1, q2, q3]);
        final probs = qmem.probabilities;
        final sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['000'],
            closeTo(q1.ket0.det * q2.ket0.det * q3.ket0.det, 1e-9));
        expect(probs['001'],
            closeTo(q1.ket0.det * q2.ket0.det * q3.ket1.det, 1e-9));
        expect(probs['010'],
            closeTo(q1.ket0.det * q2.ket1.det * q3.ket0.det, 1e-9));
        expect(probs['011'],
            closeTo(q1.ket0.det * q2.ket1.det * q3.ket1.det, 1e-9));
        expect(probs['100'],
            closeTo(q1.ket1.det * q2.ket0.det * q3.ket0.det, 1e-9));
        expect(probs['101'],
            closeTo(q1.ket1.det * q2.ket0.det * q3.ket1.det, 1e-9));
        expect(probs['110'],
            closeTo(q1.ket1.det * q2.ket1.det * q3.ket0.det, 1e-9));
        expect(probs['111'],
            closeTo(q1.ket1.det * q2.ket1.det * q3.ket1.det, 1e-9));
      });

      test('qubyte', () {
        final q0 = QMemorySpace.load(0);
        expect(q0.getPropability('0000 0000'), equals(1));
        final q1 = QMemorySpace.load(1);
        expect(q1.getPropability('1000 0000'), equals(1));
        final q2 = QMemorySpace.load(2);
        expect(q2.getPropability('0100 0000'), equals(1));
        final q4 = QMemorySpace.load(4);
        expect(q4.getPropability('0010 0000'), equals(1));
        final q8 = QMemorySpace.load(8);
        expect(q8.getPropability('0001 0000'), equals(1));

        final q5 = QMemorySpace.load(5);
        expect(q5.getPropability('1010 0000'), equals(1));
        final q13 = QMemorySpace.load(13);
        expect(q13.getPropability('1011 0000'), equals(1));
        final q16 = QMemorySpace.load(16);
        expect(q16.getPropability('0000 1000'), equals(1));
        final q127 = QMemorySpace.load(127);
        expect(q127.getPropability('1111 1110'), equals(1));
        final q128 = QMemorySpace.load(128);
        expect(q128.getPropability('0000 0001'), equals(1));
        final q255 = QMemorySpace.load(255);
        expect(q255.getPropability('1111 1111'), equals(1));

        expect(() {
          final q256 = QMemorySpace.load(256);
          expect(q256.getPropability('0000 0000 1'), equals(1));
        }, throwsA(isA<InvalidOperationException>()));

        final q256 = QMemorySpace.load(256, size: 9);
        expect(q256.getPropability('0000 0000 1'), equals(1));
      });

      test('Qubit initialization', () {
        final qmem = QMemorySpace.load(127);
        expect(qmem.probabilities['11111110'], equals(1));

        qmem.initialize({
          0: 1,
          1: Qbit.one,
          3: Qbit.one,
          6: 1,
          7: 0,
        });
        expect(qmem.probabilities['11010010'], equals(1));
      });
    });

    group('Gates', () {
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
