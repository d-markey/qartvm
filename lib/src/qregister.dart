import 'dart:math' as math;

import 'exceptions.dart';
import 'math/complex.dart';
import 'math/complex_array.dart';
import 'math/complex_matrix.dart';
import 'math/complex_vector.dart';
import 'qstate.dart';
import 'qbit.dart';

class QRegister {
  //
  // register attributes
  //

  /// builds a register with the input qubits as initial state
  QRegister(List<Qbit> qubits)
      : size = qubits.length,
        _states = List.generate(1 << qubits.length, (i) => '', growable: false),
        _amplitudes = ComplexArray.zero(1 << qubits.length) {
    _loadQubits(qubits, _states, _amplitudes);
    for (var id = 0; id < size; id++) {
      _qubits.add(QState(id, this));
    }
  }

  /// builds a register and initialize qubits based on bits in the input byte
  QRegister.load(int byte) : this(_initQubits(byte));

  /// builds a register of specified size, all qubits set to |0>
  QRegister.zero(int size) : this(List.generate(size, (i) => Qbit.zero));

  /// builds a register of specified size, all qubits set to |1>
  QRegister.one(int size) : this(List.generate(size, (i) => Qbit.one));

  /// builds a register of specified size, all qubits set to |0>
  QRegister.plus(int size) : this(List.generate(size, (i) => Qbit.plus));

  /// builds a register of specified size, all qubits set to |1>
  QRegister.minus(int size) : this(List.generate(size, (i) => Qbit.minus));

  /// builds a register of specified size with random qubits
  QRegister.random(int size) : this(List.generate(size, (i) => Qbit.random()));

  /// builds a register of specified size with generated qubits
  QRegister.generate(int size, Qbit Function(int i) generator)
      : this(List.generate(size, generator));

  /// register size (number of qubits)
  final int size;

  final List<QState> _qubits = <QState>[];
  final List<String> _states;
  final ComplexArray _amplitudes;

  /// reset the register with the specified byte
  void load(int byte) {
    if (size != 8) throw InvalidOperationException();
    _loadQubits(_initQubits(byte), _states, _amplitudes);
    for (var id = 0; id < size; id++) {
      _qubits[id].unmeasure();
    }
  }

  static List<Qbit> _initQubits(int byte) {
    var i = 0;
    final qubits = <Qbit>[];
    while (i < 8) {
      final b = (byte & (1 << i)) >> i;
      qubits.add(b == 0 ? Qbit.zero : Qbit.one);
      i++;
    }
    return qubits;
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

  /// gets the qubit for [id]
  QState operator [](int id) => _qubits[id];

  /// gets the list of states with associated amplitudes
  Map<String, Complex> get amplitudes {
    _collapse();
    return Map.fromIterables(
        _states, Iterable.generate(_amplitudes.length, (i) => _amplitudes[i]));
  }

  /// gets the list of states with associated probabilities
  Map<String, double> get probabilities {
    _collapse();
    return Map.fromIterables(_states,
        Iterable.generate(_amplitudes.length, (i) => _amplitudes.modulus2(i)));
  }

  static bool _match(String mask, String state) {
    if (mask.length != state.length) return false;
    for (var i = 0; i < state.length; i++) {
      if (state[i] != mask[i] && mask[i] != '.') return false;
    }
    return true;
  }

  /// gets probability for the specified mask
  double getPropability(String mask) {
    _collapse();
    double p = 0;
    for (var i = 0; i < _states.length; i++) {
      if (_match(mask, _states[i])) {
        // print('      ${_states[i]} matches $mask with p = ${_amplitudes.modulus2(i)}');
        p += _amplitudes.modulus2(i);
      } else {
        // print('      ${_states[i]} does not match $mask');
      }
    }
    return p <= 1 ? p : 1;
  }

  //
  // quantum transformation
  //

  /// applies a [gate] defined by its matrix to the register
  void applyGate(ComplexMatrix gate) {
    final v = ComplexVector(
        Iterable.generate(_amplitudes.length, (i) => _amplitudes[i]).toList());
    v.transform(gate);
    v.copyTo(_amplitudes);
    for (var qubit in _qubits) {
      qubit.unmeasure();
    }
  }

  //
  // measurement
  //

  /// measures a set of qubits
  void measure({Set<int>? qubits}) {
    // measure all qubits by default
    qubits ??= <int>{};
    if (qubits.isEmpty) qubits.addAll(Iterable.generate(size, (i) => i));
    for (var id in qubits) {
      if (_qubits[id].state == null) {
        // measure this qubit
        _qubits[id].measure();
        // collapse states
        _collapse();
      }
    }
  }

  int read({List<int>? qubits}) {
    qubits ??= <int>[];
    if (qubits.isEmpty) qubits.addAll(Iterable.generate(size, (i) => i));
    measure(qubits: qubits.toSet());
    int res = 0;
    for (var id in qubits) {
      res <<= 1;
      switch (_qubits[id].state) {
        case '0':
          break;
        case '1':
          res |= 1;
          break;
        default:
          throw InvalidOperationException();
      }
    }
    return res;
  }

  void _collapse() {
    for (var qubit in _qubits.where((q) => q.state != null)) {
      final qid = qubit.id;
      final qstate = qubit.state!;
      // check states
      for (var i = 0; i < _states.length; i++) {
        final state = _states[i];
        if (state[qid] != qstate) {
          // collapse
          if (!_amplitudes.isZero(i)) {
            _amplitudes.set(i, Complex.zero);
          }
        }
      }
    }
    var sum = 0.0;
    for (var i = 0; i < _amplitudes.length; i++) {
      if (!_amplitudes.isZero(i)) {
        sum += _amplitudes.modulus2(i);
      }
    }
    if (sum != 1) {
      // normalize probabilities; multiple iterations (max 5) to try and obtain a sum of 1
      var prevsum = 0.0;
      var maxIterations = 5;
      while (sum != prevsum && maxIterations > 0) {
        final norm = math.sqrt(sum);
        maxIterations--;
        prevsum = sum;
        sum = 0;
        _amplitudes.unscale(norm);
        for (var i = 0; i < _amplitudes.length; i++) {
          if (!_amplitudes.isZero(i)) {
            sum += _amplitudes.modulus2(i);
          }
        }
      }
    }
  }
}
