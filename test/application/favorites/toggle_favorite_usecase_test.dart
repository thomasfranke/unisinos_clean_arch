import 'package:flutter_clean_arch_riverpod/application/favorites/toggle_favorite_usecase.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/favorite_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_favorites.dart';

void main() {
  late MockFavoritesRepository mockRepository;
  late ToggleFavoriteUseCase useCase;

  setUp(() {
    mockRepository = MockFavoritesRepository();
    useCase = ToggleFavoriteUseCase(repository: mockRepository);
  });

  group('ToggleFavoriteUseCase', () {
    test('remove favorito quando símbolo já está na lista', () async {
      when(
        () => mockRepository.getFavorites(),
      ).thenAnswer((_) async => tFavoriteEntities);
      when(
        () => mockRepository.removeFavorite('BTCUSDT'),
      ).thenAnswer(
        (_) async => const <FavoriteEntity>[FavoriteEntity(symbol: 'ETHUSDT')],
      );

      final List<FavoriteEntity> result = await useCase.call('BTCUSDT');

      expect(result, hasLength(1));
      expect(result.first.symbol, equals('ETHUSDT'));
      verify(() => mockRepository.removeFavorite('BTCUSDT')).called(1);
      verifyNever(() => mockRepository.addFavorite(any()));
    });

    test('adiciona favorito quando símbolo não está na lista', () async {
      when(
        () => mockRepository.getFavorites(),
      ).thenAnswer(
        (_) async =>
            const <FavoriteEntity>[FavoriteEntity(symbol: 'ETHUSDT')],
      );
      when(
        () => mockRepository.addFavorite('BTCUSDT'),
      ).thenAnswer((_) async => tFavoriteEntities);

      final List<FavoriteEntity> result = await useCase.call('BTCUSDT');

      expect(result, hasLength(2));
      verify(() => mockRepository.addFavorite('BTCUSDT')).called(1);
      verifyNever(() => mockRepository.removeFavorite(any()));
    });

    test('propaga exceção quando repositório lança erro ao buscar favoritos',
        () async {
      when(
        () => mockRepository.getFavorites(),
      ).thenThrow(Exception('erro de armazenamento'));

      expect(() => useCase.call('BTCUSDT'), throwsException);
    });
  });
}
