import 'package:antlr4/antlr4.dart';
import 'antlr4/parser/OpenQASM3Lexer.dart';
import 'antlr4/parser/OpenQASM3Parser.dart';
import 'parser/ast_nodes.dart';
import 'parser/_ast_builder.dart';

class OpenQASMParser {
  /// Parses an OpenQASM 3 program from a String and returns the AST.
  static Program parse(String source) {
    final inputStream = InputStream.fromString(source);
    final lexer = OpenQASM3Lexer(inputStream);
    final tokenStream = CommonTokenStream(lexer);
    final parser = OpenQASM3Parser(tokenStream);

    // Add error listeners if needed
    // parser.addErrorListener(DiagnosticErrorListener());

    final tree = parser.program();
    final builder = AstBuilder();
    return builder.visitProgram(tree) as Program;
  }
}
