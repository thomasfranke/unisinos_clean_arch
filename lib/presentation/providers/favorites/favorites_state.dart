import 'package:flutter_clean_arch_riverpod/domain/entities/favorite_entity.dart';

/// Base class for representing the state of favorite cryptocurrencies.
sealed class FavoritesState {
  /// Creates an instance of [FavoritesState].
  const FavoritesState();
}

/// State representing the initial state of favorite cryptocurrencies.
class FavoritesStateInitial extends FavoritesState {
  /// Creates an instance of [FavoritesStateInitial].
  const FavoritesStateInitial();
}

/// State representing the loading state of favorite cryptocurrencies.
class FavoritesStateLoading extends FavoritesState {
  /// Creates an instance of [FavoritesStateLoading].
  const FavoritesStateLoading();
}

/// State representing the successful retrieval of favorite cryptocurrencies.
class FavoritesStateSuccess extends FavoritesState {
  /// Creates an instance of [FavoritesStateSuccess].
  const FavoritesStateSuccess(this.favorites);

  /// List of retrieved favorite cryptocurrencies.
  final List<FavoriteEntity> favorites;
}

/// State representing the failure to retrieve favorite cryptocurrencies.
class FavoritesStateFailure extends FavoritesState {
  /// Creates an instance of [FavoritesStateFailure].
  const FavoritesStateFailure(this.message);

  /// Error message describing the failure to retrieve favorite
  /// cryptocurrencies.
  final String message;
}
