import 'math/complex_matrix.dart';
import 'exceptions.dart';
import 'qcircuit_gate.dart';
import 'qgate_type.dart';
import 'qgate_builder.dart';
import 'qmemory_space.dart';
import 'qregister.dart';

typedef Observer = void Function(
    int step, QCircuitGate? gate, QMemorySpace qmem);

List<int> _getList(dynamic qubits) {
  if (qubits is int) {
    return [qubits];
  } else if (qubits is QRegister) {
    return qubits.qubits;
  } else if (qubits is Iterable &&
      qubits.isNotEmpty &&
      qubits.every((q) => q is int)) {
    return List<int>.from(qubits);
  } else {
    throw InvalidOperationException(
        'Expected a register, a single qubit or a non-empty collection of qubits');
  }
}

Set<int> _getSet(dynamic qubits) {
  if (qubits is int) {
    return {qubits};
  } else if (qubits is QRegister) {
    return qubits.qubits.toSet();
  } else if (qubits is Iterable &&
      qubits.isNotEmpty &&
      qubits.every((q) => q is int)) {
    return Set<int>.from(qubits);
  } else {
    throw InvalidOperationException(
        'Expected a register, a single qubit or a non-empty collection of qubits');
  }
}

/// Class representing a Quantum circuit
class QCircuit {
  QCircuit(this.gateBuilder) : size = gateBuilder.size;

  /// Returns the circuit's size (i.e. the number of qubits it works with)
  final int size;

  final _gates = <QCircuitGate>[];

  /// Returns the [QCircuitGate] gates making up the circuit
  Iterable<QCircuitGate> get gates => _gates;

  List<Observer>? _observers;

  /// The circuit's gate builder
  final QGateBuilder gateBuilder;

  /// Adds a separation to the circuit
  QCircuit separation({String? label, bool merge = true}) {
    if (merge && _gates.isNotEmpty && _gates.last.type == QGateType.separator) {
      var mlabel = _gates.last.label;
      if (label != null && label.isNotEmpty) {
        if (mlabel.isNotEmpty) mlabel += ' / ';
        mlabel += label;
      }
      _gates[_gates.length - 1] =
          QCircuitGate.separation(circuit: this, label: mlabel);
    } else {
      _gates.add(QCircuitGate.separation(circuit: this, label: label));
    }
    return this;
  }

  /// Adds a measurement gate to the circuit
  /// Qubits [qubits] will be measured
  /// If [qubits] is null or empty, all qubits will be measured
  QCircuit measure([Set<int>? qubits, String? label]) {
    _gates.add(QCircuitGate.measure(qubits, circuit: this, label: label));
    return this;
  }

  /// Appends the gates of [other] circuit to this instance.
  /// if [dagger] is `true`, reverse gates (with dagger matrix) are appended in reverse order.
  /// Both circuits must have the same size
  QCircuit append(QCircuit other,
      {dynamic controls, bool dagger = false, bool merge = true}) {
    if (other.size != size) {
      throw InvalidOperationException(
          'Cannot append circuit of size ${other.size} to circuit of size $size');
    }
    final cqb = (controls == null || (controls is Iterable && controls.isEmpty))
        ? null
        : _getSet(controls);
    if (dagger) {
      for (var i = other._gates.length - 1; i >= 0; i--) {
        if (other._gates[i].type == QGateType.separator) {
          separation(label: other._gates[i].label, merge: merge);
        } else {
          final copy = other._gates[i].copy(this, controls: cqb, dagger: true);
          _gates.add(copy);
        }
      }
    } else {
      for (var i = 0; i < other._gates.length; i++) {
        if (other._gates[i].type == QGateType.separator) {
          separation(label: other._gates[i].label, merge: merge);
        } else {
          final copy = other._gates[i].copy(this, controls: cqb);
          _gates.add(copy);
        }
      }
    }
    return this;
  }

  QCircuit _addGate(QGateType type, ComplexMatrix matrix, Set<int> qubits,
      Set<int>? controls, Map<String, dynamic>? params, String? label) {
    if (!matrix.square || matrix.rows != (1 << size)) {
      throw InvalidOperationException(
          'Invalid gate ${matrix.rows}x${matrix.columns} for $qubits-qubit circuit');
    }
    _gates.add(QCircuitGate(type, matrix, qubits,
        controls: controls, circuit: this, params: params, label: label));
    return this;
  }

