// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// Generator: WorkerGenerator 9.3.2 (Squadron 7.4.3)
// **************************************************************************

import 'package:squadron/squadron.dart';

import 'shor_builders.dart';

void _start$ShorBuilders(WorkerRequest command) {
  /// VM entry point for ShorBuilders
  run($ShorBuildersInitializer, command);
}

EntryPoint $getShorBuildersActivator(SquadronPlatformType platform) {
  if (platform.isVm) {
    return _start$ShorBuilders;
  } else {
    throw UnsupportedError('${platform.label} not supported.');
  }
}
