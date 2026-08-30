import 'package:qartvm/qartvm.dart';

void main() {
  const nQubits = 10;
  final qmem = QMemorySpace.zero(nQubits);
  final denseBuilder = QGateBuilder.get(nQubits, withCache: true);

  print('--- Benchmarking $nQubits Qubits ---');

  // Benchmark 1: Matrix Multiplication (Dense)
  final m1 = ComplexDenseMatrix.identity(1 << nQubits);
  final m2 = ComplexDenseMatrix.identity(1 << nQubits);
  final stopwatch = Stopwatch()..start();
  final _ = m1 * m2;
  print(
    'Matrix Multiplication (${1 << nQubits}x${1 << nQubits}): ${stopwatch.elapsedMilliseconds}ms',
  );

  // Benchmark 2: Gate Application (Dense Matrix-Vector)
  stopwatch.reset();
  stopwatch.start();
  final hGate = denseBuilder.parallel.hadamard({0});
  for (var i = 0; i < 10; i++) {
    qmem.applyGate(hGate, {0});
  }
  print(
    'Single-qubit Gate Application (10 times): ${stopwatch.elapsedMilliseconds}ms',
  );

  // Benchmark 3: Tensor Product
  final a = ComplexDenseMatrix.identity(2);
  final b = ComplexDenseMatrix.identity(512);
  stopwatch.reset();
  stopwatch.start();
  ComplexMatrix.tensor(a, b);
  print(
    'Tensor Product (2x2 with 512x512): ${stopwatch.elapsedMilliseconds}ms',
  );
}