  QCircuit _buildAndAddGate(
      QGateType type,
      dynamic qubits,
      dynamic controls,
      ComplexMatrix Function(Set<int> qubits) gateBuilder,
      ComplexMatrix Function(Set<int> qubits, {required Set<int> controls})
          cgateBuilder,
      Map<String, dynamic>? params,
      String? label) {
    final qb = _getSet(qubits);
    final cqb = (controls == null || (controls is Iterable && controls.isEmpty))
        ? null
        : _getSet(controls);
    final matrix =
        (cqb == null) ? gateBuilder(qb) : cgateBuilder(qb, controls: cqb);
    return _addGate(type, matrix, qb, cqb, params, label);
  }

  /// Adds a custom [gate] to the circuit operating on [qubits] and optionally controlled by [controls] qubits.
  /// [qubits] and [controls] may be single [int]s or [Iterable]s of [int]s.
  /// The gate may be represented by a 2x2 [ComplexMatrix] in which case [qubits] must contain a single qubit and [controls] must be `null` or empty.
  /// Alternatively, the gate may be represented by a square [ComplexMatrix] of size 2^[size] operating on the circuit's full state.
  QCircuit custom(dynamic qubits, ComplexMatrix gate,
      {dynamic controls,
      QGateType type = QGateType.custom,
      Map<String, dynamic>? params,
      String? label}) {
    assert(type.isCustom);
    return _buildAndAddGate(
        type,
        qubits,
        controls,
        (qb) => gateBuilder.parallel.build(qb, gate),
        (qb, {required Set<int> controls}) =>
            gateBuilder.controlled.build(qb, gate, controls: controls),
        params,
        label);
  }

  /// Adds a Hadamard gate operating on [qubits] and controlled by [controls] if provided
  QCircuit hadamard(dynamic qubits, {dynamic controls, String? label}) =>
      _buildAndAddGate(
          QGateType.hadamard,
          qubits,
          controls,
          gateBuilder.parallel.hadamard,
          gateBuilder.controlled.hadamard,
          null,
          label);

  /// Adds a Pauli X (NOT) gate operating on [qubits] and controlled by [controls] if provided
  QCircuit pauliX(dynamic qubits, {dynamic controls, String? label}) =>
      _buildAndAddGate(
          QGateType.pauliX,
          qubits,
          controls,
          gateBuilder.parallel.pauliX,
          gateBuilder.controlled.pauliX,
          null,
          label);

  /// Adds a Pauli X (NOT) gate operating on [qubits]
  QCircuit not(dynamic qubits, {dynamic controls, String? label}) =>
      pauliX(qubits, controls: controls, label: label);

  /// Adds a Pauli Y gate operating on [qubits]
  QCircuit pauliY(dynamic qubits, {dynamic controls, String? label}) =>
      _buildAndAddGate(
          QGateType.pauliY,
          qubits,
          controls,
          gateBuilder.parallel.pauliY,
          gateBuilder.controlled.pauliY,
          null,
          label);

  /// Adds a Pauli Z gate operating on [qubits]
  QCircuit pauliZ(dynamic qubits, {dynamic controls, String? label}) =>
      _buildAndAddGate(
          QGateType.pauliZ,
          qubits,
          controls,
          gateBuilder.parallel.pauliZ,
          gateBuilder.controlled.pauliZ,
          null,
          label);

  /// Adds a 'square root of not' (SQRT-NOT) gate operating on [qubits]
  QCircuit squareRootOfX(dynamic qubits, {dynamic controls, String? label}) =>
      _buildAndAddGate(
          QGateType.squareRootOfX,
          qubits,
          controls,
          gateBuilder.parallel.squareRootOfX,
          gateBuilder.controlled.squareRootOfX,
          null,
          label);

  /// Adds a 'square root of not' (SQRT-NOT) gate operating on [qubits]
  QCircuit sqrtOfNot(dynamic qubits, {dynamic controls, String? label}) =>
      squareRootOfX(qubits, controls: controls, label: label);

  /// Adds a phase gate operating on [qubits] with angle [radians]
  QCircuit phase(double radians, dynamic qubits,
          {dynamic controls, String? label}) =>
      _buildAndAddGate(
          QGateType.phase,
          qubits,
          controls,
          (qb) => gateBuilder.parallel.phase(radians, qb),
          (qb, {required Set<int> controls}) =>
              gateBuilder.controlled.phase(radians, qb, controls: controls),
          {'angle': radians},
          label);

  /// Adds a phase S gate operating on [qubits]
  QCircuit phaseS(dynamic qubits, {dynamic controls, String? label}) =>
      _buildAndAddGate(
          QGateType.phaseS,
          qubits,
          controls,
          gateBuilder.parallel.phaseS,
          gateBuilder.controlled.phaseS,
          null,
          label);

