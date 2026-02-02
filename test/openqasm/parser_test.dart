import 'package:test/test.dart';
import 'package:qartvm/qartvm.dart';

void main() {
  group('OpenQASMParser', () {
    test('should parse a simple program', () {
      final source = '''
OPENQASM 3.0;
include "stdgates.inc";
qubit[2] q;
bit[2] c;
h q[0];
cx q[0], q[1];
c = measure q;
''';
      final program = OpenQASMParser.parse(source);

      expect(program.version?.version, equals('3.0'));
      expect(program.statements.length, greaterThan(0));

      final include = program.statements[0] as IncludeStatement;
      expect(include.filename, equals('stdgates.inc'));

      final qset = program.statements[1] as QubitDeclaration;
      expect(qset.name, equals('q'));

      final cset = program.statements[2] as ClassicalDeclaration;
      expect(cset.name, equals('c'));
      expect(cset.type, isA<ScalarTypeNode>());
      expect((cset.type as ScalarTypeNode).name, equals('bit'));
    });

    test('should parse gate definition', () {
      final source = '''
OPENQASM 3.0;
gate bell q0, q1 {
  h q0;
  cx q0, q1;
}
''';
      final program = OpenQASMParser.parse(source);
      final gateDef = program.statements[0] as GateStatement;
      expect(gateDef.name, equals('bell'));
      expect(gateDef.qubits, equals(['q0', 'q1']));
      expect(gateDef.body.length, equals(2));
    });

    test('should parse control flow', () {
      final source = '''
OPENQASM 3.0;
if (flag == true) {
  h q;
} else {
  x q;
}
for int i in [0:2] {
  cx q[i], q[i+1];
}
while (count < 10) {
  tick();
  if (done) break;
}
''';
      final program = OpenQASMParser.parse(source);
      expect(program.statements.length, 3);
      expect(program.statements[0], isA<IfStatement>());
      expect(program.statements[1], isA<ForStatement>());
      expect(program.statements[2], isA<WhileStatement>());

      final ifStmt = program.statements[0] as IfStatement;
      expect(ifStmt.elseBody, isNotNull);
      expect(ifStmt.ifBody.length, 1);
      expect(ifStmt.elseBody!.length, 1);

      final forStmt = program.statements[1] as ForStatement;
      expect(forStmt.loopVariable, 'i');
      expect(forStmt.variableType.name, 'int');
      expect(forStmt.range, isA<RangeExpression>());

      final whileStmt = program.statements[2] as WhileStatement;
      expect(whileStmt.body.length, 2);
      expect(whileStmt.body[1], isA<IfStatement>());
      final innerIf = whileStmt.body[1] as IfStatement;
      expect(innerIf.ifBody[0], isA<BreakStatement>());
    });
    test('should parse complex indexing', () {
      final source = '''
OPENQASM 3.0;
h q[0:2];
cx q[0, 1], q[1, 2];
h q[{0, 2, 4}];
''';
      final program = OpenQASMParser.parse(source);
      expect(program.statements.length, 3);

      // h q[0:2];
      final h1 = program.statements[0] as GateCallStatement;
      expect(h1.qubits[0], isA<IndexExpression>());
      final q0_2 = h1.qubits[0] as IndexExpression;
      expect(q0_2.expression, isA<IdentifierExpression>());
      expect((q0_2.expression as IdentifierExpression).name, 'q');
      expect(q0_2.indices[0], isA<RangeExpression>());

      // cx q[0, 1], q[1, 2];
      final cx = program.statements[1] as GateCallStatement;
      expect(cx.qubits[0], isA<IndexExpression>());
      expect((cx.qubits[0] as IndexExpression).indices.length, 2);

      // h q[{0, 2, 4}];
      final h2 = program.statements[2] as GateCallStatement;
      expect(h2.qubits[0], isA<IndexExpression>());
      expect(
        (h2.qubits[0] as IndexExpression).indices[0],
        isA<SetExpression>(),
      );
    });

    test('should parse bitwise and logical expressions', () {
      final source = '''
OPENQASM 3.0;
bool b = (x > 0) && (y < 10) || !flag;
int i = (a & b) | (c ^ d) << 2;
float f = float(i) * 2.0;
duration d = durationof({ h q; });
''';
      final program = OpenQASMParser.parse(source);
      expect(program.statements.length, 4);

      // Logical
      final s1 = program.statements[0] as ClassicalDeclaration;
      expect(s1.initializer, isA<BinaryExpression>());
      final logExpr = s1.initializer as BinaryExpression;
      expect(logExpr.operator, equals('||'));

      // Bitwise
      final s2 = program.statements[1] as ClassicalDeclaration;
      expect(s2.initializer, isA<BinaryExpression>());
      final bitExpr = s2.initializer as BinaryExpression;
      expect(bitExpr.operator, equals('|'));

      // Cast
      final s3 = program.statements[2] as ClassicalDeclaration;
      expect(s3.initializer, isA<BinaryExpression>());
      final mult = s3.initializer as BinaryExpression;
      expect(mult.left, isA<CastExpression>());
      final cast = mult.left as CastExpression;
      expect(cast.type, isA<ScalarTypeNode>());
      expect((cast.type as ScalarTypeNode).name, equals('float'));

      // Durationof
      final s4 = program.statements[3] as ClassicalDeclaration;
      expect(s4.initializer, isA<DurationOfExpression>());
      expect((s4.initializer as DurationOfExpression).statements.length, 1);
    });

    test('should parse subroutines and constants', () {
      final source = '''
OPENQASM 3.0;
const int n = 5;
def my_sub(int[n] x, qubit q) -> bit {
  h q;
  bit b;
  b = measure q;
  if (b) {
    return 1;
  }
  return 0;
}
extern my_extern(float[64]) -> float[64];
input float[64] phi;
let q_alias = q[0];
''';
      final program = OpenQASMParser.parse(source);
      expect(program.statements.length, 5);

      expect(program.statements[0], isA<ConstantDeclaration>());
      expect(program.statements[1], isA<SubroutineDefinition>());
      expect(program.statements[2], isA<ExternStatement>());
      expect(program.statements[3], isA<IOStatement>());
      expect(program.statements[4], isA<AliasStatement>());

      final sub = program.statements[1] as SubroutineDefinition;
      expect(sub.name, 'my_sub');
      expect(sub.arguments?.length, 2);
      expect(sub.returnType, isA<ScalarTypeNode>());
      expect((sub.returnType as ScalarTypeNode).name, 'bit');
      expect(sub.body.length, 5);
    });
    test('should parse bitshift operators', () {
      final source = '''
OPENQASM 3.0;
int x = 1 << 2;
int y = 8 >> 1;
''';
      final program = OpenQASMParser.parse(source);
      expect(program.statements.length, 2);

      final s1 = program.statements[0] as ClassicalDeclaration;
      expect(s1.initializer, isA<BinaryExpression>());
      expect((s1.initializer as BinaryExpression).operator, equals('<<'));

      final s2 = program.statements[1] as ClassicalDeclaration;
      expect(s2.initializer, isA<BinaryExpression>());
      expect((s2.initializer as BinaryExpression).operator, equals('>>'));
    });

    test('should parse compound assignments', () {
      final source = '''
OPENQASM 3.0;
x += 1;
y *= 2.0;
z <<= 3;
c = measure q;
''';
      final program = OpenQASMParser.parse(source);
      expect(program.statements.length, 4);

      final s1 = program.statements[0] as AssignmentStatement;
      expect(s1.operator, equals('+='));

      final s2 = program.statements[1] as AssignmentStatement;
      expect(s2.operator, equals('*='));

      final s3 = program.statements[2] as AssignmentStatement;
      expect(s3.operator, equals('<<='));

      final s4 = program.statements[3] as AssignmentStatement;
      expect(s4.operator, equals('='));
      expect(s4.value, isA<Expression>());
    });

    test('should parse complex types and multidimensional arrays', () {
      final source = '''
OPENQASM 3.0;
complex[float[64]] z;
array[int[32], 10, 20] arr;
float[64] f = float[64](1);
''';
      final program = OpenQASMParser.parse(source);
      expect(program.statements.length, 3);

      final s1 = program.statements[0] as ClassicalDeclaration;
      expect(s1.type, isA<ComplexTypeNode>());
      final complexType = s1.type as ComplexTypeNode;
      expect(complexType.baseType, isA<ScalarTypeNode>());
      expect(complexType.baseType!.name, equals('float'));

      final s2 = program.statements[1] as ClassicalDeclaration;
      expect(s2.type, isA<ArrayTypeNode>());
      final arrayType = s2.type as ArrayTypeNode;
      expect(arrayType.baseType, isA<ScalarTypeNode>());
      expect(arrayType.dimensions.length, equals(2));

      final s3 = program.statements[2] as ClassicalDeclaration;
      expect(s3.initializer, isA<CastExpression>());
      final cast = s3.initializer as CastExpression;
      expect(cast.type, isA<ScalarTypeNode>());
      expect((cast.type as ScalarTypeNode).name, equals('float'));
    });

    test('should parse specialized literals', () {
      final source = r'''
OPENQASM 3.0;
int hex = 0x12ff;
int bin = 0b1010;
int oct = 0o755;
complex[float[64]] z = 1.0 + 2.0im;
duration d = 100ns;
bit[4] b = "1011";
h $0;
''';
      final program = OpenQASMParser.parse(source);
      expect(program.statements.length, 7);

      // Hex
      final s1 = program.statements[0] as ClassicalDeclaration;
      expect((s1.initializer as LiteralExpression).value, equals(0x12ff));

      // Binary
      final s2 = program.statements[1] as ClassicalDeclaration;
      expect((s2.initializer as LiteralExpression).value, equals(10));

      // Octal
      final s3 = program.statements[2] as ClassicalDeclaration;
      expect((s3.initializer as LiteralExpression).value, equals(493)); // 0o755

      // Imaginary
      final s4 = program.statements[3] as ClassicalDeclaration;
      final binExpr = s4.initializer as BinaryExpression;
      expect((binExpr.right as LiteralExpression).type, equals('imaginary'));
      expect((binExpr.right as LiteralExpression).value, equals(2.0));

      // Timing
      final s5 = program.statements[4] as ClassicalDeclaration;
      expect((s5.initializer as LiteralExpression).type, equals('timing'));
      expect((s5.initializer as LiteralExpression).value, equals('100ns'));

      // Bitstring
      final s6 = program.statements[5] as ClassicalDeclaration;
      expect((s6.initializer as LiteralExpression).type, equals('bitstring'));
      expect((s6.initializer as LiteralExpression).value, equals('1011'));

      // Hardware Qubit
      final s7 = program.statements[6] as GateCallStatement;
      expect(s7.qubits[0], isA<HardwareQubitExpression>());
      expect((s7.qubits[0] as HardwareQubitExpression).index, equals(0));
    });
  });
}
