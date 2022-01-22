import 'package:qartvm/qartvm.dart';

void describe(QCircuit circuit) {
  for (var descr in circuit.describe()) {
    print(' * $descr');
  }
}

void draw(QCircuit circuit) {
  final drawer = QCircuitDrawer();
  for (var l in drawer.draw(circuit)) {
    print('  $l');
  }
}

String stateInfo(Map<String, double> states, {int fractionDigits = 0}) =>
    states.entries
        .where((e) => e.value != 0)
        .map((e) =>
            '${e.key} (${(e.value * 100).toStringAsFixed(fractionDigits)} %)')
        .join(', ');

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
    if ((value & 0x1) == 0x0) {
      b = '0$b';
    } else {
      b = '1$b';
    }
    value >>= 1;
    max >>= 1;
  }
  if (b == '') b = '0';
  return '0b$b';
}

List<Qbit> qbits(int value, int length) {
  final qubits = <Qbit>[];
  while (value != 0) {
    qubits.insert(0, (value & 0x1) == 0x0 ? Qbit.zero : Qbit.one);
    value >>= 1;
  }
  while (qubits.length < length) {
    qubits.insert(0, Qbit.zero);
  }
  return qubits;
}
