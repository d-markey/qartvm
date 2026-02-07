import 'dart:math' as math;

import '../../qcircuit.dart';
import '../../qgate_builder.dart';
import '../../qmemory_space.dart';
import '_gate_executor.dart';
import 'exceptions.dart';

/// Standard OpenQASM 3.0 gate executors for single-qubit and multi-qubit gates.

// ============================================================================
// Single-Qubit Gates
// ============================================================================

/// Identity gate executor.
class IdGateExecutor extends BuiltInGateExecutor {
  IdGateExecutor(QMemorySpace qmem)
    : super(
        'id',
        executor: (qbits, params) => _QG.id(qmem, qbits, params.none('ID')),
        inversor: (qbits, params) => _QG.id(qmem, qbits, params.none('ID')),
      );
}

/// Hadamard gate executor.
class HGateExecutor extends BuiltInGateExecutor {
  HGateExecutor(QMemorySpace qmem)
    : super(
        'h',
        executor: (qbits, params) => _QG.h(qmem, qbits, params.none('H')),
        inversor: (qbits, params) => _QG.h(qmem, qbits, params.none('H')),
      );
}

/// Pauli X gate executor.
class XGateExecutor extends BuiltInGateExecutor {
  XGateExecutor(QMemorySpace qmem)
    : super(
        'x',
        executor: (qbits, params) => _QG.x(qmem, qbits, params.none('X')),
        inversor: (qbits, params) => _QG.x(qmem, qbits, params.none('X')),
      );
}

/// Pauli Y gate executor.
class YGateExecutor extends BuiltInGateExecutor {
  YGateExecutor(QMemorySpace qmem)
    : super(
        'y',
        executor: (qbits, params) => _QG.y(qmem, qbits, params.none('Y')),
        inversor: (qbits, params) => _QG.y(qmem, qbits, params.none('Y')),
      );
}

/// Pauli Z gate executor.
class ZGateExecutor extends BuiltInGateExecutor {
  ZGateExecutor(QMemorySpace qmem)
    : super(
        'z',
        executor: (qbits, params) => _QG.z(qmem, qbits, params.none('Z')),
        inversor: (qbits, params) => _QG.z(qmem, qbits, params.none('Z')),
      );
}

/// S phase gate executor (π/2 phase).
class SGateExecutor extends BuiltInGateExecutor {
  SGateExecutor(QMemorySpace qmem)
    : super(
        's',
        executor: (qbits, params) => _QG.s(qmem, qbits, params.none('S')),
        inversor: (qbits, params) => _QG.sdg(qmem, qbits, params.none('S')),
      );
}

/// S-dagger gate executor (inverse S, -π/2 phase).
class SdgGateExecutor extends BuiltInGateExecutor {
  SdgGateExecutor(QMemorySpace qmem)
    : super(
        'sdg',
        executor: (qbits, params) => _QG.sdg(qmem, qbits, params.none('SDG')),
        inversor: (qbits, params) => _QG.s(qmem, qbits, params.none('SDG')),
      );
}

/// T phase gate executor (π/4 phase).
class TGateExecutor extends BuiltInGateExecutor {
  TGateExecutor(QMemorySpace qmem)
    : super(
        't',
        executor: (qbits, params) => _QG.t(qmem, qbits, params.none('T')),
        inversor: (qbits, params) => _QG.tdg(qmem, qbits, params.none('T')),
      );
}

/// T-dagger gate executor (inverse T, -π/4 phase).
class TdgGateExecutor extends BuiltInGateExecutor {
  TdgGateExecutor(QMemorySpace qmem)
    : super(
        'tdg',
        executor: (qbits, params) => _QG.tdg(qmem, qbits, params.none('TDG')),
        inversor: (qbits, params) => _QG.t(qmem, qbits, params.none('TDG')),
      );
}

/// SX gate executor (√X gate, π/2 rotation around X axis).
class SXGateExecutor extends BuiltInGateExecutor {
  SXGateExecutor(QMemorySpace qmem)
    : super(
        'sx',
        executor: (qbits, params) => _QG.sx(qmem, qbits, params.none('SX')),
        inversor: (qbits, params) => _QG.sxdg(qmem, qbits, params.none('SX')),
      );
}

// ============================================================================
// Parameterized Single-Qubit Gates
// ============================================================================

