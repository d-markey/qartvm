import 'dart:math';

import 'package:qartvm/qartvm.dart';

import 'utils.dart';

void main() {
  final start = 0;
  final end = 255;
  final measures = 5;

  for (var number = start; number <= end; number++) {
    print('');
    // build encoder for current number
    print('Build encoder for $number...');
    final encoder = buildEncoder(number);
    describe(encoder);
    draw(encoder);

    // build decoder
    print('Build decoder (size = ${encoder.size} qubits)...');
    final decoder = buildDecoder(encoder.size);
    describe(decoder);
    draw(decoder);

    // take measures
    print('Take $measures measures...');
    final outcomes = <int, int>{};
    for (var i = 0; i < measures; i++) {
      final qreg = QRegister.zero(encoder.size);
      encoder.execute(qreg);
      final n = decode(decoder, qreg);
      outcomes[n] = outcomes.putIfAbsent(n, () => 0) + 1;
    }

    // print outcome results
    print('Outcomes:');
    for (var entry in outcomes.entries) {
      print(
          '   [$number] ${entry.key} (${bitString(entry.key, number)}): ${entry.value}');
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
  final encoder = QCircuit(size: nbQubits);
  final twoPi = 2 * pi;
  var div = 1;
  for (var i = nbQubits - 1; i >= 0; i--) {
    // hadamard
    encoder.hadamard(i, label: 'HADAMARD');
    // rotation
    final angle = number * pi / div;
    if (angle % twoPi != 0) {
      encoder.phase(i, angle, label: 'ROTATION $number pi / $div = $angle');
    }
    div <<= 1;
  }

  return encoder;
}

QCircuit buildDecoder(int size) {
  final decoder = QCircuit(size: size);
  // decoder.addListener((step, gate, qreg) => print(gate?.label ?? 'initializing'));
  final qbitIdx = List.generate(size, (i) => i);
  // inverse QFT
  decoder.invQft(qbitIdx, label: "INV_QFT");
  // measure
  decoder.measure();
  return decoder;
}

int decode(QCircuit decoder, QRegister qreg) {
  decoder.execute(qreg);
  return qreg.read();
}
