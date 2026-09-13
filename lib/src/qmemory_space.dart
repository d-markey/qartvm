import 'dart:math' as math;
import 'dart:typed_data';

import 'math/_complex_array.dart';
import 'math/complex.dart';
import 'math/complex_matrix.dart';
import 'math/complex_vector.dart';
import 'qbit.dart';
import 'qregister.dart';
import 'qstate.dart';
import 'utils/exceptions.dart';

/// Measurement mode for quantum qubits.
enum QMeasureMode {
  /// Each qubit is measured independently, collapsing the state after each measurement.
  independent,

  /// All qubits are measured together, selecting a joint configuration based on the combined probabilities.
  joint,
}

/// Read-only view of a Quantum Memory Space.
abstract class QMemorySpaceView {
  /// Size of the Quantum memory space (total number of qubits)
  int get size;

  /// Returns the list of states with associated amplitudes
  Map<String, Complex> get amplitudes;

  /// Returns the list of states with associated probabilities
  Map<String, double> get probabilities;

  /// Formats the state string.
  String formatState(String state);

  /// Computes probability for the specified [mask].
  double getProbability(String mask);

  Map<String, double> getProbabilities(String mask);
}

/// A wrapper that restricts access to a [QMemorySpace] to read-only operations.
class QMemorySpaceViewWrapper implements QMemorySpaceView {
  final QMemorySpace _qmem;

  QMemorySpaceViewWrapper(this._qmem);

  @override
  int get size => _qmem.size;

  @override
  Map<String, Complex> get amplitudes => _qmem.amplitudes;

  @override
  Map<String, double> get probabilities => _qmem.probabilities;

  @override
  String formatState(String state) => _qmem.formatState(state);

  @override
  double getProbability(String mask) => _qmem.getProbability(mask);

  @override
  Map<String, double> getProbabilities(String mask) =>
      _qmem.getProbabilities(mask);
}

/// Class representing some Quantum memory
class QMemorySpace implements QMemorySpaceView {
  //
  // memory attributes
  //

  /// Builds a Quantum memory space with the input [qbits] as initial state
  QMemorySpace(List<Qbit> qbits)
    : size = qbits.length,
      _states = List.generate(1 << qbits.length, (i) => '', growable: false),
      _amplitudes = ComplexArray.zero(1 << qbits.length) {
    _loadQbits(qbits, _states, _amplitudes);
    for (var id = 0; id < size; id++) {
      _qstates.add(QStateImpl.ctor(this, QbitAddress(id)));
    }
  }

  /// Builds a Quantum memory space and initialize qubits based on bits in the input [number]
  QMemorySpace.load(int number, {int? size})
    : this(Qbit.fromInt(number, count: size ?? 8).toList());

  /// Creates a deep copy of this quantum memory state.
  QMemorySpace clone() {
    final copy = QMemorySpace.zero(size);
    copy._states.setAll(0, _states);
    copy._amplitudes.copy(_amplitudes);
    for (var i = 0; i < _qstates.length; i++) {
      copy._qstates[i].restoreState(_qstates[i].snapshotState());
    }
    for (final entry in _qregisters.entries) {
      copy._qregisters[entry.key] = QRegisterImpl.ctor(
        entry.key,
        copy,
        entry.value.qbits.toList(),
      );
    }
    return copy;
  }

  /// Builds a Quantum memory space of specified [size], all qubits set to |0>
  QMemorySpace.zero(int size) : this(List.generate(size, (i) => Qbit.zero));

  /// Builds a Quantum memory space of specified [size], all qubits set to |1>
  QMemorySpace.one(int size) : this(List.generate(size, (i) => Qbit.one));

  /// Builds a Quantum memory space of specified [size], all qubits set to |+>
  QMemorySpace.plus(int size) : this(List.generate(size, (i) => Qbit.plus));

  /// Builds a Quantum memory space of specified [size], all qubits set to |->
  QMemorySpace.minus(int size) : this(List.generate(size, (i) => Qbit.minus));

  /// Builds a Quantum memory space of specified [size] with random qubits
  QMemorySpace.random(int size)
    : this(List.generate(size, (i) => Qbit.random()));

  /// Builds a Quantum memory space of specified [size] and initializes qubits using the [generator] function
  QMemorySpace.generate(int size, Qbit Function(int i) generator)
    : this(List.generate(size, generator));

