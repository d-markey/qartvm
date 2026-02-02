import 'package:test/test.dart';
import 'package:qartvm/qartvm.dart';

void main() {
  group('OpenQASM Interpreter - Gate Execution', () {
    late OpenQASMInterpreter interpreter;

    setUp(() {
      interpreter = OpenQASMInterpreter();
    });

    test('should execute Hadamard gate', () {
      final source = '''
OPENQASM 3.0;
qubit q;
h q;
''';
      final program = OpenQASMParser.parse(source);
      final result = interpreter.execute(program);

      // After H gate on |0⟩, expect equal superposition
      // |0⟩ + |1⟩ / sqrt(2)
      expect(result.quantumMemory, isNotNull);
      final qmem = result.quantumMemory!;
      expect(qmem.size, equals(1));

      // Check probabilities: both |0⟩ and |1⟩ should be ~0.5
      final prob0 = qmem.getPropability('0');
      final prob1 = qmem.getPropability('1');
      expect(prob0, closeTo(0.5, 0.001));
      expect(prob1, closeTo(0.5, 0.001));
    });

    test('should execute Pauli-X gate', () {
      final source = '''
OPENQASM 3.0;
qubit q;
x q;
''';
      final program = OpenQASMParser.parse(source);
      final result = interpreter.execute(program);

      // X gate flips |0⟩ to |1⟩
      expect(result.quantumMemory, isNotNull);
      final qmem = result.quantumMemory!;

      final prob0 = qmem.getPropability('0');
      final prob1 = qmem.getPropability('1');
      expect(prob0, closeTo(0.0, 0.001));
      expect(prob1, closeTo(1.0, 0.001));
    });

    test('should execute parameterized RX gate', () {
      final source = '''
OPENQASM 3.0;
qubit q;
rx(pi/2) q;
''';
      final program = OpenQASMParser.parse(source);
      final result = interpreter.execute(program);

      // RX(π/2) creates superposition with different phases
      expect(result.quantumMemory, isNotNull);
      final qmem = result.quantumMemory!;

      // Both states should have equal probability
      final prob0 = qmem.getPropability('0');
      final prob1 = qmem.getPropability('1');
      expect(prob0, closeTo(0.5, 0.001));
      expect(prob1, closeTo(0.5, 0.001));
    });

    test('should execute CNOT gate', () {
      final source = '''
OPENQASM 3.0;
qubit[2] q;
x q[0];
cx q[0], q[1];
''';
      final program = OpenQASMParser.parse(source);
      final result = interpreter.execute(program);

      // Starting with |00⟩
      // X on q[0] gives |10⟩
      // CNOT(q[0], q[1]) flips q[1] because q[0]=1, giving |11⟩
      expect(result.quantumMemory, isNotNull);
      final qmem = result.quantumMemory!;
      expect(qmem.size, equals(2));

      final prob00 = qmem.getPropability('00');
      final prob11 = qmem.getPropability('11');
      expect(prob00, closeTo(0.0, 0.001));
      expect(prob11, closeTo(1.0, 0.001));
    });

    test('should create Bell state (EPR pair)', () {
      final source = '''
OPENQASM 3.0;
qubit[2] q;
h q[0];
cx q[0], q[1];
''';
      final program = OpenQASMParser.parse(source);
      final result = interpreter.execute(program);

      // Bell state: (|00⟩ + |11⟩) / sqrt(2)
      expect(result.quantumMemory, isNotNull);
      final qmem = result.quantumMemory!;
      expect(qmem.size, equals(2));

      // Check probabilities: |00⟩ and |11⟩ should each be 0.5
      // |01⟩ and |10⟩ should be 0
      final prob00 = qmem.getPropability('00');
      final prob01 = qmem.getPropability('01');
      final prob10 = qmem.getPropability('10');
      final prob11 = qmem.getPropability('11');

      expect(prob00, closeTo(0.5, 0.001));
      expect(prob01, closeTo(0.0, 0.001));
      expect(prob10, closeTo(0.0, 0.001));
      expect(prob11, closeTo(0.5, 0.001));
    });

    test('should execute multiple gates in sequence', () {
      final source = '''
OPENQASM 3.0;
qubit q;
h q;
z q;
h q;
''';
      final program = OpenQASMParser.parse(source);
      final result = interpreter.execute(program);

      // H - Z - H sequence on |0⟩
      // H: |+⟩
      // Z: |-⟩
      // H: |1⟩
      expect(result.quantumMemory, isNotNull);
      final qmem = result.quantumMemory!;

      final prob0 = qmem.getPropability('0');
      final prob1 = qmem.getPropability('1');
      expect(prob0, closeTo(0.0, 0.001));
      expect(prob1, closeTo(1.0, 0.001));
    });

    test('should handle gate with expression parameter', () {
      final source =
          'OPENQASM 3.0;\n'
          'qubit q;\n'
          'float a = pi / 4;\n'
          'rx(a * 2) q;';
      final program = OpenQASMParser.parse(source);
      final result = interpreter.execute(program);

      // RX(π/2) since a*2 = π/4 * 2 = π/2
      expect(result.quantumMemory, isNotNull);
      final qmem = result.quantumMemory!;

      final prob0 = qmem.getPropability('0');
      final prob1 = qmem.getPropability('1');
      expect(prob0, closeTo(0.5, 0.001));
      expect(prob1, closeTo(0.5, 0.001));
    });

    test('should execute gates on register subset', () {
      final source = '''
OPENQASM 3.0;
qubit[3] q;
h q[0];
h q[2];
''';
      final program = OpenQASMParser.parse(source);
      final result = interpreter.execute(program);

      // H on q[0] and q[2], q[1] remains |0⟩
      expect(result.quantumMemory, isNotNull);
      final qmem = result.quantumMemory!;
      expect(qmem.size, equals(3));

      // Should have 4 non-zero states: |000⟩, |001⟩, |100⟩, |101⟩
      // Each with probability 0.25
      expect(qmem.getPropability('000'), closeTo(0.25, 0.001));
      expect(qmem.getPropability('001'), closeTo(0.25, 0.001));
      expect(qmem.getPropability('010'), closeTo(0.0, 0.001));
      expect(qmem.getPropability('011'), closeTo(0.0, 0.001));
      expect(qmem.getPropability('100'), closeTo(0.25, 0.001));
      expect(qmem.getPropability('101'), closeTo(0.25, 0.001));
      expect(qmem.getPropability('110'), closeTo(0.0, 0.001));
      expect(qmem.getPropability('111'), closeTo(0.0, 0.001));
    });

    test('should execute Y and Z gates', () {
      final source = '''
OPENQASM 3.0;
qubit[2] q;
y q[0];
z q[1];
''';
      final program = OpenQASMParser.parse(source);
      final result = interpreter.execute(program);

      // Y gate on |0⟩ gives i|1⟩ (flips with phase)
      // Z gate on |0⟩ gives |0⟩ (no change for |0⟩)
      expect(result.quantumMemory, isNotNull);
      final qmem = result.quantumMemory!;

      // Final state should be |10⟩ with phase
      final prob10 = qmem.getPropability('10');
      expect(prob10, closeTo(1.0, 0.001));
    });

    test('should execute S and T gates', () {
      final source = '''
OPENQASM 3.0;
qubit q;
h q;
s q;
''';
      final program = OpenQASMParser.parse(source);
      final result = interpreter.execute(program);

      // H creates |+⟩, S adds phase to |1⟩ component
      // Still equal probabilities but different phases
      expect(result.quantumMemory, isNotNull);
      final qmem = result.quantumMemory!;

      final prob0 = qmem.getPropability('0');
      final prob1 = qmem.getPropability('1');
      expect(prob0, closeTo(0.5, 0.001));
      expect(prob1, closeTo(0.5, 0.001));
    });
  });
}