/// RX rotation gate executor (rotation around X axis).
class RXGateExecutor extends BuiltInGateExecutor {
  RXGateExecutor(QMemorySpace qmem)
    : super(
        'rx',
        executor: (qbits, params) => _QG.rx(qmem, qbits, params.u1('RX')),
        inversor: (qbits, params) => _QG.rx(qmem, qbits, params.negU1('RX')),
      );
}

/// RY rotation gate executor (rotation around Y axis).
class RYGateExecutor extends BuiltInGateExecutor {
  RYGateExecutor(QMemorySpace qmem)
    : super(
        'ry',
        executor: (qbits, params) => _QG.ry(qmem, qbits, params.u1('RY')),
        inversor: (qbits, params) => _QG.ry(qmem, qbits, params.negU1('RY')),
      );
}

/// RZ rotation gate executor (rotation around Z axis).
class RZGateExecutor extends BuiltInGateExecutor {
  RZGateExecutor(QMemorySpace qmem)
    : super(
        'rz',
        executor: (qbits, params) => _QG.rz(qmem, qbits, params.u1('RZ')),
        inversor: (qbits, params) => _QG.rz(qmem, qbits, params.negU1('RZ')),
      );
}

/// Phase gate executor (also known as P gate).
class PhaseGateExecutor extends BuiltInGateExecutor {
  PhaseGateExecutor(QMemorySpace qmem)
    : super(
        'phase',
        executor: (qbits, params) => _QG.p(qmem, qbits, params.u1('PHASE')),
        inversor: (qbits, params) => _QG.p(qmem, qbits, params.negU1('PHASE')),
      );
}

/// P gate executor (alias for phase gate).
class PGateExecutor extends BuiltInGateExecutor {
  PGateExecutor(QMemorySpace qmem)
    : super(
        'p',
        executor: (qbits, params) => _QG.p(qmem, qbits, params.u1('P')),
        inversor: (qbits, params) => _QG.p(qmem, qbits, params.negU1('P')),
      );
}

/// U1 gate executor (phase gate variant).
class U1GateExecutor extends BuiltInGateExecutor {
  U1GateExecutor(QMemorySpace qmem)
    : super(
        'u1',
        executor: (qbits, params) => _QG.p(qmem, qbits, params.u1('U1')),
        inversor: (qbits, params) => _QG.p(qmem, qbits, params.negU1('U1')),
      );
}

/// U2 gate executor (RZ * RY * RZ decomposition).
class U2GateExecutor extends BuiltInGateExecutor {
  U2GateExecutor(QMemorySpace qmem)
    : super(
        'u2',
        executor: (qbits, params) => _QG.u2(qmem, qbits, params.u2('U2')),
        inversor: (qbits, params) => _QG.u2(qmem, qbits, params.negU2('U2')),
      );
}

/// U3 gate executor (RZ * RY * RZ decomposition).
class U3GateExecutor extends BuiltInGateExecutor {
  U3GateExecutor(QMemorySpace qmem)
    : super(
        'u3',
        executor: (qbits, params) => _QG.u3(qmem, qbits, params.u3('U3')),
        inversor: (qbits, params) => _QG.u3(qmem, qbits, params.negU3('U3')),
      );
}

// ============================================================================
// Two-Qubit Gates
// ============================================================================

/// CX (CNOT) gate executor - controlled X gate.
class CXGateExecutor extends BuiltInGateExecutor {
  CXGateExecutor(QMemorySpace qmem)
    : super(
        'cx',
        executor: (qbits, params) =>
            _QG.cx(qmem, qbits.$2('CX'), params.none('CX')),
        inversor: (qbits, params) =>
            _QG.cx(qmem, qbits.$2('CX'), params.none('CX')),
      );
}

/// CNOT gate executor (alias for CX).
class CNOTGateExecutor extends BuiltInGateExecutor {
  CNOTGateExecutor(QMemorySpace qmem)
    : super(
        'cnot',
        executor: (qbits, params) =>
            _QG.cx(qmem, qbits.$2('CNOT'), params.none('CNOT')),
        inversor: (qbits, params) =>
            _QG.cx(qmem, qbits.$2('CNOT'), params.none('CNOT')),
      );
}