  /// Adds a phase T gate operating on [qubits]
  QCircuit phaseT(dynamic qubits, {dynamic controls, String? label}) =>
      _buildAndAddGate(
          QGateType.phaseT,
          qubits,
          controls,
          gateBuilder.parallel.phaseT,
          gateBuilder.controlled.phaseT,
          null,
          label);

  /// Adds a rotation X gate operating on [qubits]
  QCircuit rotationX(double radians, dynamic qubits,
          {dynamic controls, String? label}) =>
      _buildAndAddGate(
          QGateType.rotateX,
          qubits,
          controls,
          (qb) => gateBuilder.parallel.rotationX(radians, qb),
          (qb, {required Set<int> controls}) =>
              gateBuilder.controlled.rotationX(radians, qb, controls: controls),
          {'angle': radians},
          label);

  /// Adds a rotation Y gate operating on [qubits]
  QCircuit rotationY(double radians, dynamic qubits,
          {dynamic controls, String? label}) =>
      _buildAndAddGate(
          QGateType.rotateY,
          qubits,
          controls,
          (qb) => gateBuilder.parallel.rotationY(radians, qb),
          (qb, {required Set<int> controls}) =>
              gateBuilder.controlled.rotationY(radians, qb, controls: controls),
          {'angle': radians},
          label);

  /// Adds a rotation Z gate operating on [qubits]
  QCircuit rotationZ(double radians, dynamic qubits,
          {dynamic controls, String? label}) =>
      _buildAndAddGate(
          QGateType.rotateZ,
          qubits,
          controls,
          (qb) => gateBuilder.parallel.rotationZ(radians, qb),
          (qb, {required Set<int> controls}) =>
              gateBuilder.controlled.rotationZ(radians, qb, controls: controls),
          {'angle': radians},
          label);

  /// Adds a swap gate exchanging the supplied [qubits]
  /// [qubits] must be a [Set] containing 2 [int]s
  QCircuit swap(Set<int> qubits, {String? label}) => _addGate(QGateType.swap,
      gateBuilder.highLevel.swap(qubits), qubits, null, null, label);

  /// Adds a Fredkin (C-SWAP) gate exchanging the supplied [qubits] and controlled by the [control] qubit
  /// [qubits] must be a [Set] containing 2 [int]s
  QCircuit fredkin(Set<int> qubits, {required int control, String? label}) =>
      _addGate(
          QGateType.fredkin,
          gateBuilder.highLevel.fredkin(qubits, control: control),
          qubits,
          {control},
          null,
          label);

  /// Adds a Toffoli (CC-NOT) gate operating on [qubit] and controlled by qubits supplied in [controls]
  /// [controls] must be a [Set] containing 2 [int]s
  QCircuit toffoli(int qubit, {required Set<int> controls, String? label}) =>
      _addGate(
          QGateType.toffoli,
          gateBuilder.highLevel.toffoli(qubit, controls: controls),
          {qubit},
          controls,
          null,
          label);

  /// Adds a Quantum Fourrier Transform (QFT) gate operating on supplied [qubits]
  QCircuit qft(dynamic qubits, {bool swap = false, String? label}) {
    qubits = _getList(qubits);
    return _addGate(
        QGateType.qft,
        gateBuilder.highLevel.qft(qubits, reverse: swap),
        qubits.toSet(),
        null,
        null,
        label);
  }

  /// Adds an inverse Quantum Fourrier Transform (QFT) gate operating on supplied [qubits]
  QCircuit invQft(dynamic qubits, {bool swap = false, String? label}) {
    qubits = _getList(qubits);
    return _addGate(
        QGateType.invqft,
        gateBuilder.highLevel.invqft(qubits, reverse: swap),
        qubits.toSet(),
        null,
        null,
        label);
  }

  /// Registers an [observer] which will be notified during execution after each gate
  /// for [step] == 0, [gate] is `null` and [qreg] is in the initial state
  /// for [step] > 0, [gate] is the [step]th gate of the circuit and the state of [qreg] has already been transformed by the [gate]
  QCircuit addObserver(Observer observer) {
    _observers ??= <Observer>[];
    _observers!.add(observer);
    return this;
  }

  /// Removes an [observer]
  QCircuit removeObserver(Observer observer) {
    _observers?.remove(observer);
    return this;
  }

  void _notify(int step, QCircuitGate? gate, QMemorySpace qmem) {
    final observers = _observers;
    if (observers != null) {
      for (var observer in observers) {
        observer(step, gate, qmem);
      }
    }
  }

