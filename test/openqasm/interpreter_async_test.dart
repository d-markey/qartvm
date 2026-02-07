import 'dart:async';
import 'package:qartvm/src/openqasm/openqasm_interpreter.dart';
import 'package:qartvm/src/openqasm/openqasm_parser.dart';
import 'package:qartvm/src/qmemory_space.dart';
import 'package:test/test.dart';

void main() {
  group('OpenQASM Interpreter Async', () {
    late OpenQASMInterpreter interpreter;

    setUp(() {
      interpreter = OpenQASMInterpreter();
    });

    test('Standard execution works asynchronously', () async {
      final program = OpenQASMParser.parse('''
        OPENQASM 3.0;
        include "stdgates.inc";
        qubit[2] q;
        bit[2] c;
        h q[0];
        cx q[0], q[1];
        c[0] = measure q[0];
        c[1] = measure q[1];
      ''');

      final result = await interpreter.execute(program);

      expect(result.quantumMemory, isNotNull);
      expect(result.quantumMemory!.size, equals(2));
      expect(result.classicalVariables.containsKey('c'), isTrue);
    });

    test('Observer receives notifications', () async {
      final program = OpenQASMParser.parse('''
        OPENQASM 3.0;
        include "stdgates.inc";
        qubit[1] q;
        x q[0];
      ''');

      int stepCount = 0;
      int notificationCount = 0;

      interpreter.addObserver((step, stmt, qmem) {
        expect(step, equals(stepCount));
        expect(qmem, isA<QMemorySpaceView>());

        stepCount++;
        notificationCount++;
      });

      await interpreter.execute(program);

      expect(notificationCount, greaterThan(0));
    });

    test('Async observer waits for completion', () async {
      final program = OpenQASMParser.parse('''
        OPENQASM 3.0;
        qubit[1] q;
      ''');

      final executionOrder = <String>[];

      interpreter.addObserver((step, stmt, qmem) async {
        executionOrder.add('start_observer_$step');
        await Future.delayed(Duration(milliseconds: 10));
        executionOrder.add('end_observer_$step');
      });

      await interpreter.execute(program);

      // We expect start/end pairs to be sequential because the interpreter awaits the observer
      expect(
        executionOrder.join(','),
        contains('start_observer_0,end_observer_0'),
      );
    });

    test('Observer sees state changes', () async {
      final program = OpenQASMParser.parse('''
        OPENQASM 3.0;
        include "stdgates.inc";
        qubit[1] q;
        x q[0];
        barrier q;
      ''');

      bool sawOne = false;

      interpreter.addObserver((step, stmt, qmem) {
        // We use barrier to ensure we see the state after X has executed
        if (qmem.probabilities['1'] == 1.0) {
          sawOne = true;
        }
      });

      await interpreter.execute(program);
      expect(sawOne, isTrue);
    });
  });
}
