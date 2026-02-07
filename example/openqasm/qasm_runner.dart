import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:qartvm/qartvm.dart';

void main(List<String> args) async {
  final path = args.singleOrNull;
  if (path == null) {
    throw Exception('Missing path argument.');
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
  final interpreter = OpenQASMInterpreter();
  final res = await interpreter.execute(program);
  print(res);
}
