import 'dart:math';

import 'package:qartvm/qartvm.dart';

import 'utils.dart';

String? getArg(List<String> args, int idx) =>
    (0 <= idx && idx < args.length) ? args[idx] : null;

void main(List<String> args) {
  final start = int.tryParse(getArg(args, 0) ?? '4');
  final end = int.tryParse(getArg(args, 1) ?? '64');
  final measures = int.tryParse(getArg(args, 2) ?? '100');

  if (start == null) {
    throw Exception('Invalid start argument (${getArg(args, 0)})');
  }
  if (end == null) {
    throw Exception('Invalid end argument (${getArg(args, 1)})');
  }
  if (measures == null) {
    throw Exception('Invalid measures argument (${getArg(args, 3)})');
  }

  for (var nb = start; nb <= end; nb++) {
    print('');
    // build encoder for current number
    print('Build encoder for $nb...');
    final encoder = buildEncoder(nb);
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
  final encoder = QCircuit(size: nbQubits);
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

QCircuit buildDecoder(int size) {
  final decoder = QCircuit(size: size);
  // decoder.addListener((step, gate, qreg) => print(gate?.label ?? 'initializing'));
  // inverse QFT
  decoder.invQft(Iterable<int>.generate(size).toList(), label: "INV_QFT");
  // measure
  decoder.measure();
  return decoder;
}

int decode(QCircuit decoder, QRegister qreg) {
  decoder.execute(qreg);
  return qreg.read();
}
