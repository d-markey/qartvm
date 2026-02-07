import 'package:qartvm/qartvm.dart';

/// Example demonstrating how to use the OpenQASM include statement
/// with different providers.

void main() async {
  // Example 1: Using the default StandardGatesProvider
  // This provider automatically supports 'include "stdgates.inc";'
  print('Example 1: Using StandardGatesProvider (default)');
  await example1();

  print('\n' + '=' * 60 + '\n');

  // Example 2: Using a custom in-memory provider
  print('Example 2: Using MemoryIncludeProvider');
  await example2();

  print('\n' + '=' * 60 + '\n');
}

/// Example 1: Default behavior with StandardGatesProvider
Future<void> example1() async {
  const source = '''
OPENQASM 3;
include "stdgates.inc";

qubit[2] q;
bit[2] result;

h q[0];
h q[1];
measure q -> result;
''';

  final program = OpenQASMParser.parse(source);

  // Create interpreter with default StandardGatesProvider
  final interpreter = OpenQASMInterpreter();

  final result = await interpreter.execute(program);
  print('Execution successful!');
  print('Qubits: ${result.quantumMemory?.size ?? 0}');
}

/// Example 2: Custom in-memory include files
Future<void> example2() async {
  const source = '''
OPENQASM 3;
include "custom_gates.inc";

qubit q;
custom_gate q;
''';

  // Define custom gates in-memory
  final customGates = '''
gate custom_gate q { 
  h q; 
  x q;
}
''';

  final provider = MemoryIncludeProvider({'custom_gates.inc': customGates});

  final program = OpenQASMParser.parse(source);
  final interpreter = OpenQASMInterpreter(includeProvider: provider);

  final result = await interpreter.execute(program);
  print('Custom gates execution successful!');
}

/// A composite provider that tries multiple providers in order.
/// This allows combining different include file sources.
class CompositeIncludeProvider implements OpenQASMIncludeProvider {
  final List<OpenQASMIncludeProvider> providers;

  CompositeIncludeProvider(this.providers);

  @override
  Future<String> loadIncludeFile(String filename) async {
    for (final provider in providers) {
      try {
        return await provider.loadIncludeFile(filename);
      } on IncludeException {
        // Try the next provider
        continue;
      }
    }

    // No provider could load the file
    throw IncludeException(
      'File not found in any provider',
      filename: filename,
    );
  }
}

/// Simple in-memory provider for the example
class MemoryIncludeProvider implements OpenQASMIncludeProvider {
  final Map<String, String> files;

  MemoryIncludeProvider(this.files);

  @override
  Future<String> loadIncludeFile(String filename) async {
    final contents = files[filename];

    if (contents == null) {
      throw IncludeException('File not found', filename: filename);
    }

    return contents;
  }
}