  /// Size of the Quantum memory space (total number of qubits)
  @override
  final int size;

  final List<QState> _qstates = <QState>[];
  final List<String> _states;
  final ComplexArray _amplitudes;

  /// Measurement mode for this memory space.
  QMeasureMode measureMode = QMeasureMode.independent;

  void load(int number) {
    final qbits = Qbit.fromInt(number, count: size).toList();
    _loadQbits(qbits, _states, _amplitudes);
    for (var qstate in _qstates) {
      qstate.reset();
    }
  }

  /// Sets the memory space with the specified [initializers].
  /// By default (e.g. if [initializers] is empty or not all qubits are covered by the [initializers]), qubits are set to zero (i.e. |0>).
  /// Registers in the initializer map will be loaded with the result produced by their initializer function, which may be an int, a [Qbit] or an [Iterable] of [Qbit]
  void initialize([Map? initializers]) {
    final qbits = List<Qbit>.filled(size, Qbit.zero);
    if (initializers != null) {
      for (var initializer in initializers.entries) {
        final reg = initializer.key;
        if (reg is QRegister) {
          // initialize register
          final rs = reg.size;
          var val = initializer.value;
          if (val is Function) {
            val = val();
          }
          if (val is int) {
            final rqbits = Qbit.fromInt(val, count: rs).toList();
            for (var i = 0; i < rs; i++) {
              qbits[reg[i].index] = rqbits[i];
            }
          } else if (val is Qbit) {
            for (var i = 0; i < rs; i++) {
              qbits[reg[i].index] = val;
            }
          } else if (val is Iterable<Qbit>) {
            final qval = val.toList();
            if (qval.length != rs) {
              throw InvalidOperationException(
                'Incompatible size for initialization value $qval and $rs-qubit register',
              );
            }
            for (var i = 0; i < rs; i++) {
              qbits[reg[i].index] = qval[i];
            }
          } else {
            throw InvalidOperationException(
              'Unsupported initialization value $val for register ${reg.name}',
            );
          }
        } else if (reg is int) {
          // initialize individual qubit
          var val = initializer.value;
          if (val is Function) {
            val = val();
          }
          if (val is int) {
            if (val != 0 && val != 1) {
              throw InvalidOperationException(
                'Unsupported initialization value $val for qubit $reg',
              );
            }
            qbits[reg] = (val == 0) ? Qbit.zero : Qbit.one;
          } else if (val is Qbit) {
            qbits[reg] = val;
          } else {
            throw InvalidOperationException(
              'Unsupported initialization value $val for qubit $reg',
            );
          }
        }
      }
    }
    _loadQbits(qbits, _states, _amplitudes);
    for (var qstate in _qstates) {
      qstate.reset();
    }
  }

  static void _loadQbits(
    List<Qbit> values,
    List<String> states,
    ComplexArray amplitudes,
  ) {
    Iterable<MapEntry<String, Complex>> $kronecker([int idx = 0]) sync* {
      final value = values[idx];
      if (idx == values.length - 1) {
        yield MapEntry('0', value.ket0);
        yield MapEntry('1', value.ket1);
      } else {
        // the loop order is important to have states & amplitudes in the same order as the tensor
        final k = $kronecker(idx + 1).toList();
        for (var e in k) {
          yield MapEntry('0${e.key}', value.ket0 * e.value);
        }
        for (var e in k) {
          yield MapEntry('1${e.key}', value.ket1 * e.value);
        }
      }
    }

    var idx = 0;
    for (var e in $kronecker()) {
      states[idx] = e.key;
      amplitudes.set(idx, e.value);
      idx++;
    }
  }

  //
  // registers
  //

  final Map<String, QRegister> _qregisters = <String, QRegister>{};

