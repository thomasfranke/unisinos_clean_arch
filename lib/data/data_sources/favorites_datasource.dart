import 'package:flutter_clean_arch_riverpod/infrastructure/storage/storage_interface.dart';

const String _favoritesKey = 'favorites';

/// Datasource for managing favorite cryptocurrencies using [StorageInterface].
class FavoritesDatasource {
  /// Creates a [FavoritesDatasource] with the given [storage].
  const FavoritesDatasource({required this.storage});

  /// Storage interface used to persist and retrieve favorite cryptocurrencies.
  final StorageInterface storage;

  /// Retrieves the list of favorite cryptocurrency symbols from storage.
  List<String> getFavorites() => storage.getList(key: _favoritesKey);

  /// Adds a cryptocurrency symbol to the list of favorites in storage
  /// and returns the updated list of favorites.
  Future<List<String>> addFavorite(final String symbol) =>
      storage.addToList(key: _favoritesKey, value: symbol);

  /// Removes a cryptocurrency symbol from the list of favorites in storage
  /// and returns the updated list of favorites.
  Future<List<String>> removeFavorite(final String symbol) =>
      storage.removeFromList(key: _favoritesKey, value: symbol);
}
