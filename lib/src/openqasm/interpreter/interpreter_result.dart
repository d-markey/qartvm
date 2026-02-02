import '../../qmemory_space.dart';

/// Result of executing an OpenQASM program.
///
/// Contains the final quantum state, classical variables, and measurement results.
class InterpreterResult {
  InterpreterResult({
    this.quantumMemory,
    required this.classicalVariables,
    required this.measurements,
  });

  /// Final quantum memory state after execution.
  /// Null if no qubits were declared in the program.
  final QMemorySpace? quantumMemory;

  /// Map of classical variable names to their values.
  final Map<String, dynamic> classicalVariables;

  /// Map of measurement results (qubit/register name to measured value).
  final Map<String, int> measurements;

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln('OpenQASM Execution Result:');
    buffer.writeln('========================');

    // Quantum state
    if (quantumMemory != null) {
      buffer.writeln('\nQuantum State:');
      buffer.writeln('  Qubits: ${quantumMemory!.size}');
      // Show probability distribution
      if (quantumMemory!.size > 0 && quantumMemory!.size <= 10) {
        buffer.writeln('  Amplitudes: ${quantumMemory!.amplitudes}');
      }
    } else {
      buffer.writeln('\nQuantum State: None (no qubits declared)');
    }

    // Classical variables
    if (classicalVariables.isNotEmpty) {
      buffer.writeln('\nClassical Variables:');
      for (var entry in classicalVariables.entries) {
        buffer.writeln('  ${entry.key} = ${entry.value}');
      }
    }

    // Measurements
    if (measurements.isNotEmpty) {
      buffer.writeln('\nMeasurements:');
      for (var entry in measurements.entries) {
        buffer.writeln('  ${entry.key} = ${entry.value}');
      }
    }

    return buffer.toString();
  }

  /// Returns a concise summary of the result.
  String toSummary() {
    return 'Result: ${quantumMemory?.size ?? 0} qubits, '
        '${classicalVariables.length} variables, '
        '${measurements.length} measurements';
  }
}
