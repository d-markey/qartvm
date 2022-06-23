import 'dart:math' as math;

import 'exceptions.dart';
import 'math/complex.dart';
import 'math/_complex_array.dart';
import 'math/complex_matrix.dart';
import 'math/complex_vector.dart';
import 'qbit.dart';
import 'qregister.dart';
import 'qstate.dart';

/// Class representing some Quantum memory
class QMemorySpace {
  //
  // memory attributes
  //

  /// Builds a Quantum memory space with the input [qubits] as initial state
  QMemorySpace(List<Qbit> qubits)
      : size = qubits.length,
        _states = List.generate(1 << qubits.length, (i) => '', growable: false),
        _amplitudes = ComplexArray.zero(1 << qubits.length) {
    _loadQubits(qubits, _states, _amplitudes);
    for (var id = 0; id < size; id++) {
      _qstates.add(QStateImpl.ctor(this, id));
    }
  }

  /// Builds a Quantum memory space and initialize qubits based on bits in the input [number]
  QMemorySpace.load(int number, {int? size})
      : this(Qbit.fromInt(number, count: size ?? 8).toList());

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
  final int size;

  final List<QState> _qstates = <QState>[];
  final List<String> _states;
  final ComplexArray _amplitudes;

  void load(int number) {
    final qubits = Qbit.fromInt(number, count: size).toList();
    _loadQubits(qubits, _states, _amplitudes);
    for (var qstate in _qstates) {
      qstate.reset();
    }
  }

  /// Sets the memory space with the specified [initializers].
  /// By default (e.g. if [initializers] is empty or not all qubits are covered by the [initializers]), qubits are set to zero (i.e. |0>).
  /// Registers in the initializer map will be loaded with the result produced by their initializer function, which may be an int, a [Qbit] or an [Iterable] of [Qbit]
  void initialize([Map? initializers]) {
    final qubits = List<Qbit>.filled(size, Qbit.zero);
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
            final rqubits = Qbit.fromInt(val, count: rs).toList();
            for (var i = 0; i < rs; i++) {
              qubits[reg[rs - 1 - i]] = rqubits[i];
            }
          } else if (val is Qbit) {
            for (var i = 0; i < rs; i++) {
              qubits[reg[i]] = val;
            }
          } else if (val is Iterable<Qbit>) {
            final qval = val.toList();
            if (qval.length != rs) {
              throw InvalidOperationException(
                  'Incompatible size for initialization value $qval and $rs-qubit register');
            }
            for (var i = 0; i < rs; i++) {
              qubits[reg[i]] = qval[i];
            }
          } else {
            throw InvalidOperationException(
                'Unsupported initialization value $val for register ${reg.name}');
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
                  'Unsupported initialization value $val for qubit $reg');
            }
            qubits[reg] = (val == 0) ? Qbit.zero : Qbit.one;
          } else if (val is Qbit) {
            qubits[reg] = val;
          } else {
            throw InvalidOperationException(
                'Unsupported initialization value $val for qubit $reg');
          }
        }
      }
    }
    _loadQubits(qubits, _states, _amplitudes);
    for (var qstate in _qstates) {
      qstate.reset();
    }
  }

  static void _loadQubits(
      List<Qbit> values, List<String> states, ComplexArray amplitudes) {
    Iterable<MapEntry<String, Complex>> _kronecker([int idx = 0]) sync* {
      final value = values[idx];
      if (idx == values.length - 1) {
        yield MapEntry('0', value.ket0);
        yield MapEntry('1', value.ket1);
      } else {
        // the loop order is important to have states & amplitudes in the same order as the tensor
        final k = _kronecker(idx + 1).toList();
        for (var e in k) {
          yield MapEntry('0${e.key}', value.ket0 * e.value);
        }
        for (var e in k) {
          yield MapEntry('1${e.key}', value.ket1 * e.value);
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
  // registers
  //

  final Map<String, QRegister> _qregisters = <String, QRegister>{};

  /// Creates a quantum register in this memory space
  QRegister createRegister(String name,
      {List<int>? addresses, int? from, int? to, int? at}) {
    if (_qregisters.containsKey(name)) {
      throw InvalidOperationException('Regsiter $name already exists');
    }
    if (addresses == null) {
      addresses = [];
      if (at != null) {
        if (from != null || to != null) {
          throw InvalidOperationException(
              'Parareters "to" and "from" must be null if "at" is provided');
        }
        addresses.add(at);
      } else if (from != null && to != null) {
        final d = (to >= from) ? 1 : -1;
        for (var i = from; i != to + d; i += d) {
          addresses.add(i);
        }
      } else {
        throw InvalidOperationException(
            'Both parareters "to" and "from" must be provided if "at" and "addresses" are null');
      }
    } else {
      if (at != null || from != null || to != null) {
        throw InvalidOperationException(
            'Parareters "at", "to" and "from" must be null if "addresses" is provided');
      }
    }
    if (addresses.any((i) => i < 0 || i >= size)) {
      throw InvalidOperationException(
          'Invalid qubit addresses: ${addresses.where((i) => i < 0 || i >= size)}, memory space size = $size');
    }
    return (_qregisters[name] = QRegisterImpl.ctor(name, this, addresses));
  }

  QRegister? findRegister(int i) {
    for (var qreg in _qregisters.values) {
      for (var j = 0; j < qreg.size; j++) {
        if (qreg[j] == i) return qreg;
      }
    }
    return null;
  }

  String getLogicalName(int i) {
    final qreg = findRegister(i);
    return (qreg == null) ? '#$i:' : '#$i: ${qreg.name}[${qreg.indexOf(i)}]';
  }

  String formatState(String state) {
    var s = state[0];
    QRegister? last = findRegister(0);
    for (var i = 1; i < size; i++) {
      final q = findRegister(i);
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
  /// [mask] may contain spaces to group qubits together (such as '0000 0000', '0000 ....', etc)
  double getPropability(String mask) {
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
  void applyGate(ComplexMatrix gate, Set<int> qubits) {
    final work = ComplexVector.zero(_amplitudes.length);
    work.copyFrom(_amplitudes);
    work.transform(gate);
    work.copyTo(_amplitudes);
    for (var qstate in _qstates.where((s) => qubits.contains(s.id))) {
      qstate.reset();
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
        _qstates[id].read();
        // collapse states
        _collapse();
      }
    }
  }

  /// Reads a list of [qubits] (making measurements if appropriate) and returns the result as an [int].
  int read({dynamic qubits}) {
    if (qubits == null || qubits is Iterable && qubits.isEmpty) {
      qubits = List<int>.generate(size, (i) => i);
    } else if (qubits is int) {
      qubits = [qubits];
    } else if (qubits is List && qubits.every((q) => q is int)) {
      // nothing to do
    } else if (qubits is Iterable && qubits.every((q) => q is int)) {
      qubits = qubits.toList();
    } else if (qubits is QRegister) {
      qubits = qubits.qubits;
    } else {
      throw InvalidOperationException('Cannot read from ${qubits.runtimeType}');
    }
    // qubits is now a List<int>
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
