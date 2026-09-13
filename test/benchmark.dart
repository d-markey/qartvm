import 'package:qartvm/qartvm.dart';

void main() {
  const nQubits = 10;
  final qmem = QMemorySpace.zero(nQubits);
  final gateBuilder = QGateBuilder.get(nQubits, withCache: true);

  print('--- Benchmarking $nQubits Qubits ---');

  // Benchmark 1: Matrix Multiplication (Dense)
  final m1 = ComplexDenseMatrix.identity(1 << nQubits);
  final m2 = ComplexDenseMatrix.identity(1 << nQubits);
  final stopwatch = Stopwatch()..start();
  final _ = m1 * m2;
  print(
    'Matrix Multiplication (${1 << nQubits}x${1 << nQubits}): ${stopwatch.elapsedMilliseconds}ms',
  );

  // Benchmark 2: Matrix Multiplication (SParse)
  final sm1 = ComplexSparseMatrix.identity(1 << nQubits);
  final sm2 = ComplexSparseMatrix.identity(1 << nQubits);
  stopwatch.reset();
  final _ = sm1 * sm2;
  print(
    'Matrix Multiplication (${1 << nQubits}x${1 << nQubits}): ${stopwatch.elapsedMilliseconds}ms',
  );

  // Benchmark 3: Gate Application
  stopwatch.reset();
  final hGate = gateBuilder.parallel.hadamard({Hardware.$0});
  for (var i = 0; i < 10; i++) {
    qmem.applyGate(hGate, {Hardware.$0});
  }
  print(
    'Single-qubit Gate Application (10 times): ${stopwatch.elapsedMilliseconds}ms',
  );

  // Benchmark 4: Tensor Product
  final a = ComplexSparseMatrix.identity(2);
  final b = ComplexSparseMatrix.identity(512);
  stopwatch.reset();
  final _ = ComplexSparseMatrix.tensor(a, b);
  print(
    'Tensor Product (2x2 with 512x512): ${stopwatch.elapsedMilliseconds}ms',
  );
}
