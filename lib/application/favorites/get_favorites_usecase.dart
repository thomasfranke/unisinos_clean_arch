import 'package:flutter_clean_arch_riverpod/domain/entities/favorite_entity.dart';
import 'package:flutter_clean_arch_riverpod/domain/repositories/favorites_repository_interface.dart';

/// Use case for fetching the list of favorite items.
class GetFavoritesUseCase {
  /// Creates an instance of [GetFavoritesUseCase] with the
  /// provided [repository].
  const GetFavoritesUseCase({required this.repository});

  /// The repository used to fetch the list of favorite items.
  final FavoritesRepository repository;

  /// Fetches the list of favorite items.
  Future<List<FavoriteEntity>> call() => repository.getFavorites();
}