/// CY gate executor - controlled Y gate.
class CYGateExecutor extends BuiltInGateExecutor {
  CYGateExecutor(QMemorySpace qmem)
    : super(
        'cy',
        executor: (qbits, params) =>
            _QG.cy(qmem, qbits.$2('CY'), params.none('CY')),
        inversor: (qbits, params) =>
            _QG.cy(qmem, qbits.$2('CY'), params.none('CY')),
      );
}

/// CZ gate executor - controlled Z gate.
class CZGateExecutor extends BuiltInGateExecutor {
  CZGateExecutor(QMemorySpace qmem)
    : super(
        'cz',
        executor: (qbits, params) =>
            _QG.cz(qmem, qbits.$2('CZ'), params.none('CZ')),
        inversor: (qbits, params) =>
            _QG.cz(qmem, qbits.$2('CZ'), params.none('CZ')),
      );
}

/// SWAP gate executor - swaps state of two qbits.
class SWAPGateExecutor extends BuiltInGateExecutor {
  SWAPGateExecutor(QMemorySpace qmem)
    : super(
        'swap',
        executor: (qbits, params) =>
            _QG.swap(qmem, qbits.$2('SWAP'), params.none('SWAP')),
        inversor: (qbits, params) =>
            _QG.swap(qmem, qbits.$2('SWAP'), params.none('SWAP')),
      );
}

/// CP (controlled phase) gate executor.
class CPGateExecutor extends BuiltInGateExecutor {
  CPGateExecutor(QMemorySpace qmem)
    : super(
        'cp',
        executor: (qbits, params) =>
            _QG.cp(qmem, qbits.$2('CP'), params.u1('CP')),
        inversor: (qbits, params) =>
            _QG.cp(qmem, qbits.$2('CP'), params.negU1('CP')),
      );
}

/// CPhase (controlled phase) gate executor.
class CPhaseGateExecutor extends BuiltInGateExecutor {
  CPhaseGateExecutor(QMemorySpace qmem)
    : super(
        'cphase',
        executor: (qbits, params) =>
            _QG.cp(qmem, qbits.$2('CPHASE'), params.u1('CPHASE')),
        inversor: (qbits, params) =>
            _QG.cp(qmem, qbits.$2('CPHASE'), params.negU1('CPHASE')),
      );
}

/// CRX (controlled RX rotation) gate executor.
class CRXGateExecutor extends BuiltInGateExecutor {
  CRXGateExecutor(QMemorySpace qmem)
    : super(
        'crx',
        executor: (qbits, params) =>
            _QG.crx(qmem, qbits.$2('CRX'), params.u1('CRX')),
        inversor: (qbits, params) =>
            _QG.crx(qmem, qbits.$2('CRX'), params.negU1('CRX')),
      );
}

/// CRY (controlled RY rotation) gate executor.
class CRYGateExecutor extends BuiltInGateExecutor {
  CRYGateExecutor(QMemorySpace qmem)
    : super(
        'cry',
        executor: (qbits, params) =>
            _QG.cry(qmem, qbits.$2('CRY'), params.u1('CRY')),
        inversor: (qbits, params) =>
            _QG.cry(qmem, qbits.$2('CRY'), params.negU1('CRY')),
      );
}

/// CRZ (controlled RZ rotation) gate executor.
class CRZGateExecutor extends BuiltInGateExecutor {
  CRZGateExecutor(QMemorySpace qmem)
    : super(
        'crz',
        executor: (qbits, params) =>
            _QG.crz(qmem, qbits.$2('CRZ'), params.u1('CRZ')),
        inversor: (qbits, params) =>
            _QG.crz(qmem, qbits.$2('CRZ'), params.negU1('CRZ')),
      );
}

/// CH (controlled Hadamard) gate executor.
class CHGateExecutor extends BuiltInGateExecutor {
  CHGateExecutor(QMemorySpace qmem)
    : super(
        'ch',
        executor: (qbits, params) =>
            _QG.ch(qmem, qbits.$2('CH'), params.none('CH')),
        inversor: (qbits, params) =>
            _QG.ch(qmem, qbits.$2('CH'), params.none('CH')),
      );
}

/// CU (controlled U) gate executor - 4-parameter controlled universal gate.
class CUGateExecutor extends BuiltInGateExecutor {
  CUGateExecutor(QMemorySpace qmem)
    : super(
        'cu',
        executor: (qbits, params) =>
            _QG.cu(qmem, qbits.$2('CU'), params.u4('CU')),
        inversor: (qbits, params) =>
            _QG.cu(qmem, qbits.$2('CU'), params.negU4('CU')),
      );
}

