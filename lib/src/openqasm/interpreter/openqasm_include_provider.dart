/// Provider interface for loading OpenQASM include files.
///
/// Implementations of this interface are responsible for resolving and loading
/// the contents of files referenced by `include` statements in OpenQASM programs.
/// This allows callers to customize how include files are located and loaded
/// (e.g., from the filesystem, from memory, from a URL, etc.).
abstract interface class OpenQASMIncludeProvider {
  /// Loads the contents of the specified include file.
  ///
  /// [filename] is the filename specified in the `include` statement.
  /// It typically includes the file extension but not a full path.
  ///
  /// Returns the full source code of the included file as a String.
  ///
  /// Throws [OpenQASMIncludeException] if the file cannot be found or loaded.
  Future<String> loadIncludeFile(String filename);
}
