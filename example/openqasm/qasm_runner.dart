import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:qartvm/qartvm.dart';

void main(List<String> args) async {
  String? path;
  final inputVariables = <String, dynamic>{};
  bool showProbabilities = false;

  for (int i = 0; i < args.length; i++) {
    final arg = args[i];
    if (arg.startsWith('--var:')) {
      final parts = arg.substring(6).split('=');
      if (parts.length == 2) {
        inputVariables[parts[0]] = _parseValue(parts[1]);
      }
    } else if (arg == '--show-probabilities') {
      showProbabilities = true;
    } else if (!arg.startsWith('--') && path == null) {
      path = arg;
    }
  }

  if (path == null) {
    throw Exception(
      'Missing path argument. Usage: dart run example/openqasm/qasm_runner.dart <file.qasm> [--var:name=value] [--show-probabilities]',
    );
  }

  var file = File(path);
  if (!await file.exists()) {
    final scriptPath = Platform.script.toFilePath();
    final scriptDir = File(scriptPath).parent;
    file = File(p.join(scriptDir.path, path));
    if (!await file.exists()) {
      throw Exception('File "$path" not found.');
    }
  }

  final code = await file.readAsString();
  final program = OpenQASMParser.parse(code);

  final interpreter = OpenQASMInterpreter()
    ..addObserver((step, statement, qmem) {
      // Add observer to dump probabilities before measurement
      if (showProbabilities && _isMeasurement(statement)) {
        print(
          '\nProbabilities before measurement (${statement.source.code.trim()}):',
        );
        final probs = qmem.probabilities;
        final sortedKeys = probs.keys.toList()..sort();
        for (final key in sortedKeys) {
          final p = probs[key]!;
          if (p > 0.000001) {
            print(
              '  ${qmem.formatState(key)}: ${(p * 100).toStringAsFixed(2)}%',
            );
          }
        }
      }
    });

  final results = await interpreter.execute(
    program,
    inputVariables: inputVariables,
  );
  for (final res in results) {
    print(res);
  }
}

bool _isMeasurement(Statement stmt) {
  if (stmt is MeasurementStatement) return true;
  if (stmt is AssignmentStatement && stmt.value is MeasureExpression) {
    return true;
  }
  if (stmt is ClassicalDeclaration && stmt.initializer is MeasureExpression) {
    return true;
  }
  return false;
}

dynamic _parseValue(String v) {
  if (v.toLowerCase() == 'true') return true;
  if (v.toLowerCase() == 'false') return false;
  return int.tryParse(v) ?? double.tryParse(v) ?? v;
}
