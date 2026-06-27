import 'package:flutter_clean_arch_riverpod/data/data_sources/favorites_datasource.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/favorite_entity.dart';
import 'package:flutter_clean_arch_riverpod/domain/repositories/favorites_repository_interface.dart';

/// Repository implementation for managing favorite cryptocurrencies
/// using a [FavoritesDatasource].
class FavoritesRepositoryImpl implements FavoritesRepository {
  /// Creates a [FavoritesRepositoryImpl] with the given [datasource].
  const FavoritesRepositoryImpl({required this.datasource});

  /// Data source used to manage favorite cryptocurrencies in storage.
  final FavoritesDatasource datasource;

  @override
  Future<List<FavoriteEntity>> getFavorites() async => datasource
      .getFavorites()
      .map((String s) => FavoriteEntity(symbol: s))
      .toList();

  @override
  Future<List<FavoriteEntity>> addFavorite(final String symbol) async {
    final List<String> symbols = await datasource.addFavorite(symbol);
    return symbols.map((String s) => FavoriteEntity(symbol: s)).toList();
  }

  @override
  Future<List<FavoriteEntity>> removeFavorite(final String symbol) async {
    final List<String> symbols = await datasource.removeFavorite(symbol);
    return symbols.map((String s) => FavoriteEntity(symbol: s)).toList();
  }
}
