import 'package:test/test.dart';

import 'package:qartvm/src/qcircuit.dart';
import 'package:qartvm/src/qregister.dart';
import 'package:qartvm/src/qbit.dart';

void main() {
  group('Quantum Circuit', () {
    group('Unitary gates', () {
      test('Hadamard', () {
        // hadamard on first qubit
        final h0 = QCircuit(size: 2).hadamard(0);

        // test
        final qreg = QRegister.zero(2);
        h0.execute(qreg);
        var probs = qreg.probabilities;
        var sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(0.5, 1e-9));
        expect(probs['01'], closeTo(0, 1e-9));
        expect(probs['10'], closeTo(0.5, 1e-9));
        expect(probs['11'], closeTo(0, 1e-9));

        // hadamard on second qubit
        final h1 = QCircuit(size: 2).hadamard(1);

        // test
        h1.execute(qreg);
        probs = qreg.probabilities;
        sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(0.25, 1e-9));
        expect(probs['01'], closeTo(0.25, 1e-9));
        expect(probs['10'], closeTo(0.25, 1e-9));
        expect(probs['11'], closeTo(0.25, 1e-9));

        // hadamard on first+second qubit (revert previous operations)
        final h01 = QCircuit(size: 2).hadamard({0, 1});

        // test
        h01.execute(qreg);
        probs = qreg.probabilities;
        sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(1, 1e-9));
        expect(probs['01'], closeTo(0, 1e-9));
        expect(probs['10'], closeTo(0, 1e-9));
        expect(probs['11'], closeTo(0, 1e-9));
      });

      test('Hadamard (random)', () {
        final qubit = Qbit.random();
        final qreg = QRegister([Qbit.zero, qubit]);
        // initial state
        var probs = qreg.probabilities;
        var sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(qubit.ket0.det, 1e-9));
        expect(probs['01'], closeTo(qubit.ket1.det, 1e-9));
        expect(probs['10'], closeTo(0, 1e-9));
        expect(probs['11'], closeTo(0, 1e-9));
        // hadamard
        final h = QCircuit(size: 2).hadamard(0);
        h.execute(qreg);
        probs = qreg.probabilities;
        sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(qubit.ket0.det / 2, 1e-9));
        expect(probs['01'], closeTo(qubit.ket1.det / 2, 1e-9));
        expect(probs['10'], closeTo(qubit.ket0.det / 2, 1e-9));
        expect(probs['11'], closeTo(qubit.ket1.det / 2, 1e-9));
      });

      group('Truth table', () {
        test('PauliX', () {
          final qreg = QRegister([Qbit.zero, Qbit.one]);
          // initial state
          var probs = qreg.probabilities;
          var sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(1, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
          // first qubit
          final not0 = QCircuit(size: 2).not(0);
          not0.execute(qreg);
          probs = qreg.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(0, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(1, 1e-9));
          // second qubit
          final not1 = QCircuit(size: 2).not(1);
          not1.execute(qreg);
          probs = qreg.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(0, 1e-9));
          expect(probs['10'], closeTo(1, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
          // undo
          final not01 = QCircuit(size: 2).not({0, 1});
          not01.execute(qreg);
          probs = qreg.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(1, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
        });

        test('PauliY', () {
          final qreg = QRegister([Qbit.zero, Qbit.one]);
          // initial state
          var probs = qreg.probabilities;
          var sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(1, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
          // first qubit
          final y0 = QCircuit(size: 2).pauliY(0);
          y0.execute(qreg);
          probs = qreg.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(0, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(1, 1e-9));
          // second qubit
          final y1 = QCircuit(size: 2).pauliY(1);
          y1.execute(qreg);
          probs = qreg.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(0, 1e-9));
          expect(probs['10'], closeTo(1, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
          // undo
          final y01 = QCircuit(size: 2).not({0, 1});
          y01.execute(qreg);
          probs = qreg.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(1, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
        });

        test('PauliZ', () {
          final qreg = QRegister([Qbit.zero, Qbit.one]);
          // initial state
          var probs = qreg.probabilities;
          var sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(1, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
          // first qubit
          final z0 = QCircuit(size: 2).pauliZ(0);
          z0.execute(qreg);
          probs = qreg.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(1, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
          // second qubit
          final z1 = QCircuit(size: 2).pauliZ(1);
          z1.execute(qreg);
          probs = qreg.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(1, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
          // undo
          final z01 = QCircuit(size: 2).pauliZ({0, 1});
          z01.execute(qreg);
          probs = qreg.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(1, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
        });

        test('Square Root of X', () {
          final qreg = QRegister([Qbit.zero, Qbit.one]);
          // initial state
          var probs = qreg.probabilities;
          var sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(1, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
          // first qubit
          final sqrtX0 = QCircuit(size: 2).squareRootOfX(0);
          sqrtX0.execute(qreg);
          probs = qreg.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(0.5, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(0.5, 1e-9));
          // second qubit
          final sqrtX1 = QCircuit(size: 2).squareRootOfX(1);
          sqrtX1.execute(qreg);
          probs = qreg.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0.25, 1e-9));
          expect(probs['01'], closeTo(0.25, 1e-9));
          expect(probs['10'], closeTo(0.25, 1e-9));
          expect(probs['11'], closeTo(0.25, 1e-9));
          // again (= X)
          final sqrtX01 = QCircuit(size: 2).squareRootOfX({0, 1});
          sqrtX01.execute(qreg);
          probs = qreg.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(0, 1e-9));
          expect(probs['10'], closeTo(1, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
        });

        test('Controlled NOT (2-qubit register)', () {
          final ctrlX01 = QCircuit(size: 2).not(1, controls: 0);
          // |00> => |00>
          var qreg = QRegister([Qbit.zero, Qbit.zero]);
          ctrlX01.execute(qreg);
          var probs = qreg.probabilities;
          var sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(1, 1e-9));
          expect(probs['01'], closeTo(0, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
          // |01> => |01>
          qreg = QRegister([Qbit.zero, Qbit.one]);
          ctrlX01.execute(qreg);
          probs = qreg.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(1, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
          // |10> => |11>
          qreg = QRegister([Qbit.one, Qbit.zero]);
          ctrlX01.execute(qreg);
          probs = qreg.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(0, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(1, 1e-9));
          // |11> => |10>
          qreg = QRegister([Qbit.one, Qbit.one]);
          ctrlX01.execute(qreg);
          probs = qreg.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(0, 1e-9));
          expect(probs['10'], closeTo(1, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
        });

        test('Controlled NOT (2-qubit register with random control)', () {
          final control = Qbit.random();
          var qreg = QRegister([control, Qbit.zero]);
          // cnot on 1 with control 0
          final ctrlX01 = QCircuit(size: 2).not(1, controls: 0);
          ctrlX01.execute(qreg);
          var probs = qreg.probabilities;
          var sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(control.ket0.det, 1e-9));
          expect(probs['01'], closeTo(0, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(control.ket1.det, 1e-9));
          // measure control qubit (via register)
          final qubit = qreg[0];
          qreg.measure(qubits: {qubit.id});
          final qstate = qubit.state;
          probs = qreg.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo((qstate == '0') ? 1 : 0, 1e-9));
          expect(probs['01'], closeTo(0, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo((qstate == '1') ? 1 : 0, 1e-9));
        });

        test('Controlled NOT (3-qubit register)', () {
          final crtlX02 = QCircuit(size: 3).not(2, controls: 0);
          // |0?0> => |0?0>
          var qreg = QRegister([Qbit.zero, Qbit.random(), Qbit.zero]);
          crtlX02.execute(qreg);
          var probs = qreg.probabilities;
          var sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(qreg.getPropability('0.0'), closeTo(1, 1e-9));
          expect(qreg.getPropability('0.1'), closeTo(0, 1e-9));
          expect(qreg.getPropability('1.0'), closeTo(0, 1e-9));
          expect(qreg.getPropability('1.1'), closeTo(0, 1e-9));
          // |0?1> => |0?1>
          qreg = QRegister([Qbit.zero, Qbit.random(), Qbit.one]);
          crtlX02.execute(qreg);
          probs = qreg.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(qreg.getPropability('0.0'), closeTo(0, 1e-9));
          expect(qreg.getPropability('0.1'), closeTo(1, 1e-9));
          expect(qreg.getPropability('1.0'), closeTo(0, 1e-9));
          expect(qreg.getPropability('1.1'), closeTo(0, 1e-9));
          // |1?0> => |1?1>
          qreg = QRegister([Qbit.one, Qbit.random(), Qbit.zero]);
          crtlX02.execute(qreg);
          probs = qreg.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(qreg.getPropability('0.0'), closeTo(0, 1e-9));
          expect(qreg.getPropability('0.1'), closeTo(0, 1e-9));
          expect(qreg.getPropability('1.0'), closeTo(0, 1e-9));
          expect(qreg.getPropability('1.1'), closeTo(1, 1e-9));
          // |1?1> => |1?0>
          qreg = QRegister([Qbit.one, Qbit.random(), Qbit.one]);
          crtlX02.execute(qreg);
          probs = qreg.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(qreg.getPropability('0.0'), closeTo(0, 1e-9));
          expect(qreg.getPropability('0.1'), closeTo(0, 1e-9));
          expect(qreg.getPropability('1.0'), closeTo(1, 1e-9));
          expect(qreg.getPropability('1.1'), closeTo(0, 1e-9));
        });
      });
    });
  });
}
