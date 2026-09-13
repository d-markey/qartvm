// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'shor_builders.dart';

// **************************************************************************
// Generator: WorkerGenerator 9.3.2 (Squadron 7.4.3)
// **************************************************************************

// dart format width=80
/// Command ids used in operations map
const int _$addGateId = 1;
const int _$clearCacheId = 2;
const int _$invQftGateId = 3;
const int _$qftGateId = 4;
const int _$resetFlagGateId = 5;
const int _$setFlagOnOverflowGateId = 6;
const int _$swapperGateId = 7;

/// WorkerService operations for ShorBuilders
extension on ShorBuilders {
  OperationsMap _$getOperations() => OperationsMap({
    _$addGateId: ($req) async {
      final ComplexMatrix $res;
      try {
        final $dsr = _$Deser(contextAware: false);
        $res = await addGate($dsr.$1($req.args[0]), $dsr.$2($req.args[1]));
      } finally {}
      return $res;
    },
    _$clearCacheId: ($req) => clearCache(),
    _$invQftGateId: ($req) async {
      final ComplexMatrix $res;
      try {
        final $dsr = _$Deser(contextAware: false);
        $res = await invQftGate($dsr.$1($req.args[0]));
      } finally {}
      return $res;
    },
    _$qftGateId: ($req) async {
      final ComplexMatrix $res;
      try {
        final $dsr = _$Deser(contextAware: false);
        $res = await qftGate($dsr.$1($req.args[0]));
      } finally {}
      return $res;
    },
    _$resetFlagGateId: ($req) async {
      final ComplexMatrix $res;
      try {
        final $dsr = _$Deser(contextAware: false);
        $res = await resetFlagGate(
          $dsr.$1($req.args[0]),
          $dsr.$0($req.args[1]),
        );
      } finally {}
      return $res;
    },
    _$setFlagOnOverflowGateId: ($req) async {
      final ComplexMatrix $res;
      try {
        final $dsr = _$Deser(contextAware: false);
        $res = await setFlagOnOverflowGate(
          $dsr.$1($req.args[0]),
          $dsr.$0($req.args[1]),
        );
      } finally {}
      return $res;
    },
    _$swapperGateId: ($req) async {
      final ComplexMatrix $res;
      try {
        final $dsr = _$Deser(contextAware: false);
        $res = await swapperGate($dsr.$1($req.args[0]), $dsr.$1($req.args[1]));
      } finally {}
      return $res;
    },
  });
}

/// Invoker for ShorBuilders, implements the public interface to invoke the
/// remote service.
mixin _$ShorBuilders$Invoker on Invoker implements ShorBuilders {
  @override
  Future<ComplexMatrix> addGate(List<QbitAddress> qbits, int constant) async {
    final dynamic $res = await send(_$addGateId, args: [qbits, constant]);
    try {
      final $dsr = _$Deser(contextAware: false);
      return $dsr.$3($res);
    } finally {}
  }

  @override
  Future<void> clearCache() => send(_$clearCacheId);

  @override
  Future<ComplexMatrix> invQftGate(List<QbitAddress> qbits) async {
    final dynamic $res = await send(_$invQftGateId, args: [qbits]);
    try {
      final $dsr = _$Deser(contextAware: false);
      return $dsr.$3($res);
    } finally {}
  }

  @override
  Future<ComplexMatrix> qftGate(List<QbitAddress> qbits) async {
    final dynamic $res = await send(_$qftGateId, args: [qbits]);
    try {
      final $dsr = _$Deser(contextAware: false);
      return $dsr.$3($res);
    } finally {}
  }

  @override
  Future<ComplexMatrix> resetFlagGate(
    List<QbitAddress> qbits,
    QbitAddress flag,
  ) async {
    final dynamic $res = await send(_$resetFlagGateId, args: [qbits, flag]);
    try {
      final $dsr = _$Deser(contextAware: false);
      return $dsr.$3($res);
    } finally {}
  }

  @override
  Future<ComplexMatrix> setFlagOnOverflowGate(
    List<QbitAddress> qbits,
    QbitAddress flag,
  ) async {
    final dynamic $res = await send(
      _$setFlagOnOverflowGateId,
      args: [qbits, flag],
    );
    try {
      final $dsr = _$Deser(contextAware: false);
      return $dsr.$3($res);
    } finally {}
  }

  @override
  Future<ComplexMatrix> swapperGate(
    List<QbitAddress> qa,
    List<QbitAddress> qb,
  ) async {
    final dynamic $res = await send(_$swapperGateId, args: [qa, qb]);
    try {
      final $dsr = _$Deser(contextAware: false);
      return $dsr.$3($res);
    } finally {}
  }
}

/// Facade for ShorBuilders, implements other details of the service unrelated to
/// invoking the remote service.
mixin _$ShorBuilders$Facade implements ShorBuilders {
  @override
  // ignore: unused_element
  QGateBuilder get builder => throw UnimplementedError();
}

