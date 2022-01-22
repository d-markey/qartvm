import 'dart:math';

import 'package:qartvm/qartvm.dart';

import 'utils.dart';

void main() {
  final rnd = Random.secure();
  final N = 15;

  final widthOfN = bitWidth(N);
  final widthOfN2 = bitWidth(N * N);

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
    var r = shor(N, a, widthOfN, widthOfN2);
    if (r % 2 == 1) continue;
    r >>= 1;
    final b = pow(a, r).toInt();
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

int shor(int N, int a, int widthOfN, int widthOfN2) {
  final circuit = QCircuit(size: widthOfN + widthOfN2);
  circuit.parallelHadamard(List.generate(widthOfN, (i) => i).toSet());

  // TODO !!!

  return 1;
}
