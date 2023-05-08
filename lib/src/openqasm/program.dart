import 'ast/ast_node.dart';
import 'parser/openqasm_parser.dart';

class Program extends AstNodeList<AstStatement> {
  static Program parse(String code, OpenQAsmParser parser) =>
      parser.parse(code);
}
