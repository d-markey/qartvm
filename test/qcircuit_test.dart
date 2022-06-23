import 'dart:math' as math;

import 'package:qartvm/qartvm.dart';
import 'package:test/test.dart';

void main() {
  group('Quantum Circuit', () {
    final gateBuilder2 = QGateBuilder.get(2, withCache: true);
    final gateBuilder3 = QGateBuilder.get(3, withCache: true);

    group('Unitary gates', () {
      test('Hadamard', () {
        // hadamard on first qubit
        final h0 = QCircuit(gateBuilder2).hadamard(0);

        // test
        final qmem = QMemorySpace.zero(2);
        h0.execute(qmem);
        var probs = qmem.probabilities;
        var sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(0.5, 1e-9));
        expect(probs['01'], closeTo(0, 1e-9));
        expect(probs['10'], closeTo(0.5, 1e-9));
        expect(probs['11'], closeTo(0, 1e-9));

        // hadamard on second qubit
        final h1 = QCircuit(gateBuilder2).hadamard(1);

        // test
        h1.execute(qmem);
        probs = qmem.probabilities;
        sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(0.25, 1e-9));
        expect(probs['01'], closeTo(0.25, 1e-9));
        expect(probs['10'], closeTo(0.25, 1e-9));
        expect(probs['11'], closeTo(0.25, 1e-9));

        // hadamard on first+second qubit (revert previous operations)
        final h01 = QCircuit(gateBuilder2).hadamard({0, 1});

        // test
        h01.execute(qmem);
        probs = qmem.probabilities;
        sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(1, 1e-9));
        expect(probs['01'], closeTo(0, 1e-9));
        expect(probs['10'], closeTo(0, 1e-9));
        expect(probs['11'], closeTo(0, 1e-9));
      });

      test('Hadamard (random)', () {
        final qubit = Qbit.random();
        final qmem = QMemorySpace([Qbit.zero, qubit]);
        // initial state
        var probs = qmem.probabilities;
        var sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(qubit.ket0.det, 1e-9));
        expect(probs['01'], closeTo(qubit.ket1.det, 1e-9));
        expect(probs['10'], closeTo(0, 1e-9));
        expect(probs['11'], closeTo(0, 1e-9));
        // hadamard
        final h = QCircuit(gateBuilder2).hadamard(0);
        h.execute(qmem);
        probs = qmem.probabilities;
        sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(qubit.ket0.det / 2, 1e-9));
        expect(probs['01'], closeTo(qubit.ket1.det / 2, 1e-9));
        expect(probs['10'], closeTo(qubit.ket0.det / 2, 1e-9));
        expect(probs['11'], closeTo(qubit.ket1.det / 2, 1e-9));
      });

      test('Bell state', () {
        final qmem = QMemorySpace([Qbit.zero, Qbit.zero]);
        // initial state
        var probs = qmem.probabilities;
        var sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(1, 1e-9));
        expect(probs['01'], closeTo(0, 1e-9));
        expect(probs['10'], closeTo(0, 1e-9));
        expect(probs['11'], closeTo(0, 1e-9));
        // bell state
        final bs = QCircuit(gateBuilder2).hadamard(0).not(1, controls: 0);
        bs.execute(qmem);
        probs = qmem.probabilities;
        sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(0.5, 1e-9));
        expect(probs['01'], closeTo(0, 1e-9));
        expect(probs['10'], closeTo(0, 1e-9));
        expect(probs['11'], closeTo(0.5, 1e-9));
      });

      group('Truth table', () {
        test('PauliX', () {
          final qmem = QMemorySpace([Qbit.zero, Qbit.one]);
          // initial state
          var probs = qmem.probabilities;
          var sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(1, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
          // first qubit
          final not0 = QCircuit(gateBuilder2).not(0);
          not0.execute(qmem);
          probs = qmem.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(0, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(1, 1e-9));
          // second qubit
          final not1 = QCircuit(gateBuilder2).not(1);
          not1.execute(qmem);
          probs = qmem.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(0, 1e-9));
          expect(probs['10'], closeTo(1, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
          // undo
          final not01 = QCircuit(gateBuilder2).not({0, 1});
          not01.execute(qmem);
          probs = qmem.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(1, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
        });

        test('PauliY', () {
          final qmem = QMemorySpace([Qbit.zero, Qbit.one]);
          // initial state
          var probs = qmem.probabilities;
          var sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(1, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
          // first qubit
          final y0 = QCircuit(gateBuilder2).pauliY(0);
          y0.execute(qmem);
          probs = qmem.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(0, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(1, 1e-9));
          // second qubit
          final y1 = QCircuit(gateBuilder2).pauliY(1);
          y1.execute(qmem);
          probs = qmem.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(0, 1e-9));
          expect(probs['10'], closeTo(1, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
          // undo
          final y01 = QCircuit(gateBuilder2).not({0, 1});
          y01.execute(qmem);
          probs = qmem.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(1, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
        });

        test('PauliZ', () {
          final qmem = QMemorySpace([Qbit.zero, Qbit.one]);
          // initial state
          var probs = qmem.probabilities;
          var sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(1, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
          // first qubit
          final z0 = QCircuit(gateBuilder2).pauliZ(0);
          z0.execute(qmem);
          probs = qmem.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(1, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
          // second qubit
          final z1 = QCircuit(gateBuilder2).pauliZ(1);
          z1.execute(qmem);
          probs = qmem.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(1, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
          // undo
          final z01 = QCircuit(gateBuilder2).pauliZ({0, 1});
          z01.execute(qmem);
          probs = qmem.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(1, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
        });

        test('Square Root of X', () {
          final qmem = QMemorySpace([Qbit.zero, Qbit.one]);
          // initial state
          var probs = qmem.probabilities;
          var sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(1, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
          // first qubit
          final sqrtX0 = QCircuit(gateBuilder2).squareRootOfX(0);
          sqrtX0.execute(qmem);
          probs = qmem.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(0.5, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(0.5, 1e-9));
          // second qubit
          final sqrtX1 = QCircuit(gateBuilder2).squareRootOfX(1);
          sqrtX1.execute(qmem);
          probs = qmem.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0.25, 1e-9));
          expect(probs['01'], closeTo(0.25, 1e-9));
          expect(probs['10'], closeTo(0.25, 1e-9));
          expect(probs['11'], closeTo(0.25, 1e-9));
          // again (= X)
          final sqrtX01 = QCircuit(gateBuilder2).squareRootOfX({0, 1});
          sqrtX01.execute(qmem);
          probs = qmem.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(0, 1e-9));
          expect(probs['10'], closeTo(1, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
        });

        test('Controlled NOT (2-qubit register)', () {
          final ctrlX01 = QCircuit(gateBuilder2).not(1, controls: 0);
          // |00> => |00>
          var qmem = QMemorySpace([Qbit.zero, Qbit.zero]);
          ctrlX01.execute(qmem);
          var probs = qmem.probabilities;
          var sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(1, 1e-9));
          expect(probs['01'], closeTo(0, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
          // |01> => |01>
          qmem = QMemorySpace([Qbit.zero, Qbit.one]);
          ctrlX01.execute(qmem);
          probs = qmem.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(1, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
          // |10> => |11>
          qmem = QMemorySpace([Qbit.one, Qbit.zero]);
          ctrlX01.execute(qmem);
          probs = qmem.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(0, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(1, 1e-9));
          // |11> => |10>
          qmem = QMemorySpace([Qbit.one, Qbit.one]);
          ctrlX01.execute(qmem);
          probs = qmem.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(0, 1e-9));
          expect(probs['01'], closeTo(0, 1e-9));
          expect(probs['10'], closeTo(1, 1e-9));
          expect(probs['11'], closeTo(0, 1e-9));
        });

        test('Controlled NOT (2-qubit register with random control)', () {
          final control = Qbit.random();
          var qmem = QMemorySpace([control, Qbit.zero]);
          // cnot on 1 with control 0
          final ctrlX01 = QCircuit(gateBuilder2).not(1, controls: 0);
          ctrlX01.execute(qmem);
          var probs = qmem.probabilities;
          var sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo(control.ket0.det, 1e-9));
          expect(probs['01'], closeTo(0, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo(control.ket1.det, 1e-9));
          // measure control qubit (via register)
          final qubit = qmem[0];
          qmem.measure(qubits: {qubit.id});
          final qstate = qubit.state;
          probs = qmem.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(probs['00'], closeTo((qstate == '0') ? 1 : 0, 1e-9));
          expect(probs['01'], closeTo(0, 1e-9));
          expect(probs['10'], closeTo(0, 1e-9));
          expect(probs['11'], closeTo((qstate == '1') ? 1 : 0, 1e-9));
        });

        test('Controlled NOT (3-qubit register)', () {
          final crtlX02 = QCircuit(gateBuilder3).not(2, controls: 0);
          // |0?0> => |0?0>
          var qmem = QMemorySpace([Qbit.zero, Qbit.random(), Qbit.zero]);
          crtlX02.execute(qmem);
          var probs = qmem.probabilities;
          var sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(qmem.getPropability('0.0'), closeTo(1, 1e-9));
          expect(qmem.getPropability('0.1'), closeTo(0, 1e-9));
          expect(qmem.getPropability('1.0'), closeTo(0, 1e-9));
          expect(qmem.getPropability('1.1'), closeTo(0, 1e-9));
          // |0?1> => |0?1>
          qmem = QMemorySpace([Qbit.zero, Qbit.random(), Qbit.one]);
          crtlX02.execute(qmem);
          probs = qmem.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(qmem.getPropability('0.0'), closeTo(0, 1e-9));
          expect(qmem.getPropability('0.1'), closeTo(1, 1e-9));
          expect(qmem.getPropability('1.0'), closeTo(0, 1e-9));
          expect(qmem.getPropability('1.1'), closeTo(0, 1e-9));
          // |1?0> => |1?1>
          qmem = QMemorySpace([Qbit.one, Qbit.random(), Qbit.zero]);
          crtlX02.execute(qmem);
          probs = qmem.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(qmem.getPropability('0.0'), closeTo(0, 1e-9));
          expect(qmem.getPropability('0.1'), closeTo(0, 1e-9));
          expect(qmem.getPropability('1.0'), closeTo(0, 1e-9));
          expect(qmem.getPropability('1.1'), closeTo(1, 1e-9));
          // |1?1> => |1?0>
          qmem = QMemorySpace([Qbit.one, Qbit.random(), Qbit.one]);
          crtlX02.execute(qmem);
          probs = qmem.probabilities;
          sum = probs.values.fold<double>(0, (s, p) => s + p);
          expect(sum, closeTo(1, 1e-9));
          expect(qmem.getPropability('0.0'), closeTo(0, 1e-9));
          expect(qmem.getPropability('0.1'), closeTo(0, 1e-9));
          expect(qmem.getPropability('1.0'), closeTo(1, 1e-9));
          expect(qmem.getPropability('1.1'), closeTo(0, 1e-9));
        });
      });
    });

    group('Circuit composition', () {
      test('2 NOTs', () {
        final qmem = QMemorySpace.zero(2);
        final qa = qmem.createRegister('a', at: 0);
        final notCircuit = QCircuit(gateBuilder2);
        notCircuit.not(qa);
        final circuit = QCircuit(gateBuilder2);
        circuit.append(notCircuit);
        circuit.append(notCircuit);
        expect(circuit.gates.length, equals(2));
        qmem.initialize({qa: 1});
        var probs = qmem.probabilities;
        var sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(0, 1e-9));
        expect(probs['01'], closeTo(0, 1e-9));
        expect(probs['10'], closeTo(1, 1e-9));
        expect(probs['11'], closeTo(0, 1e-9));
        circuit.execute(qmem);
        probs = qmem.probabilities;
        sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['00'], closeTo(0, 1e-9));
        expect(probs['01'], closeTo(0, 1e-9));
        expect(probs['10'], closeTo(1, 1e-9));
        expect(probs['11'], closeTo(0, 1e-9));
        final a = qa.read();
        expect(a, equals(1));
      });

      test('dagger', () {
        final qmem = QMemorySpace.zero(3);
        final bloc = QCircuit(gateBuilder3);
        bloc.hadamard({1, 0});
        bloc.not(1, controls: 0);
        bloc.rotationX(math.pi / 7, {0, 1, 2});

        final circuit = QCircuit(gateBuilder3);
        circuit.append(bloc);
        expect(circuit.gates.length, equals(3));
        circuit.append(bloc, dagger: true);
        expect(circuit.gates.length, equals(6));

        circuit.execute(qmem);

        var probs = qmem.probabilities;
        var sum = probs.values.fold<double>(0, (s, p) => s + p);
        expect(sum, closeTo(1, 1e-9));
        expect(probs['000'], closeTo(1, 1e-9));
      });
    });

    test('Circuit observer', () {
      final qmem = QMemorySpace.zero(3);
      final bloc = QCircuit(gateBuilder3);
      bloc.hadamard({1, 0});
      bloc.not(1, controls: 0);
      bloc.rotationX(math.pi / 7, {0, 1, 2});

      final circuit = QCircuit(gateBuilder3);
      circuit.append(bloc);
      expect(circuit.gates.length, equals(3));
      circuit.separation(label: 'middle');
      expect(circuit.gates.length, equals(4));
      circuit.append(bloc, dagger: true);
      expect(circuit.gates.length, equals(7));

      var seen = 0;
      circuit.addObserver((step, gate, qmem) {
        if (step == 0) {
          expect(gate, isNull);
        } else if (step == 4) {
          expect(gate!.label, equals('middle'));
        } else if (step > 4) {
          expect(gate!.label, contains('(inverse)'));
        }
        expect(seen, equals(step));
        seen++;
      });

      expect(seen, isZero);
      circuit.execute(qmem);
      expect(seen, equals(circuit.gates.length + 1));

      var probs = qmem.probabilities;
      var sum = probs.values.fold<double>(0, (s, p) => s + p);
      expect(sum, closeTo(1, 1e-9));
      expect(probs['000'], closeTo(1, 1e-9));
    });
  });
}
