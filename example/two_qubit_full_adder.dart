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

  final qmem = QMemorySpace.zero(5);
  final qa = qmem.createRegister('a', addresses: [2, 1, 0]);
  final qb = qmem.createRegister('b', addresses: [4, 3]);

  final gateBuilder = QGateBuilder.get(qmem.size);

  final circuit = QCircuit(gateBuilder);

  circuit.qft(qa);
  final qft = circuit.gates.last.matrix!;

  // circuit.phase(math.pi, 2, controls: 5); // suppressed because qubit 5 is always |0>
  circuit.phase(math.pi / 2, 2, controls: 4);
  circuit.phase(math.pi / 4, 2, controls: 3);

  circuit.phase(math.pi, 1, controls: 4);
  circuit.phase(math.pi / 2, 1, controls: 3);

  circuit.phase(math.pi, 0, controls: 3);

  circuit.invQft(qa);
  final invqft = circuit.gates.last.matrix!;

  print((qft).toStringIndent(hideZeroes: true));
  print((invqft).toStringIndent(hideZeroes: true));
  print((qft * invqft).toStringIndent(hideZeroes: true));

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
  draw(circuit);

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
  // a can actually be in 0..4 as there will be no carry when adding b in 0..3
  for (var a = 0; a <= 7; a++) {
    for (var b = 0; b <= 3; b++) {
      final results = <int, int>{};
      for (var i = 0; i < 100; i++) {
        qmem.initialize({qa: a, qb: b});

        circuit.execute(qmem);
        _nbExec++;

        final n = qa.read();
        results[n] = results.putIfAbsent(n, () => 0) + 1;
      }

      print('[$a/$b] Outcome: $a + $b = $results');
    }
  }

  final rnd = math.Random();

  // random checks
  for (var i = 0; i < 10000; i++) {
    final a = rnd.nextInt(8);
    final b = rnd.nextInt(4);

    qmem.initialize({
      qa: a,
      qb: b,
    });

    circuit.execute(qmem);
    _nbExec++;

    // read values of b and sum after execution
    final sum = qa.read();
    final bb = qb.read();
    if (sum != (a + b) % 8) {
      throw Exception('Wrong result $sum for $a + $b');
    }
    if (bb != b) {
      throw Exception('Unexpected change in ${qb.name}: $bb (was $b)');
    }
  }
}
