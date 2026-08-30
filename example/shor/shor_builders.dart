import 'dart:async';
import 'dart:math' as math;

import 'package:qartvm/qartvm.dart';
import 'package:squadron/squadron.dart';

import 'shor_builders.activator.g.dart';

part 'shor_builders.worker.g.dart';

@vmService
class ShorBuilders {
  ShorBuilders(this.size) : builder = QGateBuilder.get(size, withCache: true);

  final QGateBuilder builder;
  final int size;

  @squadronMethod
  FutureOr<void> clearCache() {
    // no cache in actual implementations
  }

  @squadronMethod
  FutureOr<ComplexMatrix> addGate(List<int> qubits, int constant) =>
      _perf('addGate($qubits, $constant)', () {
        final adder = QCircuit(builder);
        final len = qubits.length;
        var div = 2;
        for (var i = 0; i < len; i++) {
          final angle = (2 * constant) / div;
          div <<= 1;
          if (angle % 2 != 0) {
            adder.phase(angle * math.pi, {qubits[len - 1 - i]});
          }
        }
        adder.compile();
        return adder.gates.first.matrix!;
      });

  @squadronMethod
  FutureOr<ComplexMatrix> setFlagOnOverflowGate(List<int> qubits, int flag) =>
      _perf('setFlagOnOverflowGate($qubits, $flag)', () {
        final setter = QCircuit(
          builder,
        ).invQft(qubits).not(flag, controls: qubits[0]).qft(qubits);
        setter.compile();
        return setter.gates.first.matrix!;
      });

  @squadronMethod
  FutureOr<ComplexMatrix> resetFlagGate(List<int> qubits, int flag) =>
      _perf('resetFlagGate($qubits, $flag)', () {
        final resetter = QCircuit(builder)
            .invQft(qubits)
            .not(qubits[0])
            .not(flag, controls: qubits[0])
            .not(qubits[0])
            .qft(qubits);
        resetter.compile();
        return resetter.gates.first.matrix!;
      });

  @squadronMethod
  FutureOr<ComplexMatrix> swapperGate(List<int> qa, List<int> qb) =>
      _perf('swapperGate($qa, $qb)', () {
        final len = qa.length;
        if (qb.length != len) {
          throw WorkerException(
            'The list of qubits to swap must have the same length',
          );
        }
        final swapper = QCircuit(builder);
        for (var i = 0; i < len; i++) {
          swapper.swap({qa[i], qb[i]});
        }
        swapper.compile();
        return swapper.gates.first.matrix!;
      });

  @squadronMethod
  FutureOr<ComplexMatrix> qftGate(List<int> qubits) =>
      _perf('qftGate($qubits)', () {
        final qft = QCircuit(builder).qft(qubits);
        return qft.gates.first.matrix!;
      });

  @squadronMethod
  FutureOr<ComplexMatrix> invQftGate(List<int> qubits) =>
      _perf('invQftGate($qubits)', () {
        final invQft = QCircuit(builder).invQft(qubits);
        return invQft.gates.first.matrix!;
      });
}

ComplexMatrix _perf(String key, ComplexMatrix Function() compute) {
  final sw = Stopwatch()..start();
  final m = compute();
  print('$key computed in ${sw.elapsed}');
  return m;
}
