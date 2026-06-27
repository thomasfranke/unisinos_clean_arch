import 'package:flutter_clean_arch_riverpod/domain/entities/favorite_entity.dart';
import 'package:flutter_clean_arch_riverpod/presentation/providers/favorites/favorites_notifier.dart';
import 'package:flutter_clean_arch_riverpod/presentation/providers/favorites/favorites_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_favorites.dart';

void main() {
  late MockGetFavoritesUseCase mockGetFavorites;
  late MockToggleFavoriteUseCase mockToggleFavorite;

  setUp(() {
    mockGetFavorites = MockGetFavoritesUseCase();
    mockToggleFavorite = MockToggleFavoriteUseCase();
  });

  FavoritesNotifier buildNotifier() => FavoritesNotifier(
    getFavoritesUseCase: mockGetFavorites,
    toggleFavoriteUseCase: mockToggleFavorite,
  );

  group('FavoritesState', () {
    test('FavoritesStateInitial pode ser instanciada', () {
      expect(const FavoritesStateInitial(), isA<FavoritesStateInitial>());
    });
  });

  group('FavoritesNotifier.loadFavorites', () {
    test('inicia em loading e transiciona para success', () async {
      when(
        () => mockGetFavorites.call(),
      ).thenAnswer((_) async => tFavoriteEntities);

      final FavoritesNotifier notifier = buildNotifier();

      expect(notifier.state, isA<FavoritesStateLoading>());

      await Future<void>.delayed(Duration.zero);

      expect(notifier.state, isA<FavoritesStateSuccess>());
      final FavoritesStateSuccess success =
          notifier.state as FavoritesStateSuccess;
      expect(success.favorites, equals(tFavoriteEntities));
    });

    test('transiciona para failure quando use case lança exceção', () async {
      when(
        () => mockGetFavorites.call(),
      ).thenThrow(Exception('erro de armazenamento'));

      final FavoritesNotifier notifier = buildNotifier();

      await Future<void>.delayed(Duration.zero);

      expect(notifier.state, isA<FavoritesStateFailure>());
    });
  });

  group('FavoritesNotifier.toggleFavorite', () {
    test('atualiza estado para success após toggle bem-sucedido', () async {
      when(
        () => mockGetFavorites.call(),
      ).thenAnswer((_) async => tFavoriteEntities);
      when(
        () => mockToggleFavorite.call('BTCUSDT'),
      ).thenAnswer(
        (_) async =>
            const <FavoriteEntity>[FavoriteEntity(symbol: 'ETHUSDT')],
      );

      final FavoritesNotifier notifier = buildNotifier();
      await Future<void>.delayed(Duration.zero);

      await notifier.toggleFavorite('BTCUSDT');

      expect(notifier.state, isA<FavoritesStateSuccess>());
      final FavoritesStateSuccess success =
          notifier.state as FavoritesStateSuccess;
      expect(success.favorites, hasLength(1));
    });

    test('atualiza estado para failure quando toggle lança exceção', () async {
      when(
        () => mockGetFavorites.call(),
      ).thenAnswer((_) async => tFavoriteEntities);
      when(
        () => mockToggleFavorite.call(any()),
      ).thenThrow(Exception('erro'));

      final FavoritesNotifier notifier = buildNotifier();
      await Future<void>.delayed(Duration.zero);

      await notifier.toggleFavorite('BTCUSDT');

      expect(notifier.state, isA<FavoritesStateFailure>());
    });
  });

  group('FavoritesNotifier.isFavorite', () {
    test('retorna true quando símbolo está na lista de favoritos', () async {
      when(
        () => mockGetFavorites.call(),
      ).thenAnswer((_) async => tFavoriteEntities);

      final FavoritesNotifier notifier = buildNotifier();
      await Future<void>.delayed(Duration.zero);

      expect(notifier.isFavorite('BTCUSDT'), isTrue);
      expect(notifier.isFavorite('ETHUSDT'), isTrue);
    });

    test('retorna false quando símbolo não está na lista', () async {
      when(
        () => mockGetFavorites.call(),
      ).thenAnswer((_) async => tFavoriteEntities);

      final FavoritesNotifier notifier = buildNotifier();
      await Future<void>.delayed(Duration.zero);

      expect(notifier.isFavorite('SOLUSDT'), isFalse);
    });

    test('retorna false quando estado não é success', () async {
      when(
        () => mockGetFavorites.call(),
      ).thenAnswer((_) async => tFavoriteEntities);

      final FavoritesNotifier notifier = buildNotifier();

      expect(notifier.state, isA<FavoritesStateLoading>());
      expect(notifier.isFavorite('BTCUSDT'), isFalse);
    });
  });
}
