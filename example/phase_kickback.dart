import 'dart:math' as math;

import 'package:qartvm/qartvm.dart';

import 'utils.dart';

void main() {
  final circuitT = QCircuit(QGateBuilder.get(4, withCache: false));
  circuitT.hadamard([Hardware.$0, Hardware.$1, Hardware.$2]);
  circuitT.not(Hardware.$3);
  circuitT.phaseT(Hardware.$3, controls: Hardware.$0);
  circuitT.phaseT(Hardware.$3, controls: Hardware.$1);
  circuitT.phaseT(Hardware.$3, controls: Hardware.$1);
  circuitT.phaseT(Hardware.$3, controls: Hardware.$2);
  circuitT.phaseT(Hardware.$3, controls: Hardware.$2);
  circuitT.phaseT(Hardware.$3, controls: Hardware.$2);
  circuitT.phaseT(Hardware.$3, controls: Hardware.$2);
  circuitT.invQft([Hardware.$0, Hardware.$1, Hardware.$2], swap: true);

  describe(circuitT);
  draw(circuitT);

  final qmemT = QMemorySpace.zero(circuitT.size);
  print('Initial states');
  print(' * amplitudes:    ${amplInfo(qmemT, fractionDigits: 6)}');
  print(' * probabilities: ${probInfo(qmemT, fractionDigits: 2)}');

  circuitT.execute(qmemT);

  print('Final states');
  print(' * amplitudes:    ${amplInfo(qmemT, fractionDigits: 6)}');
  print(' * probabilities: ${probInfo(qmemT, fractionDigits: 2)}');

  print('');

  print(
    '${qmemT.read(qbits: [Hardware.$0])} ${qmemT.read(qbits: [Hardware.$1])} ${qmemT.read(qbits: [Hardware.$2])}',
  );

  final t = qmemT.read(qbits: [Hardware.$0, Hardware.$1, Hardware.$2]);
  print('thetaT = $t / 8 = ${t / 8}');
  if (t != 1) {
    throw Exception('Unexpected t = $t');
  }

  final circuitS = QCircuit(QGateBuilder.get(4, withCache: false));
  circuitS.hadamard([Hardware.$0, Hardware.$1, Hardware.$2]);
  circuitS.not(Hardware.$3);
  circuitS.phaseS(Hardware.$3, controls: Hardware.$0);
  circuitS.phaseS(Hardware.$3, controls: Hardware.$1);
  circuitS.phaseS(Hardware.$3, controls: Hardware.$1);
  circuitS.phaseS(Hardware.$3, controls: Hardware.$2);
  circuitS.phaseS(Hardware.$3, controls: Hardware.$2);
  circuitS.phaseS(Hardware.$3, controls: Hardware.$2);
  circuitS.phaseS(Hardware.$3, controls: Hardware.$2);
  circuitS.invQft([Hardware.$0, Hardware.$1, Hardware.$2], swap: true);

  describe(circuitS);
  draw(circuitS);

  final qmemS = QMemorySpace.zero(circuitS.size);
  print('Initial states');
  print(' * amplitudes:    ${amplInfo(qmemS, fractionDigits: 6)}');
  print(' * probabilities: ${probInfo(qmemS, fractionDigits: 2)}');

  circuitS.execute(qmemS);

  print('Final states');
  print(' * amplitudes:    ${amplInfo(qmemS, fractionDigits: 6)}');
  print(' * probabilities: ${probInfo(qmemS, fractionDigits: 2)}');

  print('');

  final s = qmemS.read(qbits: [Hardware.$0, Hardware.$1, Hardware.$2]);
  print('thetaS = $s / 8 = ${s / 8}');
  if (s != 2) {
    throw Exception('Unexpected s = $s');
  }

  for (var n = 0; n < 8; n++) {
    final circuit = QCircuit(QGateBuilder.get(4, withCache: false));
    circuit.hadamard([Hardware.$0, Hardware.$1, Hardware.$2]);
    circuit.not(Hardware.$3);
    circuit.phase(n * 2 * math.pi / 8, Hardware.$3, controls: Hardware.$0);
    circuit.phase(n * 2 * math.pi / 8, Hardware.$3, controls: Hardware.$1);
    circuit.phase(n * 2 * math.pi / 8, Hardware.$3, controls: Hardware.$1);
    circuit.phase(n * 2 * math.pi / 8, Hardware.$3, controls: Hardware.$2);
    circuit.phase(n * 2 * math.pi / 8, Hardware.$3, controls: Hardware.$2);
    circuit.phase(n * 2 * math.pi / 8, Hardware.$3, controls: Hardware.$2);
    circuit.phase(n * 2 * math.pi / 8, Hardware.$3, controls: Hardware.$2);
    circuit.invQft([Hardware.$0, Hardware.$1, Hardware.$2], swap: true);

    describe(circuit);
    draw(circuit);

    final qmem = QMemorySpace.zero(circuit.size);
    final output = qmem.createRegister(
      'output',
      addresses: [Hardware.$0, Hardware.$1, Hardware.$2],
    );
    print('Initial states');
    print(' * amplitudes:    ${amplInfo(qmem, fractionDigits: 6)}');
    print(' * probabilities: ${probInfo(qmem, fractionDigits: 2)}');

    circuit.execute(qmem);

    print('Final states');
    print(' * amplitudes:    ${amplInfo(qmem, fractionDigits: 6)}');
    print(' * probabilities: ${probInfo(qmem, fractionDigits: 2)}');

    print('');

    final p = output.read();
    print('thetaP = $p / 8 = ${p / 8}');
    if (p != n) {
      throw Exception('Unexpected p = $p instead of $n');
    }
  }
}
