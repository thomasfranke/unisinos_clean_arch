/// Defines an abstract interface for storage operations, including methods for
/// setting and getting string, boolean, and double values.
abstract class StorageInterface {
  /// Sets a string value in storage for the specified [key].
  Future<void> setString({
    required final String key,
    required final String value,
  });

  /// Sets a boolean value in storage for the specified [key].
  Future<void> setBool({required final String key, required final bool value});

  /// Sets a double value in storage for the specified [key].
  Future<void> setDouble({
    required final String key,
    required final double value,
  });

  /// Retrieves a string value from storage for the specified [key].
  String? getString({required final String key});

  /// Retrieves a boolean value from storage for the specified [key].
  bool? getBool({required final String key});

  /// Retrieves a double value from storage for the specified [key].
  double? getDouble({required final String key});

  /// Retrieves a list of strings from storage for the specified [key].
  List<String> getList({required final String key});

  /// Adds a string value to a list in storage for the specified [key] and
  /// returns the updated list.
  Future<List<String>> addToList({
    required final String key,
    required final String value,
  });

  /// Removes a string value from a list in storage for the specified [key] and
  /// returns the updated list.
  Future<List<String>> removeFromList({
    required final String key,
    required final String value,
  });
}
