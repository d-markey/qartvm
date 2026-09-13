import 'math/complex_matrix.dart';
import 'math/complex_sparse_matrix.dart';
import 'qcircuit_gate.dart';
import 'qgate_builder.dart';
import 'qgate_type.dart';
import 'qmemory_space.dart';
import 'qregister.dart';
import 'qstate.dart';
import 'utils/exceptions.dart';

typedef Observer =
    void Function(int step, QCircuitGate? gate, QMemorySpace qmem);

List<QbitAddress> _getList(dynamic qbits) {
  if (qbits is int) {
    return [QbitAddress(qbits)];
  } else if (qbits is QbitAddress) {
    return [qbits];
  } else if (qbits is QRegister) {
    return qbits.qbits;
  } else if (qbits is List &&
      qbits.isNotEmpty &&
      qbits.every((q) => q is int || q is QbitAddress)) {
    return qbits.cast<QbitAddress>();
  } else if (qbits is Iterable &&
      qbits.isNotEmpty &&
      qbits.every((q) => q is int || q is QbitAddress)) {
    return qbits.cast<QbitAddress>().toList();
  } else {
    throw InvalidOperationException(
      'Expected a register, a single qubit or a non-empty collection of qubits',
    );
  }
}

Set<QbitAddress> _getSet(dynamic qbits) {
  if (qbits is int) {
    return {QbitAddress(qbits)};
  } else if (qbits is QbitAddress) {
    return {qbits};
  } else if (qbits is QRegister) {
    return qbits.qbits.toSet();
  } else if (qbits is Iterable &&
      qbits.isNotEmpty &&
      qbits.every((q) => q is int)) {
    return qbits.cast<QbitAddress>().toSet();
  } else {
    throw InvalidOperationException(
      'Expected a register, a single qubit or a non-empty collection of qubits',
    );
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
      _gates[_gates.length - 1] = QCircuitGate.separation(
        circuit: this,
        label: mlabel,
      );
    } else {
      _gates.add(QCircuitGate.separation(circuit: this, label: label));
    }
    return this;
  }

  /// Adds a measurement gate to the circuit
  /// Qubits [qbits] will be measured
  /// If [qbits] is null or empty, all qubits will be measured
  QCircuit measure([Set<QbitAddress>? qbits, String? label]) {
    _gates.add(QCircuitGate.measure(qbits, circuit: this, label: label));
    return this;
  }

  /// Appends the gates of [other] circuit to this instance.
  /// if [dagger] is `true`, reverse gates (with dagger matrix) are appended in reverse order.
  /// Both circuits must have the same size
  QCircuit append(
    QCircuit other, {
    dynamic controls,
    bool dagger = false,
    bool merge = true,
  }) {
    if (other.size != size) {
      throw InvalidOperationException(
        'Cannot append circuit of size ${other.size} to circuit of size $size',
      );
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

  QCircuit _addGate(
    QGateType type,
    ComplexMatrix matrix,
    Set<QbitAddress> qbits,
    Set<QbitAddress>? controls,
    Map<String, dynamic>? params,
    String? label,
  ) {
    if (!matrix.isSquare) {
      throw InvalidOperationException('Gate matrix must be square');
    }

    final dim = matrix.rows;
    final fullDim = 1 << size;
    final k = qbits.length + (controls?.length ?? 0);
    final localDim = 1 << k;

    if (dim != fullDim && dim != localDim && dim != 2) {
      throw InvalidOperationException(
        'Invalid gate ${matrix.rows}x${matrix.columns} for $k-qubit operation '
        'in $size-qubit circuit',
      );
    }

    _gates.add(
      QCircuitGate(
        type,
        matrix,
        qbits,
        controls: controls,
        circuit: this,
        params: params,
        label: label,
      ),
    );
    return this;
  }

  QCircuit _buildAndAddGate(
    QGateType type,
    dynamic qbits,
    dynamic controls,
    ComplexMatrix Function(Set<QbitAddress>) gateBuilder,
    ComplexMatrix Function(
      Set<QbitAddress>, {
      required Set<QbitAddress> controls,
    })
    cgateBuilder,
    Map<String, dynamic>? params,
    String? label,
  ) {
    final qb = _getSet(qbits);
    final cqb = (controls == null || (controls is Iterable && controls.isEmpty))
        ? null
        : _getSet(controls);
    final matrix = (cqb == null)
        ? gateBuilder(qb)
        : cgateBuilder(qb, controls: cqb);
    return _addGate(type, matrix, qb, cqb, params, label);
  }

  /// Adds a custom [gate] to the circuit operating on [qbits] and optionally controlled by [controls] qubits.
  /// [qbits] and [controls] may be single [int]s or [Iterable]s of [int]s.
  /// The gate may be represented by a 2x2 [ComplexMatrix] in which case [qbits] must contain a single qubit and [controls] must be `null` or empty.
  /// Alternatively, the gate may be represented by a square [ComplexMatrix] of size 2^[size] operating on the circuit's full state.
  QCircuit custom(
    dynamic qbits,
    ComplexMatrix gate, {
    dynamic controls,
    QGateType type = QGateType.custom,
    Map<String, dynamic>? params,
    String? label,
  }) {
    assert(type.isCustom);
    return _buildAndAddGate(
      type,
      qbits,
      controls,
      (qb) => gateBuilder.parallel.build(qb, gate),
      (qb, {required Set<QbitAddress> controls}) =>
          gateBuilder.controlled.build(qb, gate, controls: controls),
      params,
      label,
    );
  }

  /// Adds a Hadamard gate operating on [qbits] and controlled by [controls] if provided
  QCircuit hadamard(dynamic qbits, {dynamic controls, String? label}) =>
      _buildAndAddGate(
        QGateType.hadamard,
        qbits,
        controls,
        gateBuilder.parallel.hadamard,
        gateBuilder.controlled.hadamard,
        null,
        label,
      );

  /// Adds a Pauli X (NOT) gate operating on [qbits] and controlled by [controls] if provided
  QCircuit pauliX(dynamic qbits, {dynamic controls, String? label}) =>
      _buildAndAddGate(
        QGateType.pauliX,
        qbits,
        controls,
        gateBuilder.parallel.pauliX,
        gateBuilder.controlled.pauliX,
        null,
        label,
      );

  /// Adds a Pauli X (NOT) gate operating on [qbits]
  QCircuit not(dynamic qbits, {dynamic controls, String? label}) =>
      pauliX(qbits, controls: controls, label: label);

  /// Adds a Pauli Y gate operating on [qbits]
  QCircuit pauliY(dynamic qbits, {dynamic controls, String? label}) =>
      _buildAndAddGate(
        QGateType.pauliY,
        qbits,
        controls,
        gateBuilder.parallel.pauliY,
        gateBuilder.controlled.pauliY,
        null,
        label,
      );

  /// Adds a Pauli Z gate operating on [qbits]
  QCircuit pauliZ(dynamic qbits, {dynamic controls, String? label}) =>
      _buildAndAddGate(
        QGateType.pauliZ,
        qbits,
        controls,
        gateBuilder.parallel.pauliZ,
        gateBuilder.controlled.pauliZ,
        null,
        label,
      );

  /// Adds a 'square root of not' (SQRT-NOT) gate operating on [qbits]
  QCircuit squareRootOfX(dynamic qbits, {dynamic controls, String? label}) =>
      _buildAndAddGate(
        QGateType.squareRootOfX,
        qbits,
        controls,
        gateBuilder.parallel.squareRootOfX,
        gateBuilder.controlled.squareRootOfX,
        null,
        label,
      );

  /// Adds a 'square root of not' (SQRT-NOT) gate operating on [qbits]
  QCircuit sqrtOfNot(dynamic qbits, {dynamic controls, String? label}) =>
      squareRootOfX(qbits, controls: controls, label: label);

  /// Adds a phase gate operating on [qbits] with angle [radians]
  QCircuit phase(
    double radians,
    dynamic qbits, {
    dynamic controls,
    String? label,
  }) => _buildAndAddGate(
    QGateType.phase,
    qbits,
    controls,
    (qb) => gateBuilder.parallel.phase(radians, qb),
    (qb, {required Set<QbitAddress> controls}) =>
        gateBuilder.controlled.phase(radians, qb, controls: controls),
    {'angle': radians},
    label,
  );

  /// Adds a phase S gate operating on [qbits]
  QCircuit phaseS(dynamic qbits, {dynamic controls, String? label}) =>
      _buildAndAddGate(
        QGateType.phaseS,
        qbits,
        controls,
        gateBuilder.parallel.phaseS,
        gateBuilder.controlled.phaseS,
        null,
        label,
      );

  /// Adds a phase T gate operating on [qbits]
  QCircuit phaseT(dynamic qbits, {dynamic controls, String? label}) =>
      _buildAndAddGate(
        QGateType.phaseT,
        qbits,
        controls,
        gateBuilder.parallel.phaseT,
        gateBuilder.controlled.phaseT,
        null,
        label,
      );

  /// Adds a rotation X gate operating on [qbits]
  QCircuit rotationX(
    double radians,
    dynamic qbits, {
    dynamic controls,
    String? label,
  }) => _buildAndAddGate(
    QGateType.rotateX,
    qbits,
    controls,
    (qb) => gateBuilder.parallel.rotationX(radians, qb),
    (qb, {required Set<QbitAddress> controls}) =>
        gateBuilder.controlled.rotationX(radians, qb, controls: controls),
    {'angle': radians},
    label,
  );

  /// Adds a rotation Y gate operating on [qbits]
  QCircuit rotationY(
    double radians,
    dynamic qbits, {
    dynamic controls,
    String? label,
  }) => _buildAndAddGate(
    QGateType.rotateY,
    qbits,
    controls,
    (qb) => gateBuilder.parallel.rotationY(radians, qb),
    (qb, {required Set<QbitAddress> controls}) =>
        gateBuilder.controlled.rotationY(radians, qb, controls: controls),
    {'angle': radians},
    label,
  );

  /// Adds a rotation Z gate operating on [qbits]
  QCircuit rotationZ(
    double radians,
    dynamic qbits, {
    dynamic controls,
    String? label,
  }) => _buildAndAddGate(
    QGateType.rotateZ,
    qbits,
    controls,
    (qb) => gateBuilder.parallel.rotationZ(radians, qb),
    (qb, {required Set<QbitAddress> controls}) =>
        gateBuilder.controlled.rotationZ(radians, qb, controls: controls),
    {'angle': radians},
    label,
  );

  /// Adds a swap gate exchanging the supplied [qbits]
  /// [qbits] must be a [Set] containing 2 [int]s
  QCircuit swap(Set<QbitAddress> qbits, {String? label}) => _addGate(
    QGateType.swap,
    gateBuilder.highLevel.swap(qbits),
    qbits,
    null,
    null,
    label,
  );

  /// Adds a Fredkin (C-SWAP) gate exchanging the supplied [qbits] and controlled by the [control] qubit
  /// [qbits] must be a [Set] containing 2 [int]s
  QCircuit fredkin(
    Set<QbitAddress> qbits, {
    required QbitAddress control,
    String? label,
  }) => _addGate(
    QGateType.fredkin,
    gateBuilder.highLevel.fredkin(qbits, control: control),
    qbits,
    {control},
    null,
    label,
  );

  /// Adds a Toffoli (CC-NOT) gate operating on [qbit] and controlled by qubits supplied in [controls]
  /// [controls] must be a [Set] containing 2 [int]s
  QCircuit toffoli(
    QbitAddress qbit, {
    required Set<QbitAddress> controls,
    String? label,
  }) => _addGate(
    QGateType.toffoli,
    gateBuilder.highLevel.toffoli(qbit, controls: controls),
    {qbit},
    controls,
    null,
    label,
  );

  /// Adds a Quantum Fourrier Transform (QFT) gate operating on supplied [qbits]
  QCircuit qft(dynamic qbits, {bool swap = false, String? label}) {
    qbits = _getList(qbits);
    return _addGate(
      QGateType.qft,
      gateBuilder.highLevel.qft(qbits, reverse: swap),
      qbits.toSet(),
      null,
      null,
      label,
    );
  }

  /// Adds an inverse Quantum Fourrier Transform (QFT) gate operating on supplied [qbits]
  QCircuit invQft(dynamic qbits, {bool swap = false, String? label}) {
    qbits = _getList(qbits);
    return _addGate(
      QGateType.invqft,
      gateBuilder.highLevel.invqft(qbits, reverse: swap),
      qbits.toSet(),
      null,
      null,
      label,
    );
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
  QCircuit compile({
    String? label,
    QGateType? type,
    Map<String, dynamic>? params,
  }) {
    final compiledGates = <QCircuitGate>[];

    QCircuitGate? lastGate;
    var nbGates = 0;
    final identity = ComplexSparseMatrix.identity(1 << size);
    var matrix = ComplexSparseMatrix.zero(identity.rows, identity.columns);
    final labels = <String>[];
    final qbits = <QbitAddress>{};
    final controls = <QbitAddress>{};

    void $addCompiledGate() {
      if (nbGates > 0) {
        if (nbGates == 1) {
          // only one gate to compile: keep as is
          compiledGates.insert(0, lastGate!);
        } else {
          // remove qubits from control list if they are part of the transformation
          controls.removeWhere((i) => qbits.contains(i));
          final compiledGate = QCircuitGate(
            QGateType.compiled,
            matrix,
            qbits.toSet(),
            controls: controls.isEmpty ? null : controls.toSet(),
            circuit: this,
            label: labels.join(' followed by '),
          );
          compiledGates.insert(0, compiledGate);
          matrix = ComplexSparseMatrix.identity(1 << size);
          labels.clear();
          qbits.clear();
          controls.clear();
        }
        matrix.copy(identity);
      }
      labels.clear();
      qbits.clear();
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
        $addCompiledGate();
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
        qbits.addAll(gate.qbits);
        controls.addAll(gate.controls);
        if (i == 0) {
          // last gate
          $addCompiledGate();
          break;
        }
      }
    }

    // merge measurement gates
    for (var i = 0; i < compiledGates.length - 1; i++) {
      final gate = compiledGates[i];
      if (gate.type == QGateType.measure) {
        QCircuitGate nextGate;
        qbits.clear();
        qbits.addAll(gate.qbits);
        while (i < compiledGates.length - 1 &&
            (nextGate = compiledGates[i + 1]).type == QGateType.measure) {
          if (nextGate.qbits.isEmpty) {
            // measure all qubits
            qbits.clear();
          } else if (qbits.isNotEmpty) {
            final tmp = qbits.followedBy(nextGate.qbits).toSet();
            qbits.clear();
            if (tmp.length < size) {
              // only a subset is measured
              qbits.addAll(tmp);
            }
          }
          compiledGates.removeAt(i + 1);
        }
        // replace sequence of measurement gates with a single measurement gate
        compiledGates[i] = QCircuitGate.measure(qbits, circuit: this);
      }
    }

    _gates.clear();
    if (compiledGates.length == 1 &&
        ((label != null && label.isNotEmpty) || type != null)) {
      _gates.add(
        compiledGates.first.copy(
          this,
          label: label,
          type: type,
          params: params,
        ),
      );
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
