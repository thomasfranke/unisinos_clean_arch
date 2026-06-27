import 'package:flutter_clean_arch_riverpod/domain/entities/favorite_entity.dart';

/// Repository interface for managing favorite cryptocurrencies.
abstract interface class FavoritesRepository {
  /// Fetches a list of favorite cryptocurrencies.
  Future<List<FavoriteEntity>> getFavorites();

  /// Adds a cryptocurrency to the list of favorites.
  Future<List<FavoriteEntity>> addFavorite(final String symbol);

  /// Removes a cryptocurrency from the list of favorites.
  Future<List<FavoriteEntity>> removeFavorite(final String symbol);
}
