import 'qmemory_space.dart';
import 'qstate.dart';

/// Represents a quantum register (ordered set of qubits)
class QRegister {
  /// Creates a register with name [name] using qubits [addresses] from [qmem] space
  QRegister._(this.name, QMemorySpace qmem, List<QbitAddress> addresses)
    : _qmem = qmem,
      qbits = addresses.toList();

  final QMemorySpace _qmem;

  /// The [name] of this quantum register
  final String name;

  /// The list of qubits making up this quantum register, identified by their address in the quantum memory space
  final List<QbitAddress> qbits;

  /// The size of this quantum register
  int get size => qbits.length;

  /// Gets the address of this quantum register's [i]th qubit in the memory space
  QbitAddress operator [](int i) => qbits[i];

  /// Gets the index of this qubit in this quantum register
  int? indexOf(QbitAddress qbit) {
    for (var j = 0; j < qbits.length; j++) {
      if (qbits[j] == qbit) return j;
    }
    return null;
  }

  /// Stores the last reading, null if this quantum register was never read from.
  int? get lastReading => _measure;
  int? _measure;

  /// Measures the qubits of this quantum register and returns the integer
  int read({QMeasureMode? mode, bool debug = false}) =>
      (_measure = _qmem.read(qbits: qbits, mode: mode, debug: debug));

  @override
  String toString() =>
      '$name (${qbits.length == 1 ? 'qubit' : 'qubits'} ${qbits.map((q) => '#$q').join(', ')})';
}

// for internal use

extension QRegisterImpl on QRegister {
  static QRegister ctor(
    String name,
    QMemorySpace memory,
    List<QbitAddress> addresses,
  ) => QRegister._(name, memory, addresses);
}
