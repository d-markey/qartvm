import 'package:qartvm/src/math/complex_matrix.dart';
import 'package:qartvm/src/qgates.dart';
import 'package:test/test.dart';

import 'package:qartvm/src/qregister.dart';
import 'package:qartvm/src/qbit.dart';

import 'complex_matcher.dart';

void main() {
  group('Quantum Register', () {
    group('Generation', () {
      test('zeroes', () {
        final qreg = QRegister.zero(2);
        final probs = qreg.probabilities;
        final sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(1, 1e-9));
        expect(probs['01'], closeTo(0, 1e-9));
        expect(probs['10'], closeTo(0, 1e-9));
        expect(probs['11'], closeTo(0, 1e-9));
      });

      test('ones', () {
        final qreg = QRegister.one(3);
        final probs = qreg.probabilities;
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
        var qreg = QRegister([Qbit.zero, Qbit.zero]);
        var probs = qreg.probabilities;
        var sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(1, 1e-9));
        expect(probs['01'], closeTo(0, 1e-9));
        expect(probs['10'], closeTo(0, 1e-9));
        expect(probs['11'], closeTo(0, 1e-9));
        // |01>
        qreg = QRegister([Qbit.zero, Qbit.one]);
        probs = qreg.probabilities;
        sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(0, 1e-9));
        expect(probs['01'], closeTo(1, 1e-9));
        expect(probs['10'], closeTo(0, 1e-9));
        expect(probs['11'], closeTo(0, 1e-9));
        // |10>
        qreg = QRegister([Qbit.one, Qbit.zero]);
        probs = qreg.probabilities;
        sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(0, 1e-9));
        expect(probs['01'], closeTo(0, 1e-9));
        expect(probs['10'], closeTo(1, 1e-9));
        expect(probs['11'], closeTo(0, 1e-9));
        // |11>
        qreg = QRegister([Qbit.one, Qbit.one]);
        probs = qreg.probabilities;
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
        final qreg = QRegister([q1, q2, q3]);
        final probs = qreg.probabilities;
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
        final q0 = QRegister.load(0);
        expect(q0.probabilities['00000000'], equals(1));
        final q1 = QRegister.load(1);
        expect(q1.probabilities['10000000'], equals(1));
        final q2 = QRegister.load(2);
        expect(q2.probabilities['01000000'], equals(1));
        final q4 = QRegister.load(4);
        expect(q4.probabilities['00100000'], equals(1));
        final q8 = QRegister.load(8);
        expect(q8.probabilities['00010000'], equals(1));

        final q5 = QRegister.load(5);
        expect(q5.probabilities['10100000'], equals(1));
      });
    });

    group('Gates', () {
      test('QFT inverse', () {
        final nqubits = 7;
        final qft =
            QGates.highLevel(nqubits).qft(List.generate(nqubits, (i) => i));
        // final inv = qft.inverse();
        // final prod = qft * inv;
        // expect(prod, complexMatrixEquals(ComplexMatrix.identity(1 << nqubits), precision: 1e-9));

        final tc = qft.transpose().conjugate();
        final p = qft * tc;
        expect(
            p,
            complexMatrixEquals(ComplexMatrix.identity(1 << nqubits),
                precision: 1e-9));
      });
    });
  });
}
