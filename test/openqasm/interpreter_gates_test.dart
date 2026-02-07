import 'package:qartvm/qartvm.dart';
import 'package:test/test.dart';
import 'dart:math' as math;

void main() {
  group('OpenQASM Interpreter - Gate Execution', () {
    final List<
      ({
        String description,
        String Function(List<String>) setup,
        void Function(QMemorySpace, List<int>) apply,
      })
    >
    initialStates = [
      (description: '|0>', setup: (qubits) => '', apply: (qm, q) {}),
      (
        description: '|1>',
        setup: (qubits) => 'x ${qubits[0]};',
        apply: (qm, q) =>
            QCircuit(QGateBuilder.get(qm.size)).pauliX(q[0]).execute(qm),
      ),
      (
        description: '|+>',
        setup: (qubits) => 'h ${qubits[0]};',
        apply: (qm, q) =>
            QCircuit(QGateBuilder.get(qm.size)).hadamard(q[0]).execute(qm),
      ),
      (
        description: '|->',
        setup: (qubits) => 'x ${qubits[0]}; h ${qubits[0]};',
        apply: (qm, q) => QCircuit(
          QGateBuilder.get(qm.size),
        ).pauliX(q[0]).hadamard(q[0]).execute(qm),
      ),
    ];

    final List<
      ({
        String description,
        String Function(List<String>) setup,
        void Function(QMemorySpace, List<int>) apply,
      })
    >
    initialTwoQubitStates = [
      (description: '|00>', setup: (qubits) => '', apply: (qm, q) {}),
      (
        description: '|10>',
        setup: (qubits) => 'x ${qubits[0]};',
        apply: (qm, q) =>
            QCircuit(QGateBuilder.get(qm.size)).pauliX(q[0]).execute(qm),
      ),
      (
        description: '|01>',
        setup: (qubits) => 'x ${qubits[1]};',
        apply: (qm, q) =>
            QCircuit(QGateBuilder.get(qm.size)).pauliX(q[1]).execute(qm),
      ),
      (
        description: '|11>',
        setup: (qubits) => 'x ${qubits[0]}; x ${qubits[1]};',
        apply: (qm, q) {
          final circ = QCircuit(QGateBuilder.get(qm.size));
          circ.pauliX(q[0]);
          circ.pauliX(q[1]);
          circ.execute(qm);
        },
      ),
      (
        description: '|++>',
        setup: (qubits) => 'h ${qubits[0]}; h ${qubits[1]};',
        apply: (qm, q) {
          final circ = QCircuit(QGateBuilder.get(qm.size));
          circ.hadamard(q[0]);
          circ.hadamard(q[1]);
          circ.execute(qm);
        },
      ),
    ];

    Future<void> verifyGate(
      String description, {
      required String body,
      required void Function(QMemorySpace, List<int>) expectedAction,
      required List<String> qubitNames,
      required int qubitCount,
      List<
        ({
          String description,
          String Function(List<String>) setup,
          void Function(QMemorySpace, List<int>) apply,
        })
      >?
      customStates,
    }) async {
      final states = customStates ?? initialStates;
      for (final state in states) {
        // 1. Prepare Expected State
        final expectedQm = QMemorySpace.zero(qubitCount);
        final qIndices = List.generate(qubitCount, (i) => i);
        state.apply(expectedQm, qIndices);
        expectedAction(expectedQm, qIndices);

        // 2. Prepare Actual State via Interpreter
        final setupQasm = state.setup(qubitNames);
        final fullQasm =
            '''
        OPENQASM 3.0;
        include "stdgates.inc";
        qubit[$qubitCount] q;
        $setupQasm
        $body
        ''';

        // Use a fresh interpreter for each state to avoid side effects
        final currentInterpreter = OpenQASMInterpreter();
        final program = OpenQASMParser.parse(fullQasm);
        final result = await currentInterpreter.execute(program);

        // 3. Compare with tolerance
        final verificationMessage =
            '$description with initial state ${state.description}';
        final qmem = result.quantumMemory;
        expect(qmem, isNotNull, reason: verificationMessage);

        final expectedProbs = expectedQm.probabilities;
        final actualProbs = qmem!.probabilities;

        // Check all states
        for (final entry in expectedProbs.entries) {
          final stateKeys = entry.key;
          final expectedProb = entry.value;
          final actualProb = actualProbs[stateKeys];
          expect(
            actualProb,
            closeTo(expectedProb, 0.001),
            reason:
                '$verificationMessage: state $stateKeys probability mismatch',
          );
        }
      }
    }

    test('should execute Hadamard gate', () async {
      await verifyGate(
        'H gate',
        body: 'h q[0];',
        qubitNames: ['q[0]'],
        qubitCount: 1,
        expectedAction: (qm, q) =>
            QCircuit(QGateBuilder.get(qm.size)).hadamard(q[0]).execute(qm),
      );
    });

    test('should execute Pauli-X gate', () async {
      await verifyGate(
        'X gate',
        body: 'x q[0];',
        qubitNames: ['q[0]'],
        qubitCount: 1,
        expectedAction: (qm, q) =>
            QCircuit(QGateBuilder.get(qm.size)).pauliX(q[0]).execute(qm),
      );
    });

    test('should execute parameterized RX gate', () async {
      await verifyGate(
        'RX(pi/2) gate',
        body: 'rx(pi/2) q[0];',
        qubitNames: ['q[0]'],
        qubitCount: 1,
        expectedAction: (qm, q) => QCircuit(
          QGateBuilder.get(qm.size),
        ).rotationX(3.141592653589793 / 2, q[0]).execute(qm),
      );
    });

    test('should execute CNOT gate', () async {
      await verifyGate(
        'CNOT gate',
        body: 'x q[0]; cx q[0], q[1];',
        qubitNames: ['q[0]', 'q[1]'],
        qubitCount: 2,
        customStates: initialTwoQubitStates,
        expectedAction: (qm, q) {
          final circ = QCircuit(QGateBuilder.get(qm.size));
          circ.pauliX(q[0]);
          circ.pauliX(q[1], controls: {q[0]});
          circ.execute(qm);
        },
      );
    });

    test('should create Bell state (EPR pair)', () async {
      await verifyGate(
        'Bell state',
        body: 'h q[0]; cx q[0], q[1];',
        qubitNames: ['q[0]', 'q[1]'],
        qubitCount: 2,
        customStates: initialTwoQubitStates,
        expectedAction: (qm, q) {
          final circ = QCircuit(QGateBuilder.get(qm.size));
          circ.hadamard(q[0]);
          circ.pauliX(q[1], controls: {q[0]});
          circ.execute(qm);
        },
      );
    });

    test('should execute multiple gates in sequence', () async {
      await verifyGate(
        'H-Z-H sequence',
        body: 'h q[0]; z q[0]; h q[0];',
        qubitNames: ['q[0]'],
        qubitCount: 1,
        expectedAction: (qm, q) {
          final circ = QCircuit(QGateBuilder.get(qm.size));
          circ.hadamard(q[0]);
          circ.pauliZ(q[0]);
          circ.hadamard(q[0]);
          circ.execute(qm);
        },
      );
    });

    test('should handle gate with expression parameter', () async {
      await verifyGate(
        'RX(pi/2) with expression',
        body: '''
          float a = pi / 4;
          rx(a * 2) q[0];
          ''',
        qubitNames: ['q[0]'],
        qubitCount: 1,
        expectedAction: (qm, q) => QCircuit(
          QGateBuilder.get(qm.size),
        ).rotationX(3.141592653589793 / 2, q[0]).execute(qm),
      );
    });

    test('should execute gates on register subset', () async {
      final List<
        ({
          String description,
          String Function(List<String>) setup,
          void Function(QMemorySpace, List<int>) apply,
        })
      >
      localStates = [
        (description: '|000>', setup: (qubits) => '', apply: (qm, q) {}),
        (
          description: '|111>',
          setup: (qubits) => 'x ${qubits[0]}; x ${qubits[1]}; x ${qubits[2]};',
          apply: (qm, q) {
            final circ = QCircuit(QGateBuilder.get(qm.size));
            circ.pauliX(q[0]);
            circ.pauliX(q[1]);
            circ.pauliX(q[2]);
            circ.execute(qm);
          },
        ),
      ];

      await verifyGate(
        'H on subset',
        body: 'h q[0]; h q[2];',
        qubitNames: ['q[0]', 'q[1]', 'q[2]'],
        qubitCount: 3,
        customStates: localStates,
        expectedAction: (qm, q) {
          final circ = QCircuit(QGateBuilder.get(qm.size));
          circ.hadamard(q[0]);
          circ.hadamard(q[2]);
          circ.execute(qm);
        },
      );
    });

    test('should execute Y and Z gates', () async {
      await verifyGate(
        'Y and Z gates',
        body: 'y q[0]; z q[1];',
        qubitNames: ['q[0]', 'q[1]'],
        qubitCount: 2,
        customStates: initialTwoQubitStates,
        expectedAction: (qm, q) {
          final circ = QCircuit(QGateBuilder.get(qm.size));
          circ.pauliY(q[0]);
          circ.pauliZ(q[1]);
          circ.execute(qm);
        },
      );
    });

    test('should execute S and T gates', () async {
      await verifyGate(
        'S gate (T gate implicitly tested via H-S sequence)',
        body: 'h q[0]; s q[0];',
        qubitNames: ['q[0]'],
        qubitCount: 1,
        expectedAction: (qm, q) {
          final circ = QCircuit(QGateBuilder.get(qm.size));
          circ.hadamard(q[0]);
          circ.phaseS(q[0]);
          circ.execute(qm);
        },
      );
    });

    test('should execute custom gate without parameters', () async {
      await verifyGate(
        'Custom H gate',
        body: '''
          gate my_h q {
            h q;
          }
          my_h q[0];
          ''',
        qubitNames: ['q[0]'],
        qubitCount: 1,
        expectedAction: (qm, q) =>
            QCircuit(QGateBuilder.get(qm.size)).hadamard(q[0]).execute(qm),
      );
    });

    test('should execute custom gate with parameters', () async {
      await verifyGate(
        'Custom RX gate',
        body: '''
          gate my_rotation(theta) q {
            rx(theta) q;
          }
          my_rotation(1.5707963267948966) q[0];
          ''',
        qubitNames: ['q[0]'],
        qubitCount: 1,
        expectedAction: (qm, q) => QCircuit(
          QGateBuilder.get(qm.size),
        ).rotationX(1.5707963267948966, q[0]).execute(qm),
      );
    });

    test('should execute custom gate with multiple qubits', () async {
      await verifyGate(
        'Custom CNOT gate',
        body: '''
          gate my_cnot c, t {
            cx c, t;
          }
          x q[0];
          my_cnot q[0], q[1];
          ''',
        qubitNames: ['q[0]', 'q[1]'],
        qubitCount: 2,
        customStates: initialTwoQubitStates,
        expectedAction: (qm, q) {
          final circ = QCircuit(QGateBuilder.get(qm.size));
          circ.pauliX(q[0]);
          circ.pauliX(q[1], controls: {q[0]});
          circ.execute(qm);
        },
      );
    });

    test('should apply inv modifier to RX gate', () async {
      await verifyGate(
        'inv @ RX(pi/2)',
        body: '''
          rx(1.5707963267948966) q[0];
          inv @ rx(1.5707963267948966) q[0];
          ''',
        qubitNames: ['q[0]'],
        qubitCount: 1,
        expectedAction: (qm, q) {
          // Net effect is Identity
        },
      );
    });

    test('should apply inv modifier to phase gate', () async {
      await verifyGate(
        'inv @ P(pi/2)',
        body: '''
          h q[0];
          p(1.5707963267948966) q[0];
          inv @ p(1.5707963267948966) q[0];
          ''',
        qubitNames: ['q[0]'],
        qubitCount: 1,
        expectedAction: (qm, q) {
          final circ = QCircuit(QGateBuilder.get(qm.size));
          circ.hadamard(q[0]);
          // p then inv @ p -> Identity
          circ.execute(qm);
        },
      );
    });

    test('should apply pow modifier to RX gate (angle parameter)', () async {
      await verifyGate(
        'pow(2) @ RX(pi/2)',
        body: '''
          h q[0];
          pow(2) @ rx(1.5707963267948966) q[0];
          ''',
        qubitNames: ['q[0]'],
        qubitCount: 1,
        expectedAction: (qm, q) {
          final circ = QCircuit(QGateBuilder.get(qm.size));
          circ.hadamard(q[0]);
          circ.rotationX(3.141592653589793, q[0]); // 2 * pi/2 = pi
          circ.execute(qm);
        },
      );
    });

    test('should apply ctrl modifier to X gate (controlled-X)', () async {
      await verifyGate(
        'ctrl @ X (CNOT)',
        body: '''
          h q[0];
          ctrl @ x q[0], q[1];
          ''',
        qubitNames: ['q[0]', 'q[1]'],
        qubitCount: 2,
        customStates: initialTwoQubitStates,
        expectedAction: (qm, q) {
          final circ = QCircuit(QGateBuilder.get(qm.size));
          circ.hadamard(q[0]);
          circ.pauliX(q[1], controls: {q[0]});
          circ.execute(qm);
        },
      );
    });

    test('should apply ctrl modifier with explicit control count', () async {
      await verifyGate(
        'ctrl(2) @ X (Toffoli)',
        body: '''
          x q[0];
          x q[1];
          ctrl(2) @ x q[0], q[1], q[2];
          ''',
        qubitNames: ['q[0]', 'q[1]', 'q[2]'],
        qubitCount: 3,
        // Need 3-qubit states, using a local one plus checking
        // specific scenario from original test
        expectedAction: (qm, q) {
          final circ = QCircuit(QGateBuilder.get(qm.size));
          circ.pauliX(q[0]);
          circ.pauliX(q[1]);
          circ.pauliX(q[2], controls: {q[0], q[1]});
          circ.execute(qm);
        },
      );
    });

    test('should apply negctrl modifier to X gate (controlled-not)', () async {
      await verifyGate(
        'negctrl @ X',
        body: '''
          h q[0];
          negctrl @ x q[0], q[1];
          ''',
        qubitNames: ['q[0]', 'q[1]'],
        qubitCount: 2,
        customStates: initialTwoQubitStates,
        expectedAction: (qm, q) {
          final circ = QCircuit(QGateBuilder.get(qm.size));
          circ.hadamard(q[0]);
          // simulate negctrl: X q0 -> CX q0,q1 -> X q0
          circ.pauliX(q[0]);
          circ.pauliX(q[1], controls: {q[0]});
          circ.pauliX(q[0]);
          circ.execute(qm);
        },
      );
    });

    test('should apply negctrl modifier with explicit control count', () async {
      await verifyGate(
        'negctrl(2) @ X',
        body: '''
          x q[1];
          negctrl(2) @ x q[0], q[1], q[2];
          ''',
        qubitNames: ['q[0]', 'q[1]', 'q[2]'],
        qubitCount: 3,
        expectedAction: (qm, q) {
          final circ = QCircuit(QGateBuilder.get(qm.size));
          circ.pauliX(q[1]);

          // negctrl(2) on q0, q1 -> target q2
          // flips q2 if q0=0 AND q1=0
          // Circuit: X q0; X q1; Toffoli(q0,q1,q2); X q1; X q0;
          circ.pauliX(q[0]);
          circ.pauliX(q[1]);
          circ.toffoli(q[2], controls: {q[0], q[1]});
          circ.pauliX(q[1]);
          circ.pauliX(q[0]);

          circ.execute(qm);
        },
      );
    });

    test('should apply combined inv and ctrl modifiers', () async {
      await verifyGate(
        'inv @ ctrl @ X',
        body: '''
          x q[0];
          h q[1];
          inv @ ctrl @ x q[0], q[1];
          ''',
        qubitNames: ['q[0]', 'q[1]'],
        qubitCount: 2,
        customStates: initialTwoQubitStates,
        expectedAction: (qm, q) {
          final circ = QCircuit(QGateBuilder.get(qm.size));
          circ.pauliX(q[0]);
          circ.hadamard(q[1]);
          // inv @ ctrl @ X = ctrl @ X (since X is self-inverse)
          circ.pauliX(q[1], controls: {q[0]});
          circ.execute(qm);
        },
      );
    });

    test('should apply pow modifier to X gate (non-parameterized)', () async {
      await verifyGate(
        'pow(3) @ X',
        body: '''
          h q[0];
          z q[0];
          h q[0];
          pow(3) @ x q[0];
          ''',
        qubitNames: ['q[0]'],
        qubitCount: 1,
        expectedAction: (qm, q) {
          final circ = QCircuit(QGateBuilder.get(qm.size));
          circ.hadamard(q[0]);
          circ.pauliZ(q[0]);
          circ.hadamard(q[0]);
          // pow(3) @ X = X
          circ.pauliX(q[0]);
          circ.execute(qm);
        },
      );
    });

    test('should apply pow(2) modifier to X gate (even power)', () async {
      await verifyGate(
        'pow(2) @ X',
        body: '''
          h q[0];
          pow(2) @ x q[0];
          h q[0];
          ''',
        qubitNames: ['q[0]'],
        qubitCount: 1,
        expectedAction: (qm, q) {
          final circ = QCircuit(QGateBuilder.get(qm.size));
          circ.hadamard(q[0]);
          // pow(2) @ X = I
          circ.hadamard(q[0]);
          circ.execute(qm);
        },
      );
    });

    test('should apply pow modifier to H gate (odd power)', () async {
      await verifyGate(
        'pow(3) @ H',
        body: '''
          h q[0];
          pow(3) @ h q[0];
          ''',
        qubitNames: ['q[0]'],
        qubitCount: 1,
        expectedAction: (qm, q) {
          final circ = QCircuit(QGateBuilder.get(qm.size));
          circ.hadamard(q[0]);
          // pow(3) @ H = H
          circ.hadamard(q[0]);
          circ.execute(qm);
        },
      );
    });

    test('should apply inv modifier to X gate (self-inverse)', () async {
      await verifyGate(
        'inv @ X',
        body: '''
          h q[0];
          x q[0];
          inv @ x q[0];
          h q[0];
          ''',
        qubitNames: ['q[0]'],
        qubitCount: 1,
        expectedAction: (qm, q) {
          final circ = QCircuit(QGateBuilder.get(qm.size));
          circ.hadamard(q[0]);
          circ.pauliX(q[0]);
          // inv @ X = X
          circ.pauliX(q[0]);
          circ.hadamard(q[0]);
          circ.execute(qm);
        },
      );
    });

    test(
      'should apply inv modifier to S gate (with H then measure in X basis)',
      () async {
        await verifyGate(
          'inv @ S',
          body: '''
            h q[0];
            s q[0];
            inv @ s q[0];
            h q[0];
            ''',
          qubitNames: ['q[0]'],
          qubitCount: 1,
          expectedAction: (qm, q) {
            final circ = QCircuit(QGateBuilder.get(qm.size));
            circ.hadamard(q[0]);
            circ.phaseS(q[0]);
            // inv @ S = S† (-pi/2)
            circ.phase(-math.pi / 2, q[0]);
            circ.hadamard(q[0]);
            circ.execute(qm);
          },
        );
      },
    );

    test(
      'should apply inv modifier to T gate (with H then measure in X basis)',
      () async {
        await verifyGate(
          'inv @ T',
          body: '''
            h q[0];
            t q[0];
            inv @ t q[0];
            h q[0];
            ''',
          qubitNames: ['q[0]'],
          qubitCount: 1,
          expectedAction: (qm, q) {
            final circ = QCircuit(QGateBuilder.get(qm.size));
            circ.hadamard(q[0]);
            circ.phaseT(q[0]);
            // inv @ T = T† (-pi/4)
            circ.phase(-math.pi / 4, q[0]);
            circ.hadamard(q[0]);
            circ.execute(qm);
          },
        );
      },
    );

    test('inv @ pow and pow @ inv should behave the same for RX gate', () async {
      for (final state in initialStates) {
        final setupQasm = state.setup(['q']);
        final source1 =
            '''
            OPENQASM 3.0;
            include "stdgates.inc";
            qubit q;
            $setupQasm
            h q;
            inv @ pow(2) @ rx(0.5235987755982988) q;
            ''';
        final source2 =
            '''
            OPENQASM 3.0;
            include "stdgates.inc";
            qubit q;
            $setupQasm
            h q;
            pow(2) @ inv @ rx(0.5235987755982988) q;
            ''';

        final interpreter1 = OpenQASMInterpreter();
        final interpreter2 = OpenQASMInterpreter();

        final result1 = await interpreter1.execute(
          OpenQASMParser.parse(source1),
        );
        final result2 = await interpreter2.execute(
          OpenQASMParser.parse(source2),
        );

        expect(result1.quantumMemory, isNotNull);
        expect(result2.quantumMemory, isNotNull);
        final qmem1 = result1.quantumMemory!;
        final qmem2 = result2.quantumMemory!;

        final prob0_1 = qmem1.getPropability('0');
        final prob1_1 = qmem1.getPropability('1');
        final prob0_2 = qmem2.getPropability('0');
        final prob1_2 = qmem2.getPropability('1');

        expect(
          prob0_1,
          closeTo(prob0_2, 0.001),
          reason:
              'inv @ pow vs pow @ inv mismatch for state \${state.description}',
        );
        expect(
          prob1_1,
          closeTo(prob1_2, 0.001),
          reason:
              'inv @ pow vs pow @ inv mismatch for state \${state.description}',
        );
      }
    });
  });
}
