import 'dart:math';

import 'package:qartvm/qartvm.dart';

import 'utils.dart';

void main() {
  final start = 4;
  final end = 64;
  final measures = 10;

  for (var nb = start; nb <= end; nb++) {
    print('');
    // build encoder for current number
    print('Build encoder for $nb...');
    final encoder = buildEncoder(nb);
    describe(encoder);
    draw(encoder);

    // build decoder
    print('Build decoder (size = ${encoder.size} qubits)...');
    final decoder = buildDecoder(encoder.gateBuilder);
    describe(decoder);
    draw(decoder);

    // take measures
    print('Take $measures measures...');
    final outcomes = <int, int>{};
    for (var i = 0; i < measures; i++) {
      final qmem = QMemorySpace.zero(encoder.size);
      encoder.execute(qmem);
      final n = decode(decoder, qmem);
      outcomes[n] = outcomes.putIfAbsent(n, () => 0) + 1;
    }

    // print outcome results
    print('Outcomes:');
    for (var n in outcomes.keys) {
      print('   [$nb] $n (binary ${bitString(n, nb)}): ${outcomes[n]}');
      if (nb != n) throw Exception('Unexpected outcome $n for $nb');
    }
  }
  print('');
}

QCircuit buildEncoder(int number) {
  // compute nb of qubits
  var nbQubits = 0;
  var n = number;
  while (n != 0) {
    nbQubits++;
    n >>= 1;
  }
  if (nbQubits == 0) nbQubits = 1;

  // build encoder
  final gateBuilder = QGateBuilder.get(nbQubits);
  final encoder = QCircuit(gateBuilder);
  encoder.hadamard(Iterable<int>.generate(encoder.size));
  final twoPi = 2 * pi;
  var div = 1;
  for (var i = nbQubits - 1; i >= 0; i--) {
    // phase
    final angle = number * pi / div;
    if ((angle % twoPi).abs() > 1e-9 && (twoPi - angle % twoPi).abs() > 1e-9) {
      encoder.phase(angle, i);
    }
    div <<= 1;
  }

  return encoder;
}

QCircuit buildDecoder(QGateBuilder gateBuilder) {
  final decoder = QCircuit(gateBuilder);
  // decoder.addListener((step, gate, qmem) => print(gate?.label ?? 'initializing'));
  // inverse QFT
  decoder.invQft(Iterable<int>.generate(gateBuilder.size).toList(),
      label: "INV_QFT");
  // measure
  decoder.measure();
  return decoder;
}

int decode(QCircuit decoder, QMemorySpace qmem) {
  decoder.execute(qmem);
  return qmem.read();
}