// ============================================================================
// Three-Qubit Gates
// ============================================================================

/// CCX (Toffoli) gate executor - doubly controlled X gate.
class CCXGateExecutor extends BuiltInGateExecutor {
  CCXGateExecutor(QMemorySpace qmem)
    : super(
        'ccx',
        executor: (qbits, params) =>
            _QG.ccx(qmem, qbits.$3('CCX'), params.none('CCX')),
        inversor: (qbits, params) =>
            _QG.ccx(qmem, qbits.$3('CCX'), params.none('CCX')),
      );
}

/// CSWAP (Fredkin) gate executor - controlled SWAP gate.
class CSWAPGateExecutor extends BuiltInGateExecutor {
  CSWAPGateExecutor(QMemorySpace qmem)
    : super(
        'cswap',
        executor: (qbits, params) =>
            _QG.cswap(qmem, qbits.$3('CSWAP'), params.none('CSWAP')),
        inversor: (qbits, params) =>
            _QG.cswap(qmem, qbits.$3('CSWAP'), params.none('CSWAP')),
      );
}

// Standard Quantum Gate implementations
abstract class _QG {
  /// Identity gate - performs no operation.
  static void id(QMemorySpace qmem, List<int> qbits, void params) {
    // do nothing
  }

  /// Hadamard gate - creates equal superposition of |0⟩ and |1⟩ states.
  static void h(QMemorySpace qmem, List<int> qbits, void params) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    for (final q in qbits) {
      circuit.hadamard(q);
    }
    circuit.execute(qmem);
  }

  /// Pauli X gate (NOT gate) - flips |0⟩ to |1⟩ and vice versa.
  static void x(QMemorySpace qmem, List<int> qbits, void params) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    for (final q in qbits) {
      circuit.pauliX(q);
    }
    circuit.execute(qmem);
  }

  /// Pauli Y gate - applies phase rotation combined with bit flip.
  static void y(QMemorySpace qmem, List<int> qbits, void params) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    for (final q in qbits) {
      circuit.pauliY(q);
    }
    circuit.execute(qmem);
  }

  /// Pauli Z gate - applies π phase to |1⟩ state.
  static void z(QMemorySpace qmem, List<int> qbits, void params) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    for (final q in qbits) {
      circuit.pauliZ(q);
    }
    circuit.execute(qmem);
  }

  /// S phase gate - applies π/2 phase to |1⟩ state.
  static void s(QMemorySpace qmem, List<int> qbits, void params) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    for (final q in qbits) {
      circuit.phaseS(q);
    }
    circuit.execute(qmem);
  }

  /// S-dagger gate (S†) - inverse of S, applies -π/2 phase to |1⟩ state.
  static void sdg(QMemorySpace qmem, List<int> qbits, void params) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    final angle = -math.pi / 2;
    for (final q in qbits) {
      circuit.phase(angle, q);
    }
    circuit.execute(qmem);
  }

  /// T phase gate - applies π/4 phase to |1⟩ state.
  static void t(QMemorySpace qmem, List<int> qbits, void params) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    for (final q in qbits) {
      circuit.phaseT(q);
    }
    circuit.execute(qmem);
  }

  /// T-dagger gate (T†) - inverse of T, applies -π/4 phase to |1⟩ state.
  static void tdg(QMemorySpace qmem, List<int> qbits, void params) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    final angle = -math.pi / 4;
    for (final q in qbits) {
      circuit.phase(angle, q);
    }
    circuit.execute(qmem);
  }

  /// SX gate (√X) - square root of X gate, π/2 rotation around X axis.
  static void sx(QMemorySpace qmem, List<int> qbits, void params) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    final angle = math.pi / 2;
    for (final q in qbits) {
      circuit.rotationX(angle, q);
    }
    circuit.execute(qmem);
  }

  /// SX-dagger gate (SX†) - inverse of SX, -π/2 rotation around X axis.
  static void sxdg(QMemorySpace qmem, List<int> qbits, void params) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    final angle = -math.pi / 2;
    for (final q in qbits) {
      circuit.rotationX(angle, q);
    }
    circuit.execute(qmem);
  }

  /// RX gate - rotation around the X axis by angle θ.
  static void rx(QMemorySpace qmem, List<int> qbits, double angle) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    for (final q in qbits) {
      circuit.rotationX(angle, q);
    }
    circuit.execute(qmem);
  }

  /// RY gate - rotation around the Y axis by angle θ.
  static void ry(QMemorySpace qmem, List<int> qbits, double angle) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    for (final q in qbits) {
      circuit.rotationY(angle, q);
    }
    circuit.execute(qmem);
  }

  /// RZ gate - rotation around the Z axis by angle θ (differs from P gate by global phase).
  static void rz(QMemorySpace qmem, List<int> qbits, double angle) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    for (final q in qbits) {
      circuit.rotationZ(angle, q);
    }
    circuit.execute(qmem);
  }

  /// Phase gate (P) - applies phase λ to |1⟩ state. Equivalent to controlled global phase.
  static void p(QMemorySpace qmem, List<int> qbits, double angle) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    for (final q in qbits) {
      circuit.phase(angle, q);
    }
    circuit.execute(qmem);
  }

  /// U2 gate - two-parameter universal gate, equivalent to u3(π/2, φ, λ).
  static void u2(QMemorySpace qmem, List<int> qbits, TwoParams params) =>
      u3(qmem, qbits, (math.pi / 2, params.$1, params.$2));

  /// U3 gate - three-parameter universal gate (RZ-RY-RZ decomposition).
  /// Decomposes as: RZ(φ) RY(θ) RZ(λ).
  static void u3(QMemorySpace qmem, List<int> qbits, ThreeParams params) {
    final theta = params.$1, phi = params.$2, lambda = params.$3;
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    for (final q in qbits) {
      circuit.rotationZ(phi, q);
      circuit.rotationY(theta, q);
      circuit.rotationZ(lambda, q);
    }
    circuit.execute(qmem);
  }

  /// CX gate (CNOT) - controlled X gate. Applies X to target when control is |1⟩.
  static void cx(QMemorySpace qmem, TwoQbits qbits, void params) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    circuit.pauliX(qbits.$2, controls: {qbits.$1});
    circuit.execute(qmem);
  }

  /// CY gate - controlled Y gate. Applies Y to target when control is |1⟩.
  static void cy(QMemorySpace qmem, TwoQbits qbits, void params) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    circuit.pauliY(qbits.$2, controls: {qbits.$1});
    circuit.execute(qmem);
  }

  /// CZ gate - controlled Z gate. Applies Z to target when control is |1⟩.
  static void cz(QMemorySpace qmem, TwoQbits qbits, void params) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    circuit.pauliZ(qbits.$2, controls: {qbits.$1});
    circuit.execute(qmem);
  }

  /// SWAP gate - exchanges quantum states of two qubits.
  static void swap(QMemorySpace qmem, TwoQbits qbits, void params) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    circuit.swap({qbits.$1, qbits.$2});
    circuit.execute(qmem);
  }

  /// CCX gate (Toffoli) - doubly-controlled X gate. Applies X when both controls are |1⟩.
  static void ccx(QMemorySpace qmem, ThreeQbits qbits, void params) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    circuit.toffoli(qbits.$3, controls: {qbits.$1, qbits.$2});
    circuit.execute(qmem);
  }

  /// CSWAP gate (Fredkin) - controlled SWAP gate. Swaps two qubits when control is |1⟩.
  static void cswap(QMemorySpace qmem, ThreeQbits qbits, void params) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    circuit.fredkin({qbits.$2, qbits.$3}, control: qbits.$1);
    circuit.execute(qmem);
  }

  /// CP gate - controlled phase gate. Applies phase λ to target when control is |1⟩.
  static void cp(QMemorySpace qmem, TwoQbits qbits, double angle) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    circuit.phase(angle, qbits.$2, controls: {qbits.$1});
    circuit.execute(qmem);
  }

  /// CRX gate - controlled RX gate. Applies X rotation by θ when control is |1⟩.
  static void crx(QMemorySpace qmem, TwoQbits qbits, double angle) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    circuit.rotationX(angle, qbits.$2, controls: {qbits.$1});
    circuit.execute(qmem);
  }

  /// CRY gate - controlled RY gate. Applies Y rotation by θ when control is |1⟩.
  static void cry(QMemorySpace qmem, TwoQbits qbits, double angle) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    circuit.rotationY(angle, qbits.$2, controls: {qbits.$1});
    circuit.execute(qmem);
  }

  /// CRZ gate - controlled RZ gate. Applies Z rotation by θ when control is |1⟩.
  static void crz(QMemorySpace qmem, TwoQbits qbits, double angle) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    circuit.rotationZ(angle, qbits.$2, controls: {qbits.$1});
    circuit.execute(qmem);
  }

  /// CH gate - controlled Hadamard gate. Applies H when control is |1⟩.
  static void ch(QMemorySpace qmem, TwoQbits qbits, void params) {
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    circuit.hadamard(qbits.$2, controls: {qbits.$1});
    circuit.execute(qmem);
  }

  /// CU gate - controlled universal gate with 4 parameters (θ, φ, λ, γ).
  /// Applies U(θ, φ, λ) with global phase γ when control is |1⟩.
  static void cu(QMemorySpace qmem, TwoQbits qbits, FourParams params) {
    final theta = params.$1,
        phi = params.$2,
        lambda = params.$3,
        gamma = params.$4;
    final gateBuilder = QGateBuilder.get(qmem.size);
    final circuit = QCircuit(gateBuilder);
    // CU decomposed as: RZ(φ) RY(θ) RZ(λ) with global phase γ
    circuit.rotationZ(phi, qbits.$2, controls: {qbits.$1});
    circuit.rotationY(theta, qbits.$2, controls: {qbits.$1});
    circuit.rotationZ(lambda, qbits.$2, controls: {qbits.$1});
    circuit.phase(gamma, qbits.$1);
    circuit.execute(qmem);
  }
}

