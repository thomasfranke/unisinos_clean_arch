import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_clean_arch_riverpod/application/favorites/get_favorites_usecase.dart';
import 'package:flutter_clean_arch_riverpod/application/favorites/toggle_favorite_usecase.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/favorite_entity.dart';
import 'package:flutter_clean_arch_riverpod/presentation/providers/favorites/favorites_state.dart';

/// Notifier for managing the state of favorite cryptocurrencies.
class FavoritesNotifier extends ChangeNotifier {
  /// Creates an instance of [FavoritesNotifier] with the required use cases and
  /// initiates the loading of favorite cryptocurrencies.
  FavoritesNotifier({
    required this.getFavoritesUseCase,
    required this.toggleFavoriteUseCase,
  }) {
    unawaited(loadFavorites());
  }

  /// Use case for fetching the list of favorite cryptocurrencies.
  final GetFavoritesUseCase getFavoritesUseCase;

  /// Use case for toggling the favorite status of a cryptocurrency.
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  FavoritesState _state = const FavoritesStateLoading();

  /// Current state of favorite cryptocurrencies.
  FavoritesState get state => _state;

  /// Loads the list of favorite cryptocurrencies and updates the state
  /// accordingly.
  Future<void> loadFavorites() async {
    _state = const FavoritesStateLoading();
    notifyListeners();
    try {
      final List<FavoriteEntity> favorites = await getFavoritesUseCase.call();
      _state = FavoritesStateSuccess(favorites);
    } on Object catch (e) {
      _state = FavoritesStateFailure(e.toString());
    } finally {
      notifyListeners();
    }
  }

  /// Toggles the favorite status of a cryptocurrency identified by [symbol] and
  /// updates the state accordingly.
  Future<void> toggleFavorite(final String symbol) async {
    try {
      final List<FavoriteEntity> favorites = await toggleFavoriteUseCase.call(
        symbol,
      );
      _state = FavoritesStateSuccess(favorites);
    } on Object catch (e) {
      _state = FavoritesStateFailure(e.toString());
    } finally {
      notifyListeners();
    }
  }

  /// Checks if a cryptocurrency identified by [symbol] is in the list of
  /// favorite cryptocurrencies based on the current state.
  bool isFavorite(final String symbol) => switch (_state) {
    FavoritesStateSuccess(:final List<FavoriteEntity> favorites) =>
      favorites.any((FavoriteEntity f) => f.symbol == symbol),
    _ => false,
  };
}
