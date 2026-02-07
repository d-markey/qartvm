import 'exceptions.dart';
import 'openqasm_include_provider.dart';

/// Provider for standard OpenQASM 3.0 gates defined in "stdgates.inc".
///
/// This provider contains the standard gate definitions that would normally
/// be loaded from an external file. Instead, they are registered directly
/// with the [GateMapper] during interpreter initialization.
class StandardGatesProvider implements OpenQASMIncludeProvider {
  /// The standard gates include file content.
  /// Contains definitions for commonly used gates like h, x, y, z, cx, etc.
  static const String stdgatesIncContent = '''
// Standard OpenQASM 3.0 gates
// These gates are built-in and don't require external files
gate h q { }
gate x q { }
gate y q { }
gate z q { }
gate s q { }
gate t q { }
gate sdg q { }
gate tdg q { }
gate sx q { }
gate rx(angle) q { }
gate ry(angle) q { }
gate rz(angle) q { }
gate cx c, t { }
gate cy c, t { }
gate cz c, t { }
gate swap a, b { }
gate ccx a, b, c { }
gate cswap a, b, c { }
gate phase(angle) q { }
gate p(angle) q { }
gate u1(lambda) q { }
gate u2(phi, lambda) q { }
gate u3(theta, phi, lambda) q { }
gate xx(angle) q0, q1 { }
gate yy(angle) q0, q1 { }
gate zz(angle) q0, q1 { }
gate ecr q0, q1 { }
''';

  @override
  Future<String> loadIncludeFile(String filename) async {
    if (filename == 'stdgates.inc') {
      return stdgatesIncContent;
    }
    throw IncludeException(
      'StandardGatesProvider only provides "stdgates.inc"',
      filename: filename,
    );
  }
}
