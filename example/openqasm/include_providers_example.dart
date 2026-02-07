import 'dart:io';

import 'package:qartvm/qartvm.dart';

/// File-system based implementation of [OpenQASMIncludeProvider].
///
/// This provider loads include files from the file system relative to a base directory.
/// Example usage:
/// ```dart
/// final provider = FileSystemIncludeProvider(baseDirectory: '/path/to/openqasm/files');
/// final interpreter = OpenQASMInterpreter(includeProvider: provider);
/// ```
class FileSystemIncludeProvider implements OpenQASMIncludeProvider {
  /// The base directory to search for include files.
  final String baseDirectory;

  FileSystemIncludeProvider({required this.baseDirectory});

  @override
  Future<String> loadIncludeFile(String filename) async {
    try {
      final file = File('$baseDirectory/$filename');

      if (!await file.exists()) {
        throw IncludeException('File not found', filename: filename);
      }

      return await file.readAsString();
    } on IncludeException {
      rethrow;
    } catch (e) {
      throw IncludeException('Error reading file: $e', filename: filename);
    }
  }
}

/// In-memory based implementation of [OpenQASMIncludeProvider].
///
/// This provider loads include files from a pre-configured map of filenames to contents.
/// Useful for testing or providing include files without filesystem access.
/// Example usage:
/// ```dart
/// final provider = MemoryIncludeProvider({
///   'gates.inc': 'gate custom_gate q { h q; }',
/// });
/// final interpreter = OpenQASMInterpreter(includeProvider: provider);
/// ```
class MemoryIncludeProvider implements OpenQASMIncludeProvider {
  /// Map of filenames to their contents.
  final Map<String, String> files;

  MemoryIncludeProvider(this.files);

  @override
  Future<String> loadIncludeFile(String filename) async {
    final contents = files[filename];

    if (contents == null) {
      throw IncludeException('File not found in memory', filename: filename);
    }

    return contents;
  }
}