  /// Creates a quantum register in this memory space
  QRegister createRegister(
    String name, {
    List<QbitAddress>? addresses,
    QbitAddress? from,
    QbitAddress? to,
    QbitAddress? at,
  }) {
    if (_qregisters.containsKey(name)) {
      throw InvalidOperationException('Regsiter $name already exists');
    }
    if (addresses == null) {
      addresses = [];
      if (at != null) {
        if (from != null || to != null) {
          throw InvalidOperationException(
            'Parareters "to" and "from" must be null if "at" is provided',
          );
        }
        addresses.add(at);
      } else if (from != null && to != null) {
        final d = (to.index >= from.index) ? 1 : -1;
        for (var i = from.index; i != to.index + d; i += d) {
          addresses.add(QbitAddress(i));
        }
      } else {
        throw InvalidOperationException(
          'Both parareters "to" and "from" must be provided if "at" and "addresses" are null',
        );
      }
    } else {
      if (at != null || from != null || to != null) {
        throw InvalidOperationException(
          'Parareters "at", "to" and "from" must be null if "addresses" is provided',
        );
      }
    }
    if (addresses.any((i) => i.index < 0 || i.index >= size)) {
      throw InvalidOperationException(
        'Invalid qubit addresses: ${addresses.where((i) => i.index < 0 || i.index >= size)}, memory space size = $size',
      );
    }
    return (_qregisters[name] = QRegisterImpl.ctor(name, this, addresses));
  }

  QRegister? findRegister(QbitAddress i) {
    for (var qreg in _qregisters.values) {
      for (var j = 0; j < qreg.size; j++) {
        if (qreg[j] == i) return qreg;
      }
    }
    return null;
  }

  String getLogicalName(QbitAddress i) {
    final qreg = findRegister(i);
    return (qreg == null) ? '#$i:' : '#$i: ${qreg.name}[${qreg.indexOf(i)}]';
  }

  @override
  String formatState(String state) {
    var s = state[0];
    QRegister? last = findRegister(QbitAddress(0));
    for (var i = 1; i < size; i++) {
      final q = findRegister(QbitAddress(i));
      if (q != last) {
        s += ' ';
      }
      s += state[i];
      last = q;
    }
    return s;
  }

  //
  // states and amplitudes
  //

  /// Returns the state for qubit [id]
  QState operator [](int id) => _qstates[id];

  /// Returns the list of states with associated amplitudes
  @override
  Map<String, Complex> get amplitudes => Map.fromIterables(
    _states,
    Iterable.generate(_amplitudes.length, (i) => _amplitudes[i]),
  );

  /// Returns the list of states with associated probabilities
  @override
  Map<String, double> get probabilities => Map.fromIterables(
    _states,
    Iterable.generate(_amplitudes.length, (i) => _amplitudes.modulus2(i)),
  );

  /// Computes probability for the specified [mask] (such as '01100', '.0...' or '..1.0..', etc)
  /// [mask] may contain spaces to group qubits together (such as '0000 0000', '0000 ....', etc)
  @override
  Map<String, double> getProbabilities(String mask) {
    mask = mask.replaceAll(' ', '');
    final Map<String, double> res = {};
    for (var i = 0; i < _states.length; i++) {
      final k = _key(mask, _states[i]);
      final p = _amplitudes.modulus2(i);
      res.update(k, (s) => s + p, ifAbsent: () => p);
    }
    return res;
  }

  static String _key(String mask, String state) {
    if (mask.length != state.length) return '';
    final sb = StringBuffer();
    for (var i = 0; i < state.length; i++) {
      final m = mask[i];
      if (state[i] == m || m == '*') {
        sb.write(state[i]);
      } else if (m == '.') {
        sb.write('-');
      }
    }
    return sb.toString();
  }

  static bool _match(String mask, String state) {
    if (mask.length != state.length) return false;
    for (var i = 0; i < state.length; i++) {
      final m = mask[i];
      if (state[i] != m && m != '*' && m != '.') return false;
    }
    return true;
  }

  /// Computes probability for the specified [mask] (such as '01100', '.0...' or '..1.0..', etc)
  /// [mask] may contain spaces to group qubits together (such as '0000 0000', '0000 ....', etc)
  @override
  double getProbability(String mask) {
    mask = mask.replaceAll(' ', '');
    double p = 0;
    for (var i = 0; i < _states.length; i++) {
      if (_match(mask, _states[i])) {
        p += _amplitudes.modulus2(i);
      }
    }
    return p <= 1 ? p : 1;
  }

  //
  // quantum transformation
  //

