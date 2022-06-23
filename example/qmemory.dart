import 'package:qartvm/qartvm.dart';

import 'utils.dart';

void main() {
  final qubits = 8;
  final qmem = QMemorySpace.zero(qubits);
  final qa = qmem.createRegister('qa', addresses: [0, 1, 2]);
  final qb = qmem.createRegister('qb', addresses: [3, 4, 5, 6, 7]);

  qmem.initialize({
    qa: 3,
    qb: 8,
  });

  print('state: ${probInfo(qmem)}');

  print('qa = ${qa.read()}');
  print('qb = ${qb.read()}');
}
