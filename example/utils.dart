import 'dart:io';

import 'package:qartvm/qartvm.dart';

void describe(QCircuit circuit) {
  for (var descr in circuit.gates.map((g) => g.label)) {
    print(' * $descr');
  }
}

String z2(int n) => n.toString().padLeft(2, '0');
String z4(int n) => n.toString().padLeft(4, '0');

Future draw(QCircuit circuit, {QMemorySpace? qmem, String? filePrefix}) async {
  IOSink? writer;
  try {
    final drawer = QCircuitAsciiDrawer();
    var log = (String t) => print(t);
    if (filePrefix != null) {
      final now = DateTime.now();
      final file = File(
          './$filePrefix-${z4(now.year)}${z2(now.month)}${z2(now.day)}-${z2(now.hour)}${z2(now.minute)}${z2(now.second)}.txt');
      writer = file.openWrite();
      log = writer.writeln;
    }
    for (var l in drawer.draw(circuit, qmem)) {
      log('  $l');
    }
  } finally {
    if (writer != null) {
      await writer.flush();
      writer.close();
    }
  }
}

String probInfo(QMemorySpace qmem, {int fractionDigits = 0}) => qmem
    .probabilities.entries
    .where((e) => e.value > 1e-9)
    .map((e) =>
        '${qmem.formatState(e.key)} (${percent(e.value, fractionDigits: fractionDigits)})')
    .join(', ');

String amplInfo(QMemorySpace qmem, {int fractionDigits = 0}) => qmem
    .amplitudes.entries
    .where((e) => e.value.det > 1e-9)
    .map((e) =>
        '${qmem.formatState(e.key)} (${e.value.toStringAsFixed(fractionDigits)})')
    .join(', ');

String percent(double percent, {int fractionDigits = 0}) =>
    '${(percent * 100).toStringAsFixed(fractionDigits)} %';

int bitWidth(int n) {
  int w = 1;
  n >>= 1;
  while (n != 0) {
    w++;
    n >>= 1;
  }
  return w;
}

String bitString(int value, int max) {
  var b = '';
  while (max != 0) {
    b = ((value & 1) == 0) ? '0$b' : '1$b';
    value >>= 1;
    max >>= 1;
  }
  return b.isEmpty ? '0' : b;
}
