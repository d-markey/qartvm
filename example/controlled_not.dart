import 'package:qartvm/qartvm.dart';

import 'utils.dart';

void main() {
  final circuit = QCircuit(QGateBuilder.get(2));
  circuit.not(1, controls: 0);

  describe(circuit);
  draw(circuit);

  final qmem = QMemorySpace.zero(circuit.size);
  final qmem2 = QMemorySpace.zero(circuit.size);

  final qbits = [Qbit.zero, Qbit.one];

  for (var q0 in qbits) {
    for (var q1 in qbits) {
      qmem.initialize({0: q0, 1: q1});
      qmem2.initialize({0: q0, 1: q1});
      final a0 = qmem.read(qubits: 0);
      final b0 = qmem.read(qubits: 1);
      print('Initial states');
      print(' * amplitudes:    ${amplInfo(qmem, fractionDigits: 6)}');
      print(' * probabilities: ${probInfo(qmem, fractionDigits: 2)}');

      circuit.execute(qmem);

      print('Final states');
      print(' * amplitudes:    ${amplInfo(qmem, fractionDigits: 6)}');
      print(' * probabilities: ${probInfo(qmem, fractionDigits: 2)}');

      final a1 = qmem.read(qubits: 0);
      final b1 = qmem.read(qubits: 1);

      if (a0 != a1) {
        throw Exception(
            'Control qubit changed unexpectedly: a0 = $a0 => a1 = $a1');
      }
      if (a0 == 0) {
        if (b0 != b1) {
          throw Exception(
              'Target qubit changed unexpectedly: a0 = $a0, b0 = $b0 => b1 = $b1');
        }
      } else {
        if (b0 == b1) {
          throw Exception(
              'Target qubit was not changed: a0 = $a0, b0 = $b0 => b1 = $b1');
        }
      }

      print('');
    }
  }
}
