import 'dart:math' as math;

import 'package:qartvm/qartvm.dart';

import 'utils.dart';

void main() {
  // 3-qubit adder for a (in 0..8) + b (in 0..7)
  // computes a+b mod 16 if a > 8
  //
  //              -----                                                                                                                                -----------    ---------
  //  0 = a0 ----| QFT |------------------------------------------------------------------------------------------------------------------------------| P(1.0 pi) |--| INV-QFT |----  --> (a+b)0
  //             |     |                                                                                                                               -----------   |         |
  //             |     |                                                                                                 -----------    -----------                  |         |
  //  1 = a1 ----| QFT |------------------------------------------------------------------------------------------------| P(1.0 pi) |--| P(0.5 pi) |-----------------| INV-QFT |----  --> (a+b)1
  //             |     |                                                                                                 -----------    -----------                  |         |
  //             |     |                                                   -----------    -----------    ------------                                                |         |
  //  2 = a2 ----| QFT |--------------------------------------------------| P(1.0 pi) |--| P(0.5 pi) |--| P(0.25 pi) |-----------------------------------------------| INV-QFT |----  --> (a+b)2
  //             |     |                                                   -----------    -----------    ------------                                                |         |
  //             |     |   -----------    ------------    -------------                                                                                              |         |
  //  3 = a3 ----| QFT |--| P(0.5 pi) |--| P(0.25 pi) |--| P(0.125 pi) |---------------------------------------------------------------------------------------------| INV-QFT |----  --> (a+b)3
  //              -----    -----------    ------------    -------------                                                                                               ---------
  //
  //  4 = b0 -------------------------------------------------- X ------------------------------------------- X ---------------------------- X ------------ X ----------------------  --> b0
  //
  //  5 = b1 --------------------------------- X --------------------------------------------- X ---------------------------- X ----------------------------------------------------  --> b1
  //
  //  6 = b2 ------------------ X --------------------------------------------- X --------------------------------------------------------------------------------------------------  --> b2

  // qubit #   =  input bit /  result bit
  //    0      =      a0    /    (a+b)0
  //    1      =      a1    /    (a+b)1
  //    2      =      a2    /    (a+b)2
  //    3      =      a3    /    (a+b)3 (carry)
  //    4      =      b0    /      b0
  //    5      =      b1    /      b1
  //    6      =      b2    /      b2
  //    7      =      |0>                           (suppressed as this qubit is useless)

  final qmem = QMemorySpace.zero(7);
  final qa = qmem.createRegister('qa', addresses: [3, 2, 1, 0]);
  final qb = qmem.createRegister('qb', addresses: [6, 5, 4]);

  final gateBuilder = QGateBuilder.get(qmem.size, withCache: true);
  final circuit = QCircuit(gateBuilder);

  circuit.qft([3, 2, 1, 0]);

  // circuit.phase(math.pi, 3, controls: 7); // suppressed because qubit 7 is always |0>
  circuit.phase(math.pi / 2, 3, controls: 6);
  circuit.phase(math.pi / 4, 3, controls: 5);
  circuit.phase(math.pi / 8, 3, controls: 4);

  circuit.phase(math.pi, 2, controls: 6);
  circuit.phase(math.pi / 2, 2, controls: 5);
  circuit.phase(math.pi / 4, 2, controls: 4);

  circuit.phase(math.pi, 1, controls: 5);
  circuit.phase(math.pi / 2, 1, controls: 4);

  circuit.phase(math.pi, 0, controls: 4);

  circuit.invQft([3, 2, 1, 0]);

  circuit.addObserver((step, gate, qmem) {
    if (step == 0) {
      print('INITIAL STATE: ${probInfo(qmem)}');
    }
  });

  describe(circuit);
  draw(circuit, qmem: qmem);

  final sw = Stopwatch();

  sw.start();
  verifyAddition(circuit, qmem, qa, qb);
  sw.stop();
  print(
      'Completed in ${sw.elapsed} before compilation, total executions = $_nbExec (${sw.elapsedMicroseconds / _nbExec} µs/execution)');

  circuit.compile();

  describe(circuit);
  draw(circuit, qmem: qmem);

  sw.reset();
  sw.start();
  verifyAddition(circuit, qmem, qa, qb);
  sw.stop();
  print(
      'Completed in ${sw.elapsed} after compilation, total executions = $_nbExec (${sw.elapsedMicroseconds / _nbExec} µs/execution)');
}

int _nbExec = 0;

void verifyAddition(
    QCircuit circuit, QMemorySpace qmem, QRegister qa, QRegister qb) {
  _nbExec = 0;

  // truth table
  // a can actually be in 0..8 as there will be no carry when adding b in 0..7
  for (var a = 0; a <= 15; a++) {
    for (var b = 0; b <= 7; b++) {
      final results = <int, int>{};
      for (var i = 0; i < 100; i++) {
        qmem.initialize({
          qa: a,
          qb: b,
        });

        circuit.execute(qmem);
        _nbExec++;
        final n = qa.read();
        results[n] = results.putIfAbsent(n, () => 0) + 1;
      }

      print('[$a/$b] Outcome: $a + $b = $results');
    }
  }

  Qbit qrnd() => Qbit.random();

  // random checks
  for (var i = 0; i < 10000; i++) {
    qmem.initialize({
      qa: [qrnd(), qrnd(), qrnd(), qrnd()],
      qb: [qrnd(), qrnd(), qrnd()],
    });

    // read value of a before execution (this will collapse the register's qubits #0-#3 states)
    final a = qa.read();

    circuit.execute(qmem);
    _nbExec++;

    // read values of b and sum after execution
    final b = qb.read();
    final sum = qa.read();
    if (sum != (a + b) % 16) {
      throw Exception('Invalid sum $sum for $a + $b');
    }
  }
}
