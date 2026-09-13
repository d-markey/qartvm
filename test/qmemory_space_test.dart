import 'package:qartvm/qartvm.dart';
import 'package:test/test.dart';

import 'math/complex_matcher.dart';

void main() {
  group('Quantum Memory Space -', () {
    group('Generation -', () {
      test('zeroes', () {
        final qmem = QMemorySpace.zero(2);
        final probs = qmem.probabilities;
        final sum = probs.values.reduce((s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(1, 1e-9));
        expect(probs['01'], closeTo(0, 1e-9));
        expect(probs['10'], closeTo(0, 1e-9));
        expect(probs['11'], closeTo(0, 1e-9));
      });

      test('ones', () {
        final qmem = QMemorySpace.one(3);
        final probs = qmem.probabilities;
        final sum = probs.values.reduce((s, p) => s + p);
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
        var sum = probs.values.reduce((s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(1, 1e-9));
        expect(probs['01'], closeTo(0, 1e-9));
        expect(probs['10'], closeTo(0, 1e-9));
        expect(probs['11'], closeTo(0, 1e-9));
        // |01>
        qmem = QMemorySpace([Qbit.zero, Qbit.one]);
        probs = qmem.probabilities;
        sum = probs.values.reduce((s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(0, 1e-9));
        expect(probs['01'], closeTo(1, 1e-9));
        expect(probs['10'], closeTo(0, 1e-9));
        expect(probs['11'], closeTo(0, 1e-9));
        // |10>
        qmem = QMemorySpace([Qbit.one, Qbit.zero]);
        probs = qmem.probabilities;
        sum = probs.values.reduce((s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(0, 1e-9));
        expect(probs['01'], closeTo(0, 1e-9));
        expect(probs['10'], closeTo(1, 1e-9));
        expect(probs['11'], closeTo(0, 1e-9));
        // |11>
        qmem = QMemorySpace([Qbit.one, Qbit.one]);
        probs = qmem.probabilities;
        sum = probs.values.reduce((s, p) => s + p);
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
        final sum = probs.values.reduce((s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(
          probs['000'],
          closeTo(q1.ket0.modulus2 * q2.ket0.modulus2 * q3.ket0.modulus2, 1e-9),
        );
        expect(
          probs['001'],
          closeTo(q1.ket0.modulus2 * q2.ket0.modulus2 * q3.ket1.modulus2, 1e-9),
        );
        expect(
          probs['010'],
          closeTo(q1.ket0.modulus2 * q2.ket1.modulus2 * q3.ket0.modulus2, 1e-9),
        );
        expect(
          probs['011'],
          closeTo(q1.ket0.modulus2 * q2.ket1.modulus2 * q3.ket1.modulus2, 1e-9),
        );
        expect(
          probs['100'],
          closeTo(q1.ket1.modulus2 * q2.ket0.modulus2 * q3.ket0.modulus2, 1e-9),
        );
        expect(
          probs['101'],
          closeTo(q1.ket1.modulus2 * q2.ket0.modulus2 * q3.ket1.modulus2, 1e-9),
        );
        expect(
          probs['110'],
          closeTo(q1.ket1.modulus2 * q2.ket1.modulus2 * q3.ket0.modulus2, 1e-9),
        );
        expect(
          probs['111'],
          closeTo(q1.ket1.modulus2 * q2.ket1.modulus2 * q3.ket1.modulus2, 1e-9),
        );
      });

      test('qubyte', () {
        final q0 = QMemorySpace.load(0);
        expect(q0.getProbability('0000 0000'), equals(1));
        expect(q0.read(), equals(0));

        final q1 = QMemorySpace.load(1);
        expect(q1.getProbability('1000 0000'), equals(1));
        expect(q1.read(), equals(1));

        final q2 = QMemorySpace.load(2);
        expect(q2.getProbability('0100 0000'), equals(1));
        expect(q2.read(), equals(2));

        final q4 = QMemorySpace.load(4);
        expect(q4.getProbability('0010 0000'), equals(1));
        final q8 = QMemorySpace.load(8);
        expect(q8.getProbability('0001 0000'), equals(1));

        final q5 = QMemorySpace.load(5);
        expect(q5.getProbability('1010 0000'), equals(1));
        expect(q5.read(), equals(5));

        final q13 = QMemorySpace.load(13);
        expect(q13.getProbability('1011 0000'), equals(1));
        final q16 = QMemorySpace.load(16);
        expect(q16.getProbability('0000 1000'), equals(1));
        final q127 = QMemorySpace.load(127);
        expect(q127.getProbability('1111 1110'), equals(1));
        final q128 = QMemorySpace.load(128);
        expect(q128.getProbability('0000 0001'), equals(1));
        final q255 = QMemorySpace.load(255);
        expect(q255.getProbability('1111 1111'), equals(1));

        expect(() {
          final q256 = QMemorySpace.load(256);
          expect(q256.getProbability('0000 0000 1'), equals(1));
        }, throwsA(isA<InvalidOperationException>()));

        final q256 = QMemorySpace.load(256, size: 9);
        expect(q256.getProbability('0000 0000 1'), equals(1));
      });

      test('Qubit initialization', () {
        final qmem = QMemorySpace.load(127);
        expect(qmem.probabilities['11111110'], equals(1));

        qmem.initialize({0: 1, 1: Qbit.one, 3: Qbit.one, 6: 1, 7: 0});
        expect(qmem.probabilities['11010010'], equals(1));
      });
    });

    group('Gates -', () {
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

    group('Measurement Mode -', () {
      test('independent (default)', () {
        final qmem = QMemorySpace.plus(
          2,
        ); // |+>|+> = 1/2 (|00> + |01> + |10> + |11>)
        final res = qmem.read(mode: QMeasureMode.independent);
        expect(res, inInclusiveRange(0, 3));
        // State should be collapsed
        final probs = qmem.probabilities;
        expect(probs.values.where((p) => p > 0.99).length, equals(1));
      });

      test('joint', () {
        final qmem = QMemorySpace.plus(2);
        final res = qmem.read(mode: QMeasureMode.joint);
        expect(res, inInclusiveRange(0, 3));
        final probs = qmem.probabilities;
        expect(probs.values.where((p) => p > 0.99).length, equals(1));
      });

      test('property control', () {
        final qmem = QMemorySpace.plus(2);
        qmem.measureMode = QMeasureMode.joint;
        final res = qmem.read(); // should use joint
        expect(res, inInclusiveRange(0, 3));
        final probs = qmem.probabilities;
        expect(probs.values.where((p) => p > 0.99).length, equals(1));
      });

      test('entangled state joint measure', () {
        // Create Bell state |00> + |11>
        final builder = QGateBuilder.get(2, withCache: false);
        final circuit = QCircuit(builder);
        circuit.hadamard(0);
        circuit.not(1, controls: 0);

        final qmem = QMemorySpace.zero(2);
        circuit.execute(qmem);

        // Initial probs: 00: 0.5, 11: 0.5
        expect(qmem.probabilities['00'], closeTo(0.5, 1e-9));
        expect(qmem.probabilities['11'], closeTo(0.5, 1e-9));

        final res = qmem.read(mode: QMeasureMode.joint);
        expect(res == 0 || res == 3, isTrue);

        final probs = qmem.probabilities;
        if (res == 0) {
          expect(probs['00'], closeTo(1, 1e-9));
        } else {
          expect(probs['11'], closeTo(1, 1e-9));
        }
      });

      test('partial joint measure', () {
        // 3 qubits: q0, q1, q2
        // q0, q1 in Bell state, q2 in |1>
        final builder = QGateBuilder.get(3, withCache: false);
        final circuit = QCircuit(builder);
        circuit.hadamard(0);
        circuit.not(1, controls: 0);
        circuit.not(2);

        final qmem = QMemorySpace.zero(3);
        circuit.execute(qmem);

        // Probs: 001: 0.5, 111: 0.5
        expect(qmem.probabilities['001'], closeTo(0.5, 1e-9));
        expect(qmem.probabilities['111'], closeTo(0.5, 1e-9));

        // Measure only q0 and q1 jointly
        final res = qmem.read(
          qbits: [Hardware.$0, Hardware.$1],
          mode: QMeasureMode.joint,
        );
        expect(res == 0 || res == 3, isTrue);

        // q2 should still be |1>
        expect(qmem.getProbability('..1'), closeTo(1, 1e-9));

        final probs = qmem.probabilities;
        if (res == 0) {
          expect(probs['001'], closeTo(1, 1e-9));
        } else {
          expect(probs['111'], closeTo(1, 1e-9));
        }
      });
    });
  });
}
