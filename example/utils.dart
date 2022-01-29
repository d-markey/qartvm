import 'package:qartvm/qartvm.dart';

void describe(QCircuit circuit) {
  for (var descr in circuit.gates.map((g) => g.label)) {
    print(' * $descr');
  }
}

void draw(QCircuit circuit) {
  final drawer = QCircuitAsciiDrawer();
  for (var l in drawer.draw(circuit)) {
    print('  $l');
  }
}

String probInfo(Map<String, double> states, {int fractionDigits = 0}) => states
    .entries
    .where((e) => e.value > 1e-9)
    .map(
        (e) => '${e.key} (${percent(e.value, fractionDigits: fractionDigits)})')
    .join(', ');

String amplInfo(Map<String, Complex> states, {int fractionDigits = 0}) =>
    states.entries
        .where((e) => e.value.det > 1e-9)
        .map((e) => '${e.key} (${e.value.toStringAsFixed(fractionDigits)})')
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
