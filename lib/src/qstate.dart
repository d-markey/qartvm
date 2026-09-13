import 'dart:math' as math;

import 'package:meta/meta.dart';

import 'qmemory_space.dart';

extension type const QbitAddress(int index) implements Object {}

abstract class Hardware {
  static const $0 = QbitAddress(0);
  static const $1 = QbitAddress(1);
  static const $2 = QbitAddress(2);
  static const $3 = QbitAddress(3);
  static const $4 = QbitAddress(4);
  static const $5 = QbitAddress(5);
  static const $6 = QbitAddress(6);
  static const $7 = QbitAddress(7);
}

extension QbitAddressExtension on QbitAddress {
  int bigEndianMask(int size) => 1 << (size - 1 - index);
}

extension QbitAddressIterableExtension on Iterable<QbitAddress> {
  int bigEndianMask(int size) {
    var mask = 0;
    for (final qbit in this) {
      mask |= qbit.bigEndianMask(size);
    }
    return mask;
  }
}

/// Class representing the Quantum state of a qubit
class QState {
  static final _rnd = math.Random.secure();

  /// Builds a Quantum state for qubit [id] in [_qmem]
  QState._(this._qmem, this.id)
    : _mask = Iterable.generate(
        _qmem.size,
        (i) => (i == id) ? '0' : '.',
      ).join();

  /// The qubit's address [id]
  final QbitAddress id;

  final String _mask;
  final QMemorySpace _qmem;

  /// Returns the probability for the qubit to be |0> according to the current state of the [_qmem]
  double get zero => _qmem.getProbability(_mask);

  /// Returns the qubit state: `'0'` or `'1'` if the qubit has already been measured,
  /// `null` otherwise.
  String? get state => _state;
  String? _state;

  // Measures the qubit (unless a measurement was already made)
  void _read() {
    _state ??= (_rnd.nextDouble() <= zero) ? '0' : '1';
  }

  // Resets the qubit state after a Quantum gate has been applied to the register.
  void _reset() => _state = null;

  // Snapshot and restore the current measurement state for branch/fork operations.
  String? snapshotState() => _state;
  void restoreState(String? value) => _state = value;
}

// for internal use
@internal
extension QStateImpl on QState {
  static QState ctor(QMemorySpace qmem, QbitAddress id) => QState._(qmem, id);

  void reset() => _reset();
  void read() => _read();
}
