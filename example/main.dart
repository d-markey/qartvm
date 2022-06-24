import 'dart:async';
import 'dart:io';

import 'matrix_inversion.dart' as _matrix_inversion;
import 'superposition.dart' as _superposition;
import 'bell_state.dart' as _bell_state;
import 'one_qubit_full_adder.dart' as _one_qubit_full_adder;
import 'two_qubit_full_adder.dart' as _two_qubit_full_adder;
import 'three_qubit_full_adder.dart' as _three_qubit_full_adder;
import 'multi_controlled_swap.dart' as _multi_controlled_swap;
import 'qubit_teleportation.dart' as _qubit_teleportation;
import 'fredkin_implementation.dart' as _fredkin_implementation;
import 'inverse_qft_decoder.dart' as _inverse_qft_decoder;
import 'phase_kickback.dart' as _phase_kickback;
import 'modulo_multiplier.dart' as _modulo_multiplier;
import 'shor_algorithm.dart' as _shor_algorithm;

final programs = <String, FutureOr Function()>{
  'MATRIX INVERSION': _matrix_inversion.main,
  'SUPERPOSITION': _superposition.main,
  'BELL STATE': _bell_state.main,
  '1-QUBIT FULL ADDER': _one_qubit_full_adder.main,
  '2-QUBIT FULL ADDER': _two_qubit_full_adder.main,
  '3-QUBIT FULL ADDER': _three_qubit_full_adder.main,
  'MULTI-CONTROLLED SWAP': _multi_controlled_swap.main,
  'QUBIT TELEPORTATION': _qubit_teleportation.main,
  'FREDKIN GATE': _fredkin_implementation.main,
  'INVERSE QFT': _inverse_qft_decoder.main,
  'PHASE KICKBACK': _phase_kickback.main,
  'MODULO MULTIPLIER': _modulo_multiplier.main,
  'SHOR ALGORITHM': _shor_algorithm.main,
};

// runs all examples
void main(List<String> args) async {
  args = args.toList();
  final pause = args.contains('pause');
  args.removeWhere((a) => a == 'pause');

  var executed = 0;
  var skipped = 0;
  var failed = 0;

  for (var entry in programs.entries) {
    var exec = args.isEmpty;
    for (var i = 0; i < args.length; i++) {
      if (RegExp(args[i], caseSensitive: false).hasMatch(entry.key)) {
        exec = true;
        break;
      }
    }
    if (exec) {
      print('=================== ${entry.key} ===================');
      print('');
      try {
        executed++;
        final res = entry.value();
        if (res is Future) {
          await res;
        }
      } catch (ex, st) {
        failed++;
        print('FAILED! $ex');
        print(st);
        break;
      }
      print('');
      if (pause) {
        stdin.readLineSync();
      }
    } else {
      skipped++;
      print('=================== ${entry.key} ===================');
      print('Skipped');
      print('');
    }
  }

  print(
      'Executed $executed ${executed > 1 ? 'programs' : 'program'}, $failed failed, $skipped skipped');
}
