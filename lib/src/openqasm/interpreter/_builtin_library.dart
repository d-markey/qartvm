import 'dart:math' as math;

/// Built-in constants and functions for OpenQASM 3.0.
class BuiltinLibrary {
  static const Map<String, double> constants = {
    'pi': math.pi,
    'π': math.pi,
    'euler': math.e,
    'ℇ': math.e,
    'tau': 2 * math.pi,
    'τ': 2 * math.pi,
  };

  static final Map<String, Function> functions = {
    'sin': math.sin,
    'cos': math.cos,
    'tan': math.tan,
    'asin': math.asin,
    'arcsin': math.asin,
    'acos': math.acos,
    'arccos': math.acos,
    'atan': math.atan,
    'arctan': math.atan,
    'exp': math.exp,
    'ln': math.log,
    'log': math.log,
    'sqrt': math.sqrt,
    'pow': math.pow,
    'abs': (num x) => x.abs(),
    'ceil': (num x) => x.ceil().toDouble(),
    'floor': (num x) => x.floor().toDouble(),
    'round': (num x) => x.round().toDouble(),
    'mod': (num x, num y) => x % y,
    'min': math.min,
    'max': math.max,
  };

  /// Returns true if [name] is a built-in constant.
  static bool isConstant(String name) => constants.containsKey(name);

  /// Returns true if [name] is a built-in function.
  static bool isFunction(String name) => functions.containsKey(name);

  /// Gets the value of a built-in constant.
  static double? getConstant(String name) => constants[name];

  /// Gets a built-in function.
  static Function? getFunction(String name) => functions[name];
}