  /// Applies a [gate] represented by a [ComplexMatrix] onto this Quantum memory space
  void applyGate(ComplexMatrix gate, Iterable<QbitAddress> qubits) {
    final qubitSet = qubits.toSet();
    // If the gate is full-size, use the standard transform
    if (gate.rows == (1 << size)) {
      final work = ComplexVector.zero(_amplitudes.length);
      work.copyFrom(_amplitudes);
      work.transform(gate);
      work.copyTo(_amplitudes);
    } else {
      // Apply local gate efficiently without expanding to full Hilbert space
      _applyLocalGate(gate, qubits.toList());
    }

    for (var qstate in _qstates.where((s) => qubitSet.contains(s.id))) {
      qstate.reset();
    }
  }

  void _applyLocalGate(ComplexMatrix localGate, List<QbitAddress> qubits) {
    final k = qubits.length;
    final dim = 1 << k;

    // 1. Pre-calculate Sparse Matrix Structure
    final nzRows = Int32List(dim * dim);
    final nzCols = Int32List(dim * dim);
    final nzValsRe = Float64List(dim * dim);
    final nzValsIm = Float64List(dim * dim);
    var nzCount = 0;

    for (var r = 0; r < dim; r++) {
      for (var c = 0; c < dim; c++) {
        final v = localGate.get(r, c);
        if (!v.isZero) {
          nzRows[nzCount] = r;
          nzCols[nzCount] = c;
          nzValsRe[nzCount] = v.re;
          nzValsIm[nzCount] = v.im;
          nzCount++;
        }
      }
    }

    final masks = qubits.map((q) => q.bigEndianMask(size)).toList();
    final subIndices = Int32List(dim);
    for (var i = 0; i < dim; i++) {
      var index = 0;
      for (var j = 0; j < k; j++) {
        if ((i >> (k - 1 - j)) & 1 == 1) index |= masks[j];
      }
      subIndices[i] = index;
    }

    // 2. High-Speed Bit-Spread Indexing
    final targetMask = masks.reduce((a, b) => a | b);
    final invTargetMask = ~targetMask;
    final data = _amplitudes.values;

    // Local work buffers (allocation-free)
    final workRe = Float64List(dim);
    final workIm = Float64List(dim);
    final resRe = Float64List(dim);
    final resIm = Float64List(dim);

    // Main Simulation Loop - O(2^(N-k))
    final iterations = 1 << (size - k);
    var baseIndex = 0;
    for (var i = 0; i < iterations; i++) {
      // 1. Gather
      for (var j = 0; j < dim; j++) {
        final idx = (baseIndex | subIndices[j]) << 1;
        workRe[j] = data[idx];
        workIm[j] = data[idx + 1];
      }

      // 2. Sparse Transform
      resRe.fillRange(0, dim, 0);
      resIm.fillRange(0, dim, 0);
      for (var n = 0; n < nzCount; n++) {
        final r = nzRows[n], c = nzCols[n];
        final vre = nzValsRe[n], vim = nzValsIm[n];
        final wre = workRe[c], wim = workIm[c];
        resRe[r] += vre * wre - vim * wim;
        resIm[r] += vre * wim + vim * wre;
      }

      // 3. Scatter
      for (var j = 0; j < dim; j++) {
        final idx = (baseIndex | subIndices[j]) << 1;
        data[idx] = resRe[j];
        data[idx + 1] = resIm[j];
      }

      // 4. Constant-Time Increment to next bit-hole
      baseIndex = (baseIndex - invTargetMask) & invTargetMask;
    }
  }

  //
  // Measurement
  //

  void _collapse() {
    // collapse amplitudes of qubits with non-null state
    var changed = false;
    for (var qubit in _qstates.where((q) => q.state != null)) {
      final qid = qubit.id;
      final qstate = qubit.state!;
      // check states
      for (var i = 0; i < _states.length; i++) {
        final state = _states[i];
        if (state[qid.index] != qstate && !_amplitudes.isZero(i)) {
          // collapse
          _amplitudes.set(i, Complex.zero);
          changed = true;
        }
      }
    }
    if (changed) {
      // normalize amplitudes
      // multiple iterations (max 5) to try and obtain a sum of 1
      var sum = 0.0;
      for (var i = 0; i < _amplitudes.length; i++) {
        sum += _amplitudes.modulus2(i);
      }
      var prevsum = 0.0;
      var maxIterations = 5;
      while (sum != 1 && sum != prevsum && maxIterations > 0) {
        _amplitudes.unscale(math.sqrt(sum));
        maxIterations--;
        prevsum = sum;
        sum = 0.0;
        for (var i = 0; i < _amplitudes.length; i++) {
          sum += _amplitudes.modulus2(i);
        }
      }
    }
  }

