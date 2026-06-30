import 'package:flutter_clean_arch_riverpod/data/data_sources/favorites_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_favorites.dart';
import '../../mocks/mock_storage.dart';

void main() {
  late MockStorageInterface mockStorage;
  late FavoritesDatasource datasource;

  setUp(() {
    mockStorage = MockStorageInterface();
    datasource = FavoritesDatasource(storage: mockStorage);
  });

  group('FavoritesDatasource.getFavorites', () {
    test('retorna lista de símbolos do storage', () {
      when(
        () => mockStorage.getList(key: any(named: 'key')),
      ).thenReturn(tFavoriteSymbols);

      final List<String> result = datasource.getFavorites();

      expect(result, equals(tFavoriteSymbols));
    });

    test('retorna lista vazia quando não há favoritos', () {
      when(
        () => mockStorage.getList(key: any(named: 'key')),
      ).thenReturn(const <String>[]);

      final List<String> result = datasource.getFavorites();

      expect(result, isEmpty);
    });
  });

  group('FavoritesDatasource.addFavorite', () {
    test('delega adição ao storage e retorna lista atualizada', () async {
      when(
        () => mockStorage.addToList(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async => tFavoriteSymbols);

      final List<String> result = await datasource.addFavorite('BTCUSDT');

      expect(result, equals(tFavoriteSymbols));
      verify(
        () => mockStorage.addToList(
          key: any(named: 'key'),
          value: 'BTCUSDT',
        ),
      ).called(1);
    });
  });

  group('FavoritesDatasource.removeFavorite', () {
    test('delega remoção ao storage e retorna lista atualizada', () async {
      when(
        () => mockStorage.removeFromList(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async => const <String>['ETHUSDT']);

      final List<String> result = await datasource.removeFavorite('BTCUSDT');

      expect(result, equals(const <String>['ETHUSDT']));
      verify(
        () => mockStorage.removeFromList(
          key: any(named: 'key'),
          value: 'BTCUSDT',
        ),
      ).called(1);
    });
  });
}
