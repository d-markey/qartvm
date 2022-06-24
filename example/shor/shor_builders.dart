import 'dart:async';
import 'dart:math' as math;

import 'package:qartvm/qartvm.dart';
import 'package:squadron/squadron.dart';

abstract class ShorBuilders {
  void clearCache();
  FutureOr<ComplexMatrix> addGate(List<int> qubits, int constant);
  FutureOr<ComplexMatrix> setFlagOnOverflowGate(List<int> qubits, int flag);
  FutureOr<ComplexMatrix> resetFlagGate(List<int> qubits, int flag);
  FutureOr<ComplexMatrix> swapperGate(List<int> qa, List<int> qb);
  FutureOr<ComplexMatrix> qftGate(List<int> qubits);
  FutureOr<ComplexMatrix> invQftGate(List<int> qubits);

  static const cmdAddGate = 1;
  static const cmdSetFlagOnOverflowGate = 2;
  static const cmdResetFlagGate = 3;
  static const cmdSwapperGate = 4;
  static const cmdQftGate = 5;
  static const cmdInvQftGate = 6;
}

class ShorBuildersImpl extends WorkerService implements ShorBuilders {
  ShorBuildersImpl(this.size)
      : builder = QGateBuilder.get(size, withCache: true);

  final QGateBuilder builder;
  final int size;

  @override
  void clearCache() {
    // no cache in actual implementations
  }

  ComplexMatrix _perf(String key, ComplexMatrix Function() compute) {
    final sw = Stopwatch()..start();
    final m = compute();
    Squadron.config('$key computed in ${sw.elapsed}');
    return m;
  }

  @override
  ComplexMatrix addGate(List<int> qubits, int constant) =>
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

  @override
  ComplexMatrix setFlagOnOverflowGate(List<int> qubits, int flag) =>
      _perf('setFlagOnOverflowGate($qubits, $flag)', () {
        final setter = QCircuit(builder)
            .invQft(qubits)
            .not(flag, controls: qubits[0])
            .qft(qubits);
        setter.compile();
        return setter.gates.first.matrix!;
      });

  @override
  ComplexMatrix resetFlagGate(List<int> qubits, int flag) =>
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

  @override
  ComplexMatrix swapperGate(List<int> qa, List<int> qb) =>
      _perf('swapperGate($qa, $qb)', () {
        final len = qa.length;
        if (qb.length != len) {
          throw WorkerException(
              'The list of qubits to swap must have the same length');
        }
        final swapper = QCircuit(builder);
        for (var i = 0; i < len; i++) {
          swapper.swap({qa[i], qb[i]});
        }
        swapper.compile();
        return swapper.gates.first.matrix!;
      });

  @override
  ComplexMatrix qftGate(List<int> qubits) => _perf('qftGate($qubits)', () {
        final qft = QCircuit(builder).qft(qubits);
        return qft.gates.first.matrix!;
      });

  @override
  ComplexMatrix invQftGate(List<int> qubits) =>
      _perf('invQftGate($qubits)', () {
        final invQft = QCircuit(builder).invQft(qubits);
        return invQft.gates.first.matrix!;
      });

  @override
  late final Map<int, CommandHandler> operations = {
    ShorBuilders.cmdAddGate: (r) => addGate(r.args[0], r.args[1]).serialize(),
    ShorBuilders.cmdSetFlagOnOverflowGate: (r) =>
        setFlagOnOverflowGate(r.args[0], r.args[1]).serialize(),
    ShorBuilders.cmdResetFlagGate: (r) =>
        resetFlagGate(r.args[0], r.args[1]).serialize(),
    ShorBuilders.cmdSwapperGate: (r) =>
        swapperGate(r.args[0], r.args[1]).serialize(),
    ShorBuilders.cmdQftGate: (r) => qftGate(r.args[0]).serialize(),
    ShorBuilders.cmdInvQftGate: (r) => invQftGate(r.args[0]).serialize(),
  };
}