  /// Compile this [QCircuit] by multiplying the matrices of consecutive, non-measurement gates together
  /// Eventually, the original circuit will hold a sequence of custom Quantum gates + measurement gates
  /// If the circuit does not contain any measurement gates, it will be represented by a single custom gate
  QCircuit compile(
      {String? label, QGateType? type, Map<String, dynamic>? params}) {
    final compiledGates = <QCircuitGate>[];

    QCircuitGate? lastGate;
    var nbGates = 0;
    final identity = ComplexMatrix.identity(1 << size);
    var matrix = ComplexMatrix.zero(identity.rows, identity.columns);
    final labels = <String>[];
    final qubits = <int>{};
    final controls = <int>{};

    void _addCompiledGate() {
      if (nbGates > 0) {
        if (nbGates == 1) {
          // only one gate to compile: keep as is
          compiledGates.insert(0, lastGate!);
        } else {
          // remove qubits from control list if they are part of the transformation
          controls.removeWhere((i) => qubits.contains(i));
          final compiledGate = QCircuitGate(
              QGateType.compiled, matrix, qubits.toSet(),
              controls: controls.isEmpty ? null : controls.toSet(),
              circuit: this,
              label: labels.join(' followed by '));
          compiledGates.insert(0, compiledGate);
          matrix = ComplexMatrix.identity(1 << size);
          labels.clear();
          qubits.clear();
          controls.clear();
        }
        matrix.copy(identity);
      }
      labels.clear();
      qubits.clear();
      controls.clear();
      lastGate = null;
      nbGates = 0;
    }

    // merge gates except measurement gates
    // gate matrices must be multiplied in the reverse order of the gates
    for (var i = _gates.length - 1; i >= 0; i--) {
      final gate = _gates[i];
      if (gate.type == QGateType.separator) {
        // skip separator gate
      } else if (gate.type == QGateType.measure) {
        // measurement gate, keep as is for now
        _addCompiledGate();
        compiledGates.insert(0, gate);
      } else {
        if (nbGates == 0) {
          // first quantum gate
          lastGate = gate;
          matrix.copy(gate.matrix!);
        } else {
          // additional quantum gate
          matrix.mul(gate.matrix!);
        }
        nbGates++;
        labels.insert(0, gate.label);
        qubits.addAll(gate.qubits);
        controls.addAll(gate.controls);
        if (i == 0) {
          // last gate
          _addCompiledGate();
          break;
        }
      }
    }

    // merge measurement gates
    for (var i = 0; i < compiledGates.length - 1; i++) {
      final gate = compiledGates[i];
      if (gate.type == QGateType.measure) {
        QCircuitGate nextGate;
        qubits.clear();
        qubits.addAll(gate.qubits);
        while (i < compiledGates.length - 1 &&
            (nextGate = compiledGates[i + 1]).type == QGateType.measure) {
          if (nextGate.qubits.isEmpty) {
            // measure all qubits
            qubits.clear();
          } else if (qubits.isNotEmpty) {
            final tmp = qubits.followedBy(nextGate.qubits).toSet();
            qubits.clear();
            if (tmp.length < size) {
              // only a subset is measured
              qubits.addAll(tmp);
            }
          }
          compiledGates.removeAt(i + 1);
        }
        // replace sequence of measurement gates with a single measurement gate
        compiledGates[i] = QCircuitGate.measure(qubits, circuit: this);
      }
    }

    _gates.clear();
    if (compiledGates.length == 1 &&
        ((label != null && label.isNotEmpty) || type != null)) {
      _gates.add(compiledGates.first
          .copy(this, label: label, type: type, params: params));
    } else {
      _gates.addAll(compiledGates);
    }

    return this;
  }

  /// The index of the current gate for the next step execution
  /// When execution has not started, [_currentGate] = -1
  /// When execution has completed, [_currentGate] = length of [gates]
  int _currentGate = -1;

  /// Executes the circuit with Quantum register [qmem]
  /// If the circuit has already been partially executed with [step], the execution resumes from there.
  /// If the circuit has already been totally executed, execution restarts from scratch
  /// Observers registered with [addObserver] will be notified at each step
  void execute(QMemorySpace qmem) {
    if (_currentGate >= _gates.length) {
      _currentGate = -1;
    }
    while (step(qmem)) {}
  }

  /// Executes a single gate of the circuit with Quantum register [qmem]
  /// Observers registered with [addObserver] will be notified
  /// Returns `false` after the last gate has been executed, `true` otherwise.
  bool step(QMemorySpace qmem) {
    if (_currentGate < _gates.length) {
      // execute current step
      QCircuitGate? gate;
      if (_currentGate >= 0) {
        gate = _gates[_currentGate];
        gate.apply(qmem);
      }
      // notify and move on
      _currentGate++;
      _notify(_currentGate, gate, qmem);
    }
    return (_currentGate < _gates.length);
  }
}
