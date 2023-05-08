import '../program.dart';

import 'openqasm_parser_context.dart';

class OpenQAsmParser {
  OpenQAsmParser({this.trace = false});

  bool trace;

  Program parse(String code) {
    final context = OpenQAsmParserContext(code, trace);
    final program = Program();
    program.addAll(context.statements);
    program.comments.addAll(context.comments);
    return program;
  }
}
