import 'package:antlr4/antlr4.dart';
import 'package:qartvm/src/openqasm/parser/_eval.dart';

import '../../qstate.dart';

part 'expressions.dart';
part 'statements.dart';
part 'types.dart';

extension on ParseTree {
  String get code {
    final s = <String>[];
    for (var i = 0; i < childCount; i++) {
      s.add(getChild(i)?.code ?? '');
    }
    return s.isEmpty ? (text ?? '') : s.join(' ');
  }
}

class Source {
  const Source(this.code, this.line);

  final String code;
  final int? line;

  Source.fromContext(ParserRuleContext context)
    : this(context.code, context.start?.line);

  @override
  String toString() => (line == null) ? '`$code`' : 'line $line: `$code`';
}

abstract class OpenQASMNode {
  const OpenQASMNode._(this.source);

  final Source source;

  T _traceOptimization<T extends OpenQASMNode>(T node) {
    //     print('''
    // $runtimeType has been optimized to ${node.runtimeType}
    // <<<<<<<<
    // $source
    // ========
    // ${node.source}
    // >>>>>>>>
    // ''');
    return node;
  }
}

class Program extends OpenQASMNode {
  final Version? version;
  final List<Statement> statements;

  Program(super.source, this.version, this.statements) : super._();

  bool optimize() {
    final optimized = Statement.tryOptimize(statements);
    if (optimized == null) return false;
    statements.clear();
    statements.addAll(optimized);
    return true;
  }
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

enum Modifier { inv, pow, ctrl, negctrl }

class GateModifier extends OpenQASMNode {
  final Modifier? type; // inv, pow, ctrl, negctrl
  final Expression? expression;

  GateModifier(super.source, this.type, this.expression) : super._();

  GateModifier optimize() {
    final expr = expression?.optimize();
    return (expr != expression)
        ? _traceOptimization(GateModifier(source, type, expr))
        : this;
  }

  static List<GateModifier>? tryOptimize(List<GateModifier>? modifiers) {
    if (modifiers == null) return null;
    List<GateModifier>? optimized;
    final len = modifiers.length;
    for (var i = 0; i < len; i++) {
      final mod = modifiers[i], omod = mod.optimize();
      if (optimized == null && omod != mod) {
        optimized = (i == 0) ? [] : modifiers.take(i - 1).toList();
      }
      if (optimized != null) {
        optimized.add(omod);
      }
    }
    return optimized;
  }
}
