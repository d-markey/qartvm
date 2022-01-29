import 'dart:math' as math;

import 'package:qartvm/qartvm.dart';

import 'utils.dart';

void main() {
  final rnd = math.Random.secure();
  final N = 15;

  final widthOfN = bitWidth(N);

  int p, q; // N = p * q

  bool classical;
  while (true) {
    // pick a
    final a = 1 + rnd.nextInt(N - 1);
    final K = gcd(a, N);
    if (K != 1) {
      // classical solution (by chance)
      classical = true;
      p = K;
      q = N ~/ K;
      break;
    }
    // quantum part of the algorithm
    var r = quantumPart(N, a, widthOfN);
    if (r % 2 == 1) continue;
    r >>= 1;
    final b = math.pow(a, r).toInt();
    if (b % N == N - 1) continue;
    // quantum solution
    classical = false;
    p = gcd(b - 1, N);
    q = gcd(b + 1, N);
    break;
  }

  print('found ${classical ? 'classical' : 'quantum'} solution: $N = $p * $q');
}

int gcd(int a, int b) {
  if (a < b) {
    var t = a;
    a = b;
    b = t;
  }
  while (b != 0) {
    var t = b;
    b = a % b;
    a = t;
  }
  return a;
}

int quantumPart(int N, int a, int widthOfN) {
  final circuit = QCircuit(size: 2 * widthOfN + 3);
  circuit.hadamard(Iterable<int>.generate(widthOfN).toSet());

  // TODO !!!

  return 1;
}

void add(QCircuit circuit, List<int> qubits1, List<int> qubits2) {
  // qubits1 & 2 must have the same length
  // result is stored in qubits1
  // qubits2 are used as control
  var j0 = qubits2.length - 1;
  for (var i = qubits1.length - 1; i >= 0; i--) {
    var n = 1;
    final qb = {qubits1[i]};
    for (var j = j0; j >= 0; j--) {
      circuit.phase(math.pi / n, qb, controls: qubits2[j]);
      n *= 2;
    }
    j0--;
  }
}
