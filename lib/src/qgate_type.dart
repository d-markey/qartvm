import 'dart:math' as math;

/// Enum-like class for Quantum gate types
class QGateType {
  /// Creates a new, custom gate type
  const QGateType(this.label, this.symbol);

  /// The gate type's [label]
  final String label;

  /// The gate type's [symbol]
  final String symbol;

  /// Built-in separator gate
  static const separator = QGateType('separator', '|');

  /// Built-in measurement gate
  static const measure = QGateType('measure', '[ / ]');

  /// Generic custom gate
  static const custom = QGateType('custom', 'CUSTOM');

  /// Compiled gate
  static const compiled = QGateType('compiled', 'COMPILED');

  /// Hadamard gate
  static const hadamard = QGateType('hadamard', 'H');

  /// Pauli X (NOT) gate
  static const pauliX = QGateType('pauliX', 'NOT');

  /// Pauli Y gate
  static const pauliY = QGateType('pauliY', 'Y');

  /// Pauli Z gate
  static const pauliZ = QGateType('pauliZ', 'Z');

  /// Square root of NOT gate
  static const squareRootOfX = QGateType('squareRootOfX', 'SQRT-NOT');

  /// Phase S gate
  static const phaseS = QGateType('phaseS', 'S');

  /// Phase T gate
  static const phaseT = QGateType('phaseT', 'T');

  /// Phase gate
  static const phase = QGateType('phase [angle]', 'P([angle])');

  /// Rotation X gate
  static const rotateX = QGateType('rotate-X [angle]', 'Rx([angle])');

  /// Rotation Y gate
  static const rotateY = QGateType('rotate-Y [angle]', 'Ry([angle])');

  /// Rotation Z gate
  static const rotateZ = QGateType('rotate-Z [angle]', 'Rz([angle])');

  /// SWAP gate
  static const swap = QGateType('swap', 'SWAP');

  /// Fredkin (C-SWAP) gate
  static const fredkin = QGateType('fredkin', 'C-SWAP');

  /// Toffoli (CC-NOT) gate
  static const toffoli = QGateType('toffoli', 'CC-NOT');

  /// Quantum Fourrier Transform (QFT) gate
  static const qft = QGateType('qft', 'QFT');

  /// Inverse Quantum Fourrier Transform (INV-QFT) gate
  static const invqft = QGateType('invqft', 'INV-QFT');

  static const _unitary = [
    measure,
    hadamard,
    pauliX,
    pauliY,
    pauliZ,
    squareRootOfX,
    phaseS,
    phaseT,
    phase,
  ];

  static const _builtIn = [
    separator,
    measure,
    compiled,
    custom,
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
    invqft,
  ];

  /// Returns `true` if the gate type operates on a single-qubit without any control qubits
  bool get isUnitary => _unitary.contains(this);

  /// Returns `true` if the gate type is a custom type
  bool get isCustom => this == QGateType.custom || !_builtIn.contains(this);

  String _format(String text, Iterable<MapEntry<String, dynamic>>? params) {
    if (params != null) {
      String _param(String key) {
        var v = params.singleWhere((p) => p.key == key).value;
        if (key == 'angle' && v is num) {
          v /= math.pi;
          v = '$v pi';
        }
        return v?.toString() ?? 'NULL';
      }

      final keys = params.map((p) => p.key).toList();
      keys.sort((a, b) => b.length - a.length);
      for (var k in keys) {
        text = text.replaceAll('[$k]', _param(k));
      }
    }
    return text;
  }

  /// Returns the [label] for this gate type formatted with specified [params]
  String getLabel(Iterable<MapEntry<String, dynamic>>? params) =>
      _format(label, params);

  /// Returns the [symbol] for this gate type formatted with specified [params]
  String getSymbol(Iterable<MapEntry<String, dynamic>>? params) =>
      _format(symbol, params);
}