  /// Measures a set of [qbits].
  /// If some of the [qbits] have already been measured, no action is taken. For [qbits] that have not been measured yet,
  /// the qubit's state is forced to |0> or |1> depending on the current probabilities. If a measurement has been made,
  /// the states are collapsed accordingly and amplitudes are scaled so that total probablities amount to 100%.
  /// The [mode] parameter controls how the measurement is performed: [QMeasureMode.independent] (default) measures each
  /// qubit one by one and collapses the state after each measurement, while [QMeasureMode.joint] computes probabilities
  /// for all possible configurations of the qubits and selects one configuration to collapse the entire state at once.
  void measure({Set<QbitAddress>? qbits, QMeasureMode? mode}) {
    // use the default mode if not specified
    mode ??= measureMode;

    // measure all qubits by default
    qbits ??= <QbitAddress>{};
    if (qbits.isEmpty) qbits.addAll(Iterable<QbitAddress>.generate(size));

    // only measure qubits that have not been measured yet
    final toMeasure = qbits
        .where((id) => _qstates[id.index].state == null)
        .toList();
    if (toMeasure.isEmpty) return;

    if (mode == QMeasureMode.independent || toMeasure.length == 1) {
      for (var id in toMeasure) {
        // measure this qubit
        _qstates[id.index].read();
        // collapse states
        _collapse();
      }
    } else {
      // joint measurement
      // 1. Sort to ensure consistency (optional but good practice)
      toMeasure.sort((a, b) => a.index.compareTo(b.index));

      // 2. Create mask: use '*' for qubits to measure, and '.' for others.
      // This ensures that getProbabilities returns keys of length 'size' with '-' at '.' positions.
      final measuredIndices = toMeasure.map((q) => q.index).toSet();
      final mask = Iterable.generate(size, (i) {
        if (measuredIndices.contains(i)) return '*';
        return '.';
      }).join();

      // 3. Get probabilities
      final probs = getProbabilities(mask);

      // 4. Pick configuration
      final rnd = math.Random.secure();
      var r = rnd.nextDouble();
      String? pickedKey;
      for (final entry in probs.entries) {
        r -= entry.value;
        if (r <= 0) {
          pickedKey = entry.key;
          break;
        }
      }
      pickedKey ??= probs.keys.last;

      // 5. Assign states
      for (var i = 0; i < toMeasure.length; i++) {
        final id = toMeasure[i].index;
        _qstates[id].restoreState(pickedKey[id]);
      }

      // 6. Single collapse
      _collapse();
    }
  }

  /// Reads a list of [qbits] (making measurements if appropriate) and returns the result as an [int].
  int read({dynamic qbits, QMeasureMode? mode, bool debug = false}) {
    final List<QbitAddress> $qbits;
    if (qbits == null || qbits is Iterable && qbits.isEmpty) {
      $qbits = List<QbitAddress>.generate(size, QbitAddress.new);
    } else if (qbits is int) {
      $qbits = [QbitAddress(qbits)];
    } else if (qbits is QbitAddress) {
      $qbits = [qbits];
    } else if (qbits is List &&
        qbits.every((q) => q is int || q is QbitAddress)) {
      // nothing to do
      $qbits = qbits.cast<QbitAddress>();
    } else if (qbits is Iterable &&
        qbits.every((q) => q is int || q is QbitAddress)) {
      $qbits = qbits.cast<QbitAddress>().toList();
    } else if (qbits is QRegister) {
      $qbits = qbits.qbits;
    } else {
      throw InvalidOperationException('Cannot read from ${qbits.runtimeType}');
    }
    measure(qbits: $qbits.toSet(), mode: mode);
    var res = 0, b = 1;
    for (var id in $qbits) {
      switch (_qstates[id.index].state) {
        case '0':
          break;
        case '1':
          res |= b;
          break;
        default:
          throw InvalidQbitError();
      }
      b *= 2;
    }
    return res;
  }
}
