import 'package:qartvm/qartvm.dart';

import 'utils.dart';

void main() {
  final $0 = QbitAddress(0),
      $1 = QbitAddress(1),
      $2 = QbitAddress(2),
      $3 = QbitAddress(3),
      $4 = QbitAddress(4),
      $5 = QbitAddress(5),
      $6 = QbitAddress(6),
      $7 = QbitAddress(7);

  final qubits = 8;
  final qmem = QMemorySpace.zero(qubits);
  final qa = qmem.createRegister('qa', addresses: [$0, $1, $2]);
  final qb = qmem.createRegister('qb', addresses: [$3, $4, $5, $6, $7]);

  qmem.initialize({qa: 3, qb: 8});

  print('state: ${probInfo(qmem)}');

  final a = qa.read(), b = qb.read();
  print('measure qa --> $a (expected 3)');
  print('measure qb --> $b (expected 8)');
  if (a != 3) throw Exception('Expected qa -[/]-> 3, got $a');
  if (b != 8) throw Exception('Expected qb -[/]-> 8, got $b');
  print('OK');
}
