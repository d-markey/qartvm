import '../parser/ast_nodes.dart';
import '_symbol_table.dart';
import '../../qmemory_space.dart';
import '../../qregister.dart';
import '../../qcircuit.dart';
import '../../qgate_builder.dart';
import 'exceptions.dart';

/// Execution context for OpenQASM program interpretation.
///
/// Maintains all runtime state including:
/// - Symbol table for variables, registers, gates
/// - Quantum memory space
/// - Quantum circuit (optional, for deferred execution)
/// - Classical variable storage
class ExecutionContext {
  ExecutionContext({this.quantumMemory, this.circuit})
    : symbols = SymbolTable(),
      _qubitCounter = 0;

  /// Symbol table tracking all declared entities.
  final SymbolTable symbols;

  /// Quantum memory space for storing qubit states.
  /// If null, memory will be created lazily when needed.
  QMemorySpace? quantumMemory;

  /// Optional quantum circuit for building gates before execution.
  /// If provided, gates are added to the circuit instead of applied immediately.
  QCircuit? circuit;

  /// Counter for allocating qubit addresses.
  int _qubitCounter;

  /// Declares a quantum register with the given [name] and [size].
  /// Allocates qubits in the quantum memory space.
  QRegister declareQubitRegister(String name, int size) {
    // Allocate qubit addresses
    final addresses = List.generate(size, (i) => _qubitCounter++);

    // Ensure quantum memory exists and has enough capacity
    _ensureQuantumMemory(_qubitCounter);

    // Create register
    final register = QRegisterImpl.ctor(name, quantumMemory!, addresses);

    // Store in symbol table
    symbols.declareQubit(name, register);

    return register;
  }

  /// Declares a classical variable with the given [name], [type], and optional [value].
  void declareClassicalVariable(String name, TypeNode type, [dynamic value]) {
    // Initialize with default value if not provided
    value ??= _getDefaultValue(type);
    symbols.declareVariable(name, value);
  }

  /// Updates a classical variable's value.
  void updateVariable(String name, dynamic value) {
    symbols.updateVariable(name, value);
  }

  /// Gets a quantum register by [name].
  /// Throws if not found.
  QRegister getQubitRegister(String name) {
    final register = symbols.lookupQubit(name);
    if (register == null) {
      throw ExecutionException('Qubit register "$name" not found');
    }
    return register;
  }

  /// Gets a classical variable by [name].
  /// Throws if not found.
  dynamic getVariable(String name) {
    final value = symbols.lookupVariable(name);
    if (value == null) {
      // Check if it's a constant
      final constValue = symbols.lookupConstant(name);
      if (constValue != null) return constValue;
      throw ExecutionException('Variable "$name" not found');
    }
    return value;
  }

  /// Enters a new scope (for blocks, loops, functions).
  void pushScope() {
    symbols.pushScope();
  }

  /// Exits the current scope.
  void popScope() {
    symbols.popScope();
  }

  /// Resets the context for a new execution pass.
  /// Clears symbols and qubit counter, but preserves the quantum memory if already created.
  void resetForExecution() {
    symbols.clear();
    _qubitCounter = 0;
  }

  /// Ensures quantum memory exists with at least [minSize] qubits.
  void _ensureQuantumMemory(int minSize) {
    if (quantumMemory == null) {
      quantumMemory = QMemorySpace.zero(minSize);
    } else if (quantumMemory!.size < minSize) {
      // Need to expand quantum memory - this is not supported
      throw ExecutionException(
        'Cannot expand quantum memory after initialization. '
        'Declare all qubits at the beginning of the program.',
      );
    }
  }

  /// Creates a quantum circuit with the current number of qubits.
  QCircuit createCircuit() {
    if (_qubitCounter == 0) {
      throw ExecutionException('No qubits declared yet');
    }
    return QCircuit(QGateBuilder.get(_qubitCounter));
  }

  /// Gets default value for a given type.
  dynamic _getDefaultValue(TypeNode type) {
    if (type is ScalarTypeNode) {
      switch (type.name) {
        case 'bit':
          return 0;
        case 'int':
        case 'uint':
          return 0;
        case 'float':
          return 0.0;
        case 'bool':
          return false;
        case 'angle':
          return 0.0;
        default:
          return null;
      }
    } else if (type is ArrayTypeNode) {
      // Create empty list for arrays
      return [];
    } else if (type is ComplexTypeNode) {
      // Default complex value
      return {'re': 0.0, 'im': 0.0};
    }
    return null;
  }

  /// Returns all classical variables.
  Map<String, dynamic> getAllVariables() {
    return symbols.getAllVariables();
  }

  /// Returns all quantum registers.
  Map<String, QRegister> getAllQubits() {
    return symbols.getAllQubits();
  }
}
