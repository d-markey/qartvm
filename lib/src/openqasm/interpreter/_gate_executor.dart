import 'dart:async';
import 'dart:math' as math;

import '../../qcircuit.dart';
import '../../qgate_builder.dart';
import '../../qmemory_space.dart';
import '../../qregister.dart';
import '../parser/ast_nodes.dart';
import '_execution_context.dart';
import '_expression_evaluator.dart';
import 'exceptions.dart';

/// Base class for calling a quantum gate.
abstract class GateExecutor {
  Future<void> execute(List<int> qubits, List<num>? params);
  Future<void> inverse(List<int> qubits, List<num>? params);

  String get name;
}

/// Base class for calling a built-in quantum gate such as H, X...
abstract class BuiltInGateExecutor implements GateExecutor {
  BuiltInGateExecutor(
    this.name, {
    required this.executor,
    required this.inversor,
  });

  @override
  final String name;

  final FutureOr<void> Function(List<int>, List<num>?) executor;
  final FutureOr<void> Function(List<int>, List<num>?) inversor;

  @override
  Future<void> execute(List<int> qubits, List<num>? params) async =>
      executor(qubits, params);

  @override
  Future<void> inverse(List<int> qubits, List<num>? params) async =>
      inversor(qubits, params);
}

/// Class for calling a custom quantum gate.
class CustomGateExecutor implements GateExecutor {
  CustomGateExecutor(
    this.context,
    this.evaluator,
    this.statementExecutor,
    this.gateDef,
  );

  final GateStatement gateDef;
  final ExecutionContext context;
  final ExpressionEvaluator evaluator;
  final Future<void> Function(List<Statement>, ExecutionContext)
  statementExecutor;

  @override
  String get name => gateDef.name;

  @override
  Future<void> execute(List<int> qubits, List<num>? params) async {
    // Validate qubit count matches gate definition
    if (gateDef.qubits.length != qubits.length) {
      throw GateExecutionException(
        'Gate "${gateDef.name}" expects ${gateDef.qubits.length} qubit(s), '
        'but ${qubits.length} were provided',
      );
    }

    // Validate parameter count matches gate definition
    final expectedParamCount = gateDef.parameters?.length ?? 0;
    final actualParamCount = params?.length ?? 0;
    if (expectedParamCount != actualParamCount) {
      throw GateExecutionException(
        'Gate "${gateDef.name}" expects $expectedParamCount parameter(s), '
        'but $actualParamCount were provided',
      );
    }

    // Create a new scope for the gate execution
    context.symbols.pushScope();

    try {
      // Bind gate parameters to evaluated values
      if (gateDef.parameters != null && params != null) {
        for (int i = 0; i < gateDef.parameters!.length; i++) {
          final paramName = gateDef.parameters![i];
          final paramValue = params[i];
          context.symbols.declareVariable(paramName, paramValue);
        }
      }

      // Bind gate qubits to the provided qubit addresses
      for (int i = 0; i < gateDef.qubits.length; i++) {
        final qubitName = gateDef.qubits[i];
        final qubitAddress = qubits[i];
        // Create a single-qubit register for the parameter
        final register = QRegisterImpl.ctor(qubitName, context.quantumMemory!, [
          qubitAddress,
        ]);
        context.symbols.declareQubit(qubitName, register);
      }

      // Execute the gate body statements
      await statementExecutor(gateDef.body, context);
    } finally {
      // Pop the gate scope
      context.symbols.popScope();
    }
  }

  @override
  Future<void> inverse(List<int> qubits, List<num>? params) async {
    // TODO: check that the body only uses gates and play them in reverse order
    // TODO: throw if the definition includes measures, resets, or control-flow statements
  }
}

/// Wrapper executor for applying control modifiers to any gate.
///
/// This executor decorates another gate executor and applies control qubits.
/// It handles both regular ctrl and negated ctrl modifiers.
class ControlledGateExecutor implements GateExecutor {
  final GateExecutor innerExecutor;
  final List<int> controlQubits;
  final bool isNegated;
  final QMemorySpace qmem;
  final int controlCount;

  ControlledGateExecutor({
    required this.innerExecutor,
    required this.controlQubits,
    required this.isNegated,
    required this.qmem,
    required this.controlCount,
  });

  @override
  String get name => 'ctrl_${innerExecutor.name}';

