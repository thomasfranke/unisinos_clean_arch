import 'package:flutter_clean_arch_riverpod/data/repositories_impl/favorites_repository_impl.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/favorite_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_favorites.dart';

void main() {
  late MockFavoritesDatasource mockDatasource;
  late FavoritesRepositoryImpl repository;

  setUp(() {
    mockDatasource = MockFavoritesDatasource();
    repository = FavoritesRepositoryImpl(datasource: mockDatasource);
  });

  group('FavoritesRepositoryImpl.getFavorites', () {
    test('converte strings em entidades', () async {
      when(
        () => mockDatasource.getFavorites(),
      ).thenReturn(tFavoriteSymbols);

      final List<FavoriteEntity> result = await repository.getFavorites();

      expect(result, hasLength(tFavoriteSymbols.length));
      expect(result.first.symbol, equals('BTCUSDT'));
      expect(result.last.symbol, equals('ETHUSDT'));
    });

    test('retorna lista vazia quando não há favoritos', () async {
      when(
        () => mockDatasource.getFavorites(),
      ).thenReturn(const <String>[]);

      final List<FavoriteEntity> result = await repository.getFavorites();

      expect(result, isEmpty);
    });
  });

  group('FavoritesRepositoryImpl.addFavorite', () {
    test('converte resultado da adição em entidades', () async {
      when(
        () => mockDatasource.addFavorite('BTCUSDT'),
      ).thenAnswer((_) async => tFavoriteSymbols);

      final List<FavoriteEntity> result =
          await repository.addFavorite('BTCUSDT');

      expect(result, hasLength(2));
      expect(result.first.symbol, equals('BTCUSDT'));
    });
  });

  group('FavoritesRepositoryImpl.removeFavorite', () {
    test('converte resultado da remoção em entidades', () async {
      when(
        () => mockDatasource.removeFavorite('BTCUSDT'),
      ).thenAnswer(
        (_) async => const <String>['ETHUSDT'],
      );

      final List<FavoriteEntity> result =
          await repository.removeFavorite('BTCUSDT');

      expect(result, hasLength(1));
      expect(result.first.symbol, equals('ETHUSDT'));
    });
  });
}
