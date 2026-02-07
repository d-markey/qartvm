import '../../qregister.dart';
import '../parser/ast_nodes.dart';
import '_gate_executor.dart';
import 'exceptions.dart';

/// Symbol table for tracking declared entities during OpenQASM interpretation.
///
/// Maintains mappings for:
/// - Quantum registers (qubits)
/// - Classical variables
/// - Gate definitions
/// - Subroutines
/// - Constants
///
/// Supports nested scopes for control flow blocks.
class SymbolTable {
  SymbolTable() : _scopes = [_Scope()];

  final List<_Scope> _scopes;

  /// Current scope (top of stack)
  _Scope get _currentScope => _scopes.last;

  /// Declares a quantum register with the given [name].
  void declareQubit(String name, QRegister register) {
    if (_currentScope.qubits.containsKey(name)) {
      throw SymbolTableException('Qubit register "$name" already declared');
    }
    _currentScope.qubits[name] = register;
  }

  /// Declares a classical variable with the given [name] and [value].
  void declareVariable(String name, dynamic value) {
    if (_currentScope.variables.containsKey(name)) {
      throw SymbolTableException('Variable "$name" already declared');
    }
    _currentScope.variables[name] = value;
  }

  /// Updates an existing variable's value.
  void updateVariable(String name, dynamic value) {
    // Search from current scope up to global
    for (var i = _scopes.length - 1; i >= 0; i--) {
      if (_scopes[i].variables.containsKey(name)) {
        _scopes[i].variables[name] = value;
        return;
      }
    }
    throw SymbolTableException('Variable "$name" not found');
  }

  /// Declares a gate definition with the given [name].
  void declareGate(String name, GateStatement gateDef) {
    if (_currentScope.gates.containsKey(name)) {
      throw SymbolTableException('Gate "$name" already declared');
    }
    _currentScope.gates[name] = gateDef;
  }

  /// Declares a subroutine definition with the given [name].
  void declareSubroutine(String name, SubroutineDefinition subroutine) {
    if (_currentScope.subroutines.containsKey(name)) {
      throw SymbolTableException('Subroutine "$name" already declared');
    }
    _currentScope.subroutines[name] = subroutine;
  }

  /// Declares a constant with the given [name] and [value].
  void declareConstant(String name, dynamic value) {
    if (_currentScope.constants.containsKey(name)) {
      throw SymbolTableException('Constant "$name" already declared');
    }
    _currentScope.constants[name] = value;
  }

  /// Registers a gate executor with the given [name].
  /// Gate executors are used to execute both built-in and custom gates.
  void registerGateExecutor(String name, GateExecutor executor) {
    if (_currentScope.executors.containsKey(name)) {
      throw SymbolTableException('Gate executor "$name" already registered');
    }
    _currentScope.executors[name] = executor;
  }

  /// Looks up a quantum register by [name].
  /// Returns null if not found.
  QRegister? lookupQubit(String name) {
    // Search from current scope up to global
    for (var i = _scopes.length - 1; i >= 0; i--) {
      if (_scopes[i].qubits.containsKey(name)) {
        return _scopes[i].qubits[name];
      }
    }
    return null;
  }

  /// Looks up a classical variable by [name].
  /// Returns null if not found.
  dynamic lookupVariable(String name) {
    // Search from current scope up to global
    for (var i = _scopes.length - 1; i >= 0; i--) {
      if (_scopes[i].variables.containsKey(name)) {
        return _scopes[i].variables[name];
      }
    }
    return null;
  }

  /// Looks up a gate definition by [name].
  /// Returns null if not found.
  GateStatement? lookupGate(String name) {
    // Search from current scope up to global
    for (var i = _scopes.length - 1; i >= 0; i--) {
      if (_scopes[i].gates.containsKey(name)) {
        return _scopes[i].gates[name];
      }
    }
    return null;
  }

  /// Looks up a subroutine definition by [name].
  /// Returns null if not found.
  SubroutineDefinition? lookupSubroutine(String name) {
    // Search from current scope up to global
    for (var i = _scopes.length - 1; i >= 0; i--) {
      if (_scopes[i].subroutines.containsKey(name)) {
        return _scopes[i].subroutines[name];
      }
    }
    return null;
  }

  /// Looks up a constant by [name].
  /// Returns null if not found.
  dynamic lookupConstant(String name) {
    // Search from current scope up to global
    for (var i = _scopes.length - 1; i >= 0; i--) {
      if (_scopes[i].constants.containsKey(name)) {
        return _scopes[i].constants[name];
      }
    }
    return null;
  }

  /// Looks up a gate executor by [name].
  /// Returns null if not found.
  GateExecutor? lookupGateExecutor(String name) {
    // Search from current scope up to global
    for (var i = _scopes.length - 1; i >= 0; i--) {
      if (_scopes[i].executors.containsKey(name)) {
        return _scopes[i].executors[name];
      }
    }
    return null;
  }

  /// Pushes a new scope onto the stack.
  /// Used when entering a block (if, for, while, function, etc.)
  void pushScope() {
    _scopes.add(_Scope());
  }

  /// Pops the current scope from the stack.
  /// Used when exiting a block.
  void popScope() {
    if (_scopes.length <= 1) {
      throw SymbolTableException('Cannot pop global scope');
    }
    _scopes.removeLast();
  }

  /// Clears the symbol table, resetting to a single empty global scope.
  void clear() {
    _scopes.clear();
    _scopes.add(_Scope());
  }

  /// Returns all qubit registers in the current scope hierarchy.
  Map<String, QRegister> getAllQubits() {
    final result = <String, QRegister>{};
    // Merge from global to current, allowing shadowing
    for (var scope in _scopes) {
      result.addAll(scope.qubits);
    }
    return result;
  }

  /// Returns all variables in the current scope hierarchy.
  Map<String, dynamic> getAllVariables() {
    final result = <String, dynamic>{};
    // Merge from global to current, allowing shadowing
    for (var scope in _scopes) {
      result.addAll(scope.variables);
    }
    return result;
  }
}

/// Internal scope representation.
class _Scope {
  final Map<String, QRegister> qubits = {};
  final Map<String, dynamic> variables = {};
  final Map<String, GateStatement> gates = {};
  final Map<String, SubroutineDefinition> subroutines = {};
  final Map<String, dynamic> constants = {};
  final Map<String, GateExecutor> executors = {};
}