  @override
  Future<void> execute(List<int> qubits, List<num>? params) async {
    if (qubits.isEmpty) {
      throw GateExecutionException(
        'Controlled gate requires at least 1 target qubit',
      );
    }

    final gateBuilder = QGateBuilder.get(qmem.size, withCache: false);
    final circuit = QCircuit(gateBuilder);

    // For negated controls, flip the control qubits before and after
    if (isNegated) {
      for (final ctrl in controlQubits) {
        circuit.pauliX(ctrl);
      }
    }

    // Check if inner executor is a built-in gate
    // For built-in gates, we can apply directly with controls
    if (innerExecutor is BuiltInGateExecutor) {
      _executeControlledBuiltinGate(circuit, qubits, params, controlQubits);
    } else {
      throw GateExecutionException(
        'Gate "${innerExecutor.name}" does not support ctrl/negctrl modifiers',
      );
    }

    // For negated controls, flip the control qubits back
    if (isNegated) {
      for (final ctrl in controlQubits) {
        circuit.pauliX(ctrl);
      }
    }

    circuit.execute(qmem);
  }

  @override
  Future<void> inverse(List<int> qubits, List<num>? params) async {
    // TODO
  }

  /// Helper to apply controlled versions of built-in gates.
  /// This uses the QCircuit API to apply gates with control qubits.
  void _executeControlledBuiltinGate(
    QCircuit circuit,
    List<int> targetQubits,
    List<num>? params,
    List<int> controlQubits,
  ) {
    final gateName = innerExecutor.name.toLowerCase();

    switch (gateName) {
      // Single-qubit gates
      case 'x':
        if (targetQubits.length != 1) {
          throw GateExecutionException(
            'X gate with ctrl requires 1 target, got ${targetQubits.length}',
          );
        }
        circuit.pauliX(targetQubits[0], controls: controlQubits.toSet());

      case 'y':
        if (targetQubits.length != 1) {
          throw GateExecutionException(
            'Y gate with ctrl requires 1 target, got ${targetQubits.length}',
          );
        }
        circuit.pauliY(targetQubits[0], controls: controlQubits.toSet());

      case 'z':
        if (targetQubits.length != 1) {
          throw GateExecutionException(
            'Z gate with ctrl requires 1 target, got ${targetQubits.length}',
          );
        }
        circuit.pauliZ(targetQubits[0], controls: controlQubits.toSet());

      case 'h':
        if (targetQubits.length != 1) {
          throw GateExecutionException(
            'H gate with ctrl requires 1 target, got ${targetQubits.length}',
          );
        }
        circuit.hadamard(targetQubits[0], controls: controlQubits.toSet());

      case 's':
        if (targetQubits.length != 1) {
          throw GateExecutionException(
            'S gate with ctrl requires 1 target, got ${targetQubits.length}',
          );
        }
        circuit.phaseS(targetQubits[0], controls: controlQubits.toSet());

      case 'sdg':
        if (targetQubits.length != 1) {
          throw GateExecutionException(
            'SDG gate with ctrl requires 1 target, got ${targetQubits.length}',
          );
        }
        circuit.phase(
          -math.pi / 2,
          targetQubits[0],
          controls: controlQubits.toSet(),
        );

      case 't':
        if (targetQubits.length != 1) {
          throw GateExecutionException(
            'T gate with ctrl requires 1 target, got ${targetQubits.length}',
          );
        }
        circuit.phaseT(targetQubits[0], controls: controlQubits.toSet());

      case 'tdg':
        if (targetQubits.length != 1) {
          throw GateExecutionException(
            'TDG gate with ctrl requires 1 target, got ${targetQubits.length}',
          );
        }
        circuit.phase(
          -math.pi / 4,
          targetQubits[0],
          controls: controlQubits.toSet(),
        );

      case 'rx':
        if (targetQubits.length != 1) {
          throw GateExecutionException(
            'RX gate with ctrl requires 1 target, got ${targetQubits.length}',
          );
        }
        final angle = (params?[0] ?? 0).toDouble();
        circuit.rotationX(
          angle,
          targetQubits[0],
          controls: controlQubits.toSet(),
        );

      case 'ry':
        if (targetQubits.length != 1) {
          throw GateExecutionException(
            'RY gate with ctrl requires 1 target, got ${targetQubits.length}',
          );
        }
        final angle = (params?[0] ?? 0).toDouble();
        circuit.rotationY(
          angle,
          targetQubits[0],
          controls: controlQubits.toSet(),
        );

      case 'rz':
        if (targetQubits.length != 1) {
          throw GateExecutionException(
            'RZ gate with ctrl requires 1 target, got ${targetQubits.length}',
          );
        }
        final angle = (params?[0] ?? 0).toDouble();
        circuit.rotationZ(
          angle,
          targetQubits[0],
          controls: controlQubits.toSet(),
        );

      case 'phase':
      case 'p':
        if (targetQubits.length != 1) {
          throw GateExecutionException(
            'Phase gate with ctrl requires 1 target, got ${targetQubits.length}',
          );
        }
        final angle = (params?[0] ?? 0).toDouble();
        circuit.phase(angle, targetQubits[0], controls: controlQubits.toSet());

      default:
        throw GateExecutionException(
          'Gate "${innerExecutor.name}" does not support ctrl/negctrl modifiers',
        );
    }
  }
}
