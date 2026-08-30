import 'package:antlr4/antlr4.dart';

part 'expressions.dart';
part 'statements.dart';
part 'types.dart';

class Source {
  const Source(this.text, this.line);

  final String text;
  final int? line;

  Source.fromContext(ParserRuleContext context)
    : this(context.text, context.start?.line);

  @override
  String toString() => (line == null) ? '`$text`' : 'line $line: `$text`';
}

abstract class OpenQASMNode {
  const OpenQASMNode._(this.source);

  final Source source;
}

class Program extends OpenQASMNode {
  final Version? version;
  final List<Statement> statements;

  Program(super.source, this.version, this.statements) : super._();
}

class Argument extends OpenQASMNode {
  final TypeNode type;
  final String name;

  Argument(super.source, this.type, this.name) : super._();
}

class Version extends OpenQASMNode {
  final String version;

  Version(super.source, this.version) : super._();
}

class GateModifier extends OpenQASMNode {
  final String type; // inv, pow, ctrl, negctrl
  final Expression? expression;

  GateModifier(super.source, this.type, this.expression) : super._();
}