typedef TwoQbits = (int, int);
typedef ThreeQbits = (int, int, int);

typedef TwoParams = (double, double);
typedef ThreeParams = (double, double, double);
typedef FourParams = (double, double, double, double);

extension on Iterable<num>? {
  void none(String gate) {
    if (this?.isNotEmpty ?? false) {
      throw GateExecutionException(
        '$gate gate cannot be called with arguments',
      );
    }
  }

  double u1(String gate) {
    final a = this?.singleOrNull;
    if (a == null) {
      throw GateExecutionException('$gate gate requires exactly 1 argument');
    }
    return a.toDouble();
  }

  double negU1(String gate) => -u1(gate);

  TwoParams u2(String gate) {
    final a = this?.firstOrNull, b = this?.skip(1).singleOrNull;
    if (a == null || b == null) {
      throw GateExecutionException('$gate gate requires exactly 2 arguments');
    }
    return (a.toDouble(), b.toDouble());
  }

  TwoParams negU2(String gate) {
    final $ = u2(gate);
    return (-$.$1, -$.$2);
  }

  ThreeParams u3(String gate) {
    final a = this?.firstOrNull,
        b = this?.skip(1).firstOrNull,
        c = this?.skip(2).singleOrNull;
    if (a == null || b == null || c == null) {
      throw GateExecutionException('$gate gate requires exactly 3 arguments');
    }
    return (a.toDouble(), b.toDouble(), c.toDouble());
  }

  ThreeParams negU3(String gate) {
    final $ = u3(gate);
    return (-$.$1, -$.$3, -$.$2); // swap last two params
  }

  FourParams u4(String gate) {
    final a = this?.firstOrNull,
        b = this?.skip(1).firstOrNull,
        c = this?.skip(2).firstOrNull,
        d = this?.skip(3).singleOrNull;
    if (a == null || b == null || c == null || d == null) {
      throw GateExecutionException('$gate gate requires exactly 4 arguments');
    }
    return (a.toDouble(), b.toDouble(), c.toDouble(), d.toDouble());
  }

  FourParams negU4(String gate) {
    final $ = u4(gate);
    return (-$.$1, -$.$2, -$.$3, -$.$4);
  }
}

extension on List<int> {
  (int, int) $2(String gate) {
    if (length != 2) {
      throw GateExecutionException('$gate gate requires exactly 2 qbits');
    }
    return (this[0], this[1]);
  }

  ThreeQbits $3(String gate) {
    if (length != 3) {
      throw GateExecutionException('$gate gate requires exactly 3 qbits');
    }
    return (this[0], this[1], this[2]);
  }
}
