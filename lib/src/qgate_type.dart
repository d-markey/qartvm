import 'dart:math' as math;

class QGateType {
  const QGateType._(this.label, this.symbol);

  QGateType(this.label, this.symbol);

  final String label;
  final String symbol;

  static const measure = QGateType._('measure', '/');
  static const custom = QGateType._('custom', 'CUSTOM');
  static const hadamard = QGateType._('hadamard', 'H');
  static const pauliX = QGateType._('pauliX', 'NOT');
  static const pauliY = QGateType._('pauliY', 'Y');
  static const pauliZ = QGateType._('pauliZ', 'Z');
  static const squareRootOfX = QGateType._('squareRootOfX', 'SQRT-NOT');
  static const phaseS = QGateType._('phaseS', 'S');
  static const phaseT = QGateType._('phaseT', 'T');
  static const phase = QGateType._('phase [angle]', 'P([angle])');
  static const swap = QGateType._('swap', 'SWAP');
  static const fredkin = QGateType._('fredkin', 'C-SWAP');
  static const toffoli = QGateType._('toffoli', 'CC-NOT');
  static const qft = QGateType._('qft', 'QFT');
  static const invqft = QGateType._('invqft', 'INV-QFT');

  static const _unitary = [
    measure,
    hadamard,
    pauliX,
    pauliY,
    pauliZ,
    squareRootOfX,
    phaseS,
    phaseT,
    phase
  ];
  static const _builtIn = [
    measure,
    hadamard,
    pauliX,
    pauliY,
    pauliZ,
    squareRootOfX,
    phaseS,
    phaseT,
    phase,
    swap,
    toffoli,
    qft,
    invqft
  ];

  bool get isUnitary => _unitary.contains(this);
  bool get isCustom => !_builtIn.contains(this);

  String _format(Map<String, dynamic> params, String key) {
    var v = params[key];
    if (key == 'angle' && v is num) {
      v /= math.pi;
      v = '$v pi';
    }
    return v?.toString() ?? 'NULL';
  }

  String getLabel(Map<String, dynamic>? params) {
    var l = label;
    if (params != null) {
      final keys = params.keys.toList();
      keys.sort((a, b) => b.length - a.length);
      for (var k in keys) {
        l = l.replaceAll('[$k]', _format(params, k));
      }
    }
    return l;
  }

  String getSymbol(Map<String, dynamic>? params) {
    var s = symbol;
    if (params != null) {
      final keys = params.keys.toList();
      keys.sort((a, b) => b.length - a.length);
      for (var k in keys) {
        s = s.replaceAll('[$k]', _format(params, k));
      }
    }
    return s;
  }
}