void _start(Map command) {
  Squadron.setLogger(ConsoleSquadronLogger());
  run((startRequest) {
    Squadron.config('Thread started, size = ${startRequest.args[0]}');
    return ShorBuildersImpl(startRequest.args[0]);
  }, command);
}

class ShorBuildersWorker extends Worker implements ShorBuilders {
  ShorBuildersWorker(int size) : super(_start, args: [size]);

  @override
  void clearCache() {
    // no cache in workers
  }

  @override
  Future<ComplexMatrix> addGate(List<int> qubits, int constant) async =>
      ComplexMatrix.deserialize(
          await send(ShorBuilders.cmdAddGate, args: [qubits, constant]));

  @override
  Future<ComplexMatrix> setFlagOnOverflowGate(
          List<int> qubits, int flag) async =>
      ComplexMatrix.deserialize(await send(
          ShorBuilders.cmdSetFlagOnOverflowGate,
          args: [qubits, flag]));

  @override
  Future<ComplexMatrix> resetFlagGate(List<int> qubits, int flag) async =>
      ComplexMatrix.deserialize(
          await send(ShorBuilders.cmdResetFlagGate, args: [qubits, flag]));

  @override
  Future<ComplexMatrix> swapperGate(List<int> qa, List<int> qb) async =>
      ComplexMatrix.deserialize(
          await send(ShorBuilders.cmdSwapperGate, args: [qa, qb]));

  @override
  Future<ComplexMatrix> qftGate(List<int> qubits) async =>
      ComplexMatrix.deserialize(
          await send(ShorBuilders.cmdQftGate, args: [qubits]));

  @override
  Future<ComplexMatrix> invQftGate(List<int> qubits) async =>
      ComplexMatrix.deserialize(
          await send(ShorBuilders.cmdInvQftGate, args: [qubits]));
}

class ShorBuildersPool extends WorkerPool<ShorBuildersWorker>
    implements ShorBuilders {
  ShorBuildersPool(int size, ConcurrencySettings concurrencySettings)
      : super(() => ShorBuildersWorker(size),
            concurrencySettings: concurrencySettings);

  final Map<String, Future<ComplexMatrix>> _cacheFutures = {};

  int _hits = 0;
  int _misses = 0;

  int get hits => _hits;
  int get misses => _misses;

  Future<ComplexMatrix> _getOrExecute(String key,
      Future<ComplexMatrix> Function(ShorBuildersWorker w) executor) {
    var cached = _cacheFutures[key];
    if (cached == null) {
      _misses++;
      Squadron.fine('$key: in progress ($_hits / ${_hits + _misses})');
      cached = execute(executor);
      _cacheFutures[key] = cached;
    } else {
      _hits++;
      Squadron.fine(
          '$key: served from cached future ($_hits / ${_hits + _misses})');
    }
    return cached;
  }

  @override
  void clearCache() {
    _cacheFutures.clear();
  }

  @override
  Future<ComplexMatrix> addGate(List<int> qubits, int constant) async =>
      _getOrExecute(
          'addGate($qubits, $constant)', (w) => w.addGate(qubits, constant));

  @override
  Future<ComplexMatrix> setFlagOnOverflowGate(
          List<int> qubits, int flag) async =>
      _getOrExecute('setFlagOnOverflowGate($qubits, $flag)',
          (w) => w.setFlagOnOverflowGate(qubits, flag));

  @override
  Future<ComplexMatrix> resetFlagGate(List<int> qubits, int flag) async =>
      _getOrExecute('resetFlagGate($qubits, $flag)',
          (w) => w.resetFlagGate(qubits, flag));

  @override
  Future<ComplexMatrix> swapperGate(List<int> qa, List<int> qb) async =>
      _getOrExecute('swapperGate($qa, $qb)', (w) => w.swapperGate(qa, qb));

  @override
  Future<ComplexMatrix> qftGate(List<int> qubits) async =>
      _getOrExecute('qftGate($qubits)', (w) => w.qftGate(qubits));

  @override
  Future<ComplexMatrix> invQftGate(List<int> qubits) async =>
      _getOrExecute('invQftGate($qubits)', (w) => w.invQftGate(qubits));
}
