import 'package:qartvm/qartvm.dart';

import 'utils.dart';

void main() {
  final qubits = 8;
  final qmem = QMemorySpace.zero(qubits);
  qmem.measureMode = QMeasureMode.joint;

  final qa = qmem.createRegister(
    'qa',
    addresses: [Hardware.$0, Hardware.$1, Hardware.$2],
  );
  final qb = qmem.createRegister(
    'qb',
    addresses: [
      Hardware.$3,
      Hardware.$4,
      Hardware.$5,
      Hardware.$6,
      Hardware.$7,
    ],
  );

  qmem.initialize({qa: 3, qb: 8});

  print('state: ${probInfo(qmem)}');

  final a = qa.read(), b = qb.read();
  print('measure qa --> $a (expected 3)');
  print('measure qb --> $b (expected 8)');
  if (a != 3) throw Exception('Expected qa -[/]-> 3, got $a');
  if (b != 8) throw Exception('Expected qb -[/]-> 8, got $b');
  print('OK');
}
