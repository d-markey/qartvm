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
import 'shor_algorithm.dart' as _shor_algorithm;

// runs all examples
void main(List<String> args) {
  final pause = args.contains('pause');

  print('=================== MATRIX INVERSION ===================');
  print('');
  _matrix_inversion.main();
  print('');
  if (pause) {
    stdin.readLineSync();
  }

  print('=================== SUPERPOSITION ===================');
  print('');
  _superposition.main();
  print('');
  if (pause) {
    stdin.readLineSync();
  }

  print('=================== BELL STATE ===================');
  print('');
  _bell_state.main();
  print('');
  if (pause) {
    stdin.readLineSync();
  }

  print('=================== QUBIT FULL ADDER ===================');
  print('');
  _one_qubit_full_adder.main();
  print('');
  if (pause) {
    stdin.readLineSync();
  }

  print('=================== TWO-QUBIT FULL ADDER ===================');
  print('');
  _two_qubit_full_adder.main();
  print('');
  if (pause) {
    stdin.readLineSync();
  }

  print('=================== THREE-QUBIT FULL ADDER ===================');
  print('');
  _three_qubit_full_adder.main();
  print('');
  if (pause) {
    stdin.readLineSync();
  }

  print('=================== MULTI-CONTROLLED SWAP GATE ===================');
  print('');
  _multi_controlled_swap.main();
  print('');
  if (pause) {
    stdin.readLineSync();
  }

  print('=================== QUBIT TELEPORTATION ===================');
  print('');
  _qubit_teleportation.main();
  print('');
  if (pause) {
    stdin.readLineSync();
  }

  print('=================== FREDKIN IMPLEMENTATION ===================');
  print('');
  _fredkin_implementation.main();
  print('');
  if (pause) {
    stdin.readLineSync();
  }

  print('=================== INVERSE QFT DECODER ===================');
  print('');
  _inverse_qft_decoder.main(['8', '16', '5']);
  print('');
  if (pause) {
    stdin.readLineSync();
  }

  print('=================== SHOR ALGORITH ===================');
  print('');
  _shor_algorithm.main();
  print('');
  if (pause) {
    stdin.readLineSync();
  }
}
