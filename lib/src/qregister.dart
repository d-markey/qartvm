import 'dart:math' as math;

import 'exceptions.dart';
import 'math/complex.dart';
import 'math/complex_array.dart';
import 'math/complex_matrix.dart';
import 'math/complex_vector.dart';
import 'qbit.dart';

/// Class representing a Quantum resgiter
class QRegister {
  //
  // register attributes
  //

  /// Builds a Quantum register with the input [qubits] as initial state
  QRegister(List<Qbit> qubits)
      : size = qubits.length,
        _states = List.generate(1 << qubits.length, (i) => '', growable: false),
        _amplitudes = ComplexArray.zero(1 << qubits.length) {
    _loadQubits(qubits, _states, _amplitudes);
    for (var id = 0; id < size; id++) {
      _qstates.add(QState._(this, id));
    }
  }

  /// Builds a register and initialize qubits based on bits in the input [byte]
  QRegister.load(int byte) : this(Qbit.fromInt(byte, count: 8).toList());

  /// Builds a register of specified [size], all qubits set to |0>
  QRegister.zero(int size) : this(List.generate(size, (i) => Qbit.zero));

  /// Builds a register of specified [size], all qubits set to |1>
  QRegister.one(int size) : this(List.generate(size, (i) => Qbit.one));

  /// Builds a register of specified [size], all qubits set to |+>
  QRegister.plus(int size) : this(List.generate(size, (i) => Qbit.plus));

  /// Builds a register of specified [size], all qubits set to |->
  QRegister.minus(int size) : this(List.generate(size, (i) => Qbit.minus));

  /// Builds a register of specified [size] with random qubits
  QRegister.random(int size) : this(List.generate(size, (i) => Qbit.random()));

  /// Builds a register of specified [size] and initializes qubits using the [generator] function
  QRegister.generate(int size, Qbit Function(int i) generator)
      : this(List.generate(size, generator));

  /// The register's size (number of qubits)
  final int size;

  final List<QState> _qstates = <QState>[];
  final List<String> _states;
  final ComplexArray _amplitudes;

  /// Resets the register with the specified [byte]
  void load(int byte) {
    _loadQubits(Qbit.fromInt(byte, count: size).toList(), _states, _amplitudes);
    for (var qstate in _qstates) {
      qstate._unmeasure();
    }
  }

  static void _loadQubits(
      List<Qbit> qubits, List<String> states, ComplexArray amplitudes) {
    Iterable<MapEntry<String, Complex>> _kronecker([int idx = 0]) sync* {
      final qubit = qubits[idx];
      if (idx == qubits.length - 1) {
        yield MapEntry('0', qubit.ket0);
        yield MapEntry('1', qubit.ket1);
      } else {
        // the loop order is important to have states & amplitudes in the same order as the tensor
        final k = _kronecker(idx + 1).toList();
        for (var e in k) {
          yield MapEntry('0${e.key}', qubit.ket0 * e.value);
        }
        for (var e in k) {
          yield MapEntry('1${e.key}', qubit.ket1 * e.value);
        }
      }
    }

    var idx = 0;
    for (var e in _kronecker()) {
      states[idx] = e.key;
      amplitudes.set(idx, e.value);
      idx++;
    }
  }

  //
  // states and amplitudes
  //

  /// Returns the state for qubit [id]
  QState operator [](int id) => _qstates[id];

  /// Returns the list of states with associated amplitudes
  Map<String, Complex> get amplitudes => Map.fromIterables(
      _states, Iterable.generate(_amplitudes.length, (i) => _amplitudes[i]));

  /// Returns the list of states with associated probabilities
  Map<String, double> get probabilities => Map.fromIterables(_states,
      Iterable.generate(_amplitudes.length, (i) => _amplitudes.modulus2(i)));

  static bool _match(String mask, String state) {
    if (mask.length != state.length) return false;
    for (var i = 0; i < state.length; i++) {
      if (state[i] != mask[i] && mask[i] != '.') return false;
    }
    return true;
  }

  /// Computes probability for the specified [mask] (such as '01100', '.0...' or '..1.0..', etc)
  double getPropability(String mask) {
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

  /// Applies a [gate] represented by a [ComplexMatrix] onto this register
  void applyGate(ComplexMatrix gate, Set<int> qubits) {
    final work = ComplexVector.zero(_amplitudes.length);
    work.copyFrom(_amplitudes);
    work.transform(gate);
    work.copyTo(_amplitudes);
    for (var qstate in _qstates.where((s) => qubits.contains(s.id))) {
      qstate._unmeasure();
    }
  }

  //
  // Measurement
  //

  /// Measures a set of [qubits].
  /// If some of the [qubits] have already been measured, no action is taken. For [qubits] that have not been measured yet,
  /// the qubit's state is forced to |0> or |1> depending on the current probabilities. If a measurement has been made,
  /// the states are collapsed accordingly and amplitudes are scaled so that total probablities amount to 100%.
  void measure({Set<int>? qubits}) {
    void _collapse() {
      // collapse amplitudes of qubits with non-null state
      var changed = false;
      for (var qubit in _qstates.where((q) => q.state != null)) {
        final qid = qubit.id;
        final qstate = qubit.state!;
        // check states
        for (var i = 0; i < _states.length; i++) {
          final state = _states[i];
          if (state[qid] != qstate && !_amplitudes.isZero(i)) {
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

    // measure all qubits by default
    qubits ??= <int>{};
    if (qubits.isEmpty) qubits.addAll(Iterable<int>.generate(size));
    for (var id in qubits) {
      if (_qstates[id].state == null) {
        // measure this qubit
        _qstates[id]._measure();
        // collapse states
        _collapse();
      }
    }
  }

  /// Reads a list of [qubits] (making measurements if appropriate) and returns the result as an [int].
  int read({List<int>? qubits}) {
    qubits = (qubits == null || qubits.isEmpty)
        ? Iterable<int>.generate(size).toList()
        : qubits;
    measure(qubits: qubits.toSet());
    var res = 0;
    for (var id in qubits) {
      res <<= 1;
      switch (_qstates[id].state) {
        case '0':
          break;
        case '1':
          res |= 1;
          break;
        default:
          throw InvalidQubitError();
      }
    }
    return res;
  }
}

/// Class representing the Quantum state of a qubit
class QState {
  static final _rnd = math.Random.secure();

  /// Builds a Quantum state for qubit [id] in [_register]
  QState._(this._register, this.id)
      : _mask = Iterable.generate(_register.size, (i) => i == id ? '0' : '.')
            .join();

  /// The qubit's [id]
  final int id;

  final String _mask;
  final QRegister _register;

  /// Returns the probability for the qubit to be |0> according to the current state of the [_register]
  double get zero => _register.getPropability(_mask);

  String? _state;
  String? get state => _state;

  // Measure the qubit unless a measurement was already made
  String _measure() {
    if (_state == null) {
      final zero = this.zero;
      final one = 1 - zero;
      if (zero >= one) {
        _state = (_rnd.nextDouble() <= zero) ? '0' : '1';
      } else {
        _state = (_rnd.nextDouble() <= one) ? '1' : '0';
      }
    }
    return state!;
  }

  // Resets the qubit state after a Quantum gate has been applied to the register.
  void _unmeasure() {
    _state = null;
  }
}
