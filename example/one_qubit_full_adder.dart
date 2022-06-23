import 'package:qartvm/qartvm.dart';

import 'utils.dart';

void main() {
  // 1-qubit full adder

  //  0 = a0 ------- X -------- X --------------------------- X ------  --> a0
  //                          -----                         -----
  //  1 = b0 ------- X ------| NOT |----- X -------- X ----| NOT |----  --> b0
  //                          -----                         -----
  //                                               -----
  //  2      ---------------------------- X ------| NOT |-------------  --> (a+b)0
  //                                               -----
  //              --------             --------
  //  3      ----| CC-NOT |-----------| CC-NOT |----------------------  --> (a+b)1 = carry
  //              --------             --------

  final gateBuilder = QGateBuilder.get(4);

  final circuit = QCircuit(gateBuilder);
  circuit.toffoli(3, controls: {0, 1});
  circuit.not(1, controls: 0);
  circuit.toffoli(3, controls: {1, 2});
  circuit.not(2, controls: 1);
  circuit.not(1, controls: 0);

  final qmem = QMemorySpace.zero(4);
  final qa = qmem.createRegister('a', at: 0);
  final qb = qmem.createRegister('b', at: 1);
  final qc = qmem.createRegister('c', from: 3, to: 2);

  describe(circuit);
  draw(circuit, qmem: qmem);

  for (var a = 0; a <= 1; a++) {
    for (var b = 0; b <= 1; b++) {
      qmem.initialize({
        qa: a,
        qb: b,
        qc: 0,
      });

      print('[$a/$b] Initial states: ${probInfo(qmem)}');

      circuit.execute(qmem);

      print('[$a/$b] Final states: ${probInfo(qmem)}');

      final result = qc.read();

      print('[$a/$b] Outcome: $a + $b = $result');
      if (a + b != result) {
        throw Exception('$a + $b = ${a + b} but found $result');
      }
    }
  }
}
