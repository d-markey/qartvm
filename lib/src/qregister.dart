import 'qmemory_space.dart';

/// Represents a quantum register (ordered set of qubits)
class QRegister {
  /// Creates a register with name [name] using qubits [addresses] from [qmem] space
  QRegister._(this.name, QMemorySpace qmem, List<int> addresses)
      : _qmem = qmem,
        qubits = addresses.toList();

  final QMemorySpace _qmem;

  /// The [name] of this quantum register
  final String name;

  /// The list of qubits making up this quantum register, identified by their address in the quantum memory space
  final List<int> qubits;

  /// The size of this quantum register
  int get size => qubits.length;

  /// Gets the address of this quantum register's [i]th qubit in the memory space
  int operator [](int i) => qubits[i];

  /// Gets the index of this qubit in this quantum register
  int? indexOf(int qubit) {
    for (var j = 0; j < qubits.length; j++) {
      if (qubits[j] == qubit) return j;
    }
    return null;
  }

  /// Stores the last reading, null if this quantum register was never read from.
  int? get lastReading => _measure;
  int? _measure;

  /// Measures the qubits of this quantum register and returns the integer
  int read() => (_measure = _qmem.read(qubits: qubits));

  @override
  String toString() =>
      '$name (${qubits.length == 1 ? 'qubit' : 'qubits'} ${qubits.map((q) => '#$q').join(', ')})';
}

// for internal use

extension QRegisterImpl on QRegister {
  static QRegister ctor(
          String name, QMemorySpace memory, List<int> addresses) =>
      QRegister._(name, memory, addresses);
}
