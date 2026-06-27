import 'package:flutter_clean_arch_riverpod/domain/entities/favorite_entity.dart';
import 'package:flutter_clean_arch_riverpod/domain/repositories/favorites_repository_interface.dart';

/// Use case for toggling a favorite item.
class ToggleFavoriteUseCase {
  /// Creates an instance of [ToggleFavoriteUseCase] with the
  /// provided [repository].
  const ToggleFavoriteUseCase({required this.repository});

  /// The repository used to manage favorite items.
  final FavoritesRepository repository;

  /// Toggles the favorite status of an item with the given [symbol].
  Future<List<FavoriteEntity>> call(final String symbol) async {
    final List<FavoriteEntity> favorites = await repository.getFavorites();
    final bool isFavorite = favorites.any(
      (FavoriteEntity f) => f.symbol == symbol,
    );
    return isFavorite
        ? repository.removeFavorite(symbol)
        : repository.addFavorite(symbol);
  }
}
