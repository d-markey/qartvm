import 'dart:math' as math;

import 'package:qartvm/qartvm.dart';

import 'utils.dart';

void main() {
  // 2-qubit adder for a (in 0..4) + b (in 0..3)
  // computes a+b mod 8 if a > 4
  //
  //              -----                                                                 -----------    ---------
  //  0 = a0 ----| QFT |---------------------------------------------------------------| P(1.0 pi) |--| INV-QFT |----  = (a+b)0
  //             |     |                                                                -----------   |         |
  //             |     |                                  -----------    -----------                  |         |
  //  1 = a1 ----| QFT |---------------------------------| P(1.0 pi) |--| P(0.5 pi) |-----------------| INV-QFT |----  = (a+b)1
  //             |     |                                  -----------    -----------                  |         |
  //             |     |   -----------    ------------                                                |         |
  //  2 = a2 ----| QFT |--| P(0.5 pi) |--| P(0.25 pi) |-----------------------------------------------| INV-QFT |----  = (a+b)2
  //              -----    -----------    ------------                                                 ---------
  //
  //  3 = b1 --------------------------------- X ---------------------------- X ------------ X ----------------------  = b1
  //
  //  4 = b2 ------------------ X ---------------------------- X ----------------------------------------------------  = b2
  //

  // qubit #   =  input bit /  result bit
  //    0      =      a0    /    (a+b)0
  //    1      =      a1    /    (a+b)1
  //    2      =      a2    /    (a+b)2 (carry)
  //    3      =      b0    /      b0
  //    4      =      b1    /      b1
  //    5      =      |0>                           (suppressed as this qubit is useless)
  final circuit = QCircuit(size: 5);

  circuit.qft([2, 1, 0]);

  // circuit.phase(math.pi, 2, controls: 5); // suppressed because qubit 5 is always |0>
  circuit.phase(math.pi / 2, 2, controls: 4);
  circuit.phase(math.pi / 4, 2, controls: 3);

  circuit.phase(math.pi, 1, controls: 4);
  circuit.phase(math.pi / 2, 1, controls: 3);

  circuit.phase(math.pi, 0, controls: 3);

  circuit.invQft([2, 1, 0]);

  describe(circuit);
  draw(circuit);

  final sw = Stopwatch();

  sw.start();
  verifyAddition(circuit);
  sw.stop();
  print(
      'Completed in ${sw.elapsed} before compilation, total executions = $_nbExec (${sw.elapsedMicroseconds.toDouble() / _nbExec} µs/execution)');

  circuit.compile();

  describe(circuit);
  draw(circuit);

  sw.reset();
  sw.start();
  verifyAddition(circuit);
  sw.stop();
  print(
      'Completed in ${sw.elapsed} after compilation, total executions = $_nbExec (${sw.elapsedMicroseconds.toDouble() / _nbExec} µs/execution)');
}

int _nbExec = 0;

void verifyAddition(QCircuit circuit) {
  _nbExec = 0;

  // truth table
  // a can actually be in 0..4 as there will be no carry when adding b in 0..3
  for (var a = 0; a <= 7; a++) {
    for (var b = 0; b <= 3; b++) {
      final results = <int, int>{};
      for (var i = 0; i < 100; i++) {
        final qreg = QRegister(
            [...Qbit.fromInt(a, count: 3), ...Qbit.fromInt(b, count: 2)]);

        circuit.execute(qreg);
        _nbExec++;

        final n = qreg.read(qubits: [2, 1, 0]);
        results[n] = results.putIfAbsent(n, () => 0) + 1;
      }

      print('[$a/$b] Outcome: $a + $b = $results');
    }
  }

  Qbit qrnd() => Qbit.random();

  // random checks
  for (var i = 0; i < 10000; i++) {
    final rndQreg = QRegister([qrnd(), qrnd(), qrnd(), qrnd(), qrnd()]);

    // read value of a before execution (this will collapse the register's qubits #0-#2 states)
    final a = rndQreg.read(qubits: [2, 1, 0]);

    circuit.execute(rndQreg);
    _nbExec++;

    // read values of b and sum after execution
    final b = rndQreg.read(qubits: [4, 3]);
    final sum = rndQreg.read(qubits: [2, 1, 0]);
    if (sum != (a + b) % 8) {
      throw Exception('Invalid sum $sum for $a + $b');
    }
  }
}
