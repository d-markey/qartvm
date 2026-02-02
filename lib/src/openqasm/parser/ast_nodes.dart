part 'types.dart';
part 'expressions.dart';
part 'statements.dart';

abstract class OpenQASMNode {
  const OpenQASMNode._();
}

class Program extends OpenQASMNode {
  final Version? version;
  final List<Statement> statements;

  Program(this.version, this.statements) : super._();
}

class Argument extends OpenQASMNode {
  final TypeNode type;
  final String name;

  Argument(this.type, this.name) : super._();
}

class Version extends OpenQASMNode {
  final String version;

  Version(this.version) : super._();
}

class GateModifier extends OpenQASMNode {
  final String type; // inv, pow, ctrl, negctrl
  final Expression? expression;

  GateModifier(this.type, this.expression) : super._();
}