/// WorkerClient for ShorBuilders
final class $ShorBuilders$Client extends WorkerClient
    with _$ShorBuilders$Invoker, _$ShorBuilders$Facade
    implements ShorBuilders {
  $ShorBuilders$Client(PlatformChannel channelInfo)
    : super(Channel.deserialize(channelInfo)!);

  @override
  late final int size;
}

/// Local worker extension for ShorBuilders
extension $ShorBuildersLocalWorkerExt on ShorBuilders {
  // Get a fresh local worker instance.
  LocalWorker<ShorBuilders> getLocalWorker([
    ExceptionManager? exceptionManager,
  ]) => LocalWorker.create(this, _$getOperations(), exceptionManager);
}

/// WorkerService class for ShorBuilders
class _$ShorBuilders$WorkerService extends ShorBuilders
    implements WorkerService {
  _$ShorBuilders$WorkerService(super.size) : super();

  @override
  OperationsMap get operations => _$getOperations();
}

/// Service initializer for ShorBuilders
WorkerService $ShorBuildersInitializer(WorkerRequest $req) {
  final $dsr = _$Deser(contextAware: false);
  return _$ShorBuilders$WorkerService($dsr.$2($req.args[0]));
}

/// Worker for ShorBuilders
base class ShorBuildersWorker extends Worker
    with _$ShorBuilders$Invoker, _$ShorBuilders$Facade
    implements ShorBuilders {
  // ignore: use_super_parameters
  ShorBuildersWorker(
    this.size, {
    PlatformThreadHook? threadHook,
    ExceptionManager? exceptionManager,
  }) : _$startReq = [size],
       super(
         $ShorBuildersActivator(Squadron.platformType),
         threadHook: threadHook,
         exceptionManager: exceptionManager,
       );

  // ignore: use_super_parameters
  ShorBuildersWorker.vm(
    this.size, {
    PlatformThreadHook? threadHook,
    ExceptionManager? exceptionManager,
  }) : _$startReq = [size],
       super(
         $ShorBuildersActivator(SquadronPlatformType.vm),
         threadHook: threadHook,
         exceptionManager: exceptionManager,
       );

  final List _$startReq;

  @override
  List? getStartArgs() => _$startReq;

  @override
  final int size;
}

/// Worker pool for ShorBuilders
base class ShorBuildersWorkerPool extends WorkerPool<ShorBuildersWorker>
    with _$ShorBuilders$Facade
    implements ShorBuilders {
  // ignore: use_super_parameters
  ShorBuildersWorkerPool(
    this.size, {
    PlatformThreadHook? threadHook,
    ExceptionManager? exceptionManager,
    ConcurrencySettings? concurrencySettings,
  }) : super(
         (ExceptionManager exceptionManager) => ShorBuildersWorker(
           size,
           threadHook: threadHook,
           exceptionManager: exceptionManager,
         ),
         concurrencySettings: concurrencySettings,
         exceptionManager: exceptionManager,
       );

  // ignore: use_super_parameters
  ShorBuildersWorkerPool.vm(
    this.size, {
    PlatformThreadHook? threadHook,
    ExceptionManager? exceptionManager,
    ConcurrencySettings? concurrencySettings,
  }) : super(
         (ExceptionManager exceptionManager) => ShorBuildersWorker.vm(
           size,
           threadHook: threadHook,
           exceptionManager: exceptionManager,
         ),
         concurrencySettings: concurrencySettings,
         exceptionManager: exceptionManager,
       );

  @override
  final int size;

  @override
  Future<ComplexMatrix> addGate(List<QbitAddress> qbits, int constant) =>
      execute((w) => w.addGate(qbits, constant));

  @override
  Future<void> clearCache() => execute((w) => w.clearCache());

  @override
  Future<ComplexMatrix> invQftGate(List<QbitAddress> qbits) =>
      execute((w) => w.invQftGate(qbits));

  @override
  Future<ComplexMatrix> qftGate(List<QbitAddress> qbits) =>
      execute((w) => w.qftGate(qbits));

  @override
  Future<ComplexMatrix> resetFlagGate(
    List<QbitAddress> qbits,
    QbitAddress flag,
  ) => execute((w) => w.resetFlagGate(qbits, flag));

  @override
  Future<ComplexMatrix> setFlagOnOverflowGate(
    List<QbitAddress> qbits,
    QbitAddress flag,
  ) => execute((w) => w.setFlagOnOverflowGate(qbits, flag));

  @override
  Future<ComplexMatrix> swapperGate(
    List<QbitAddress> qa,
    List<QbitAddress> qb,
  ) => execute((w) => w.swapperGate(qa, qb));
}

final class _$Deser extends MarshalingContext {
  _$Deser({super.contextAware});
  late final $0 = value<QbitAddress>();
  late final $1 = list<QbitAddress>($0);
  late final $2 = value<int>();
  late final $3 = value<ComplexMatrix>();
}
