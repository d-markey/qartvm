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
  FutureOr<ComplexMatrix> addGate(List<QbitAddress> qbits, int constant) =>
      _perf('addGate($qbits, $constant)', () {
        final adder = QCircuit(builder);
        final len = qbits.length;
        var div = 2;
        for (var i = 0; i < len; i++) {
          final angle = (2 * constant) / div;
          div <<= 1;
          if (angle % 2 != 0) {
            adder.phase(angle * math.pi, {qbits[len - 1 - i]});
          }
        }
        adder.compile();
        return adder.gates.first.matrix!;
      });

  @squadronMethod
  FutureOr<ComplexMatrix> setFlagOnOverflowGate(
    List<QbitAddress> qbits,
    QbitAddress flag,
  ) => _perf('setFlagOnOverflowGate($qbits, $flag)', () {
    final setter = QCircuit(builder)
        .invQft(qbits, swap: true)
        .not(flag, controls: qbits.last)
        .qft(qbits, swap: true);
    setter.compile();
    return setter.gates.first.matrix!;
  });

  @squadronMethod
  FutureOr<ComplexMatrix> resetFlagGate(
    List<QbitAddress> qbits,
    QbitAddress flag,
  ) => _perf('resetFlagGate($qbits, $flag)', () {
    final resetter = QCircuit(builder)
        .invQft(qbits, swap: true)
        .not(qbits.last)
        .not(flag, controls: qbits.last)
        .not(qbits.last)
        .qft(qbits, swap: true);
    resetter.compile();
    return resetter.gates.first.matrix!;
  });

  @squadronMethod
  FutureOr<ComplexMatrix> swapperGate(
    List<QbitAddress> qa,
    List<QbitAddress> qb,
  ) => _perf('swapperGate($qa, $qb)', () {
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
  FutureOr<ComplexMatrix> qftGate(List<QbitAddress> qbits) =>
      _perf('qftGate($qbits)', () {
        final qft = QCircuit(builder).qft(qbits, swap: true);
        return qft.gates.first.matrix!;
      });

  @squadronMethod
  FutureOr<ComplexMatrix> invQftGate(List<QbitAddress> qbits) =>
      _perf('invQftGate($qbits)', () {
        final invQft = QCircuit(builder).invQft(qbits, swap: true);
        return invQft.gates.first.matrix!;
      });
}

ComplexMatrix _perf(String key, ComplexMatrix Function() compute) {
  final sw = Stopwatch()..start();
  final m = compute();
  print('$key computed in ${sw.elapsed}');
  return m;
}
