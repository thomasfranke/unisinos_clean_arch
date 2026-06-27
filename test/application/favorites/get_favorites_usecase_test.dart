import 'package:flutter_clean_arch_riverpod/application/favorites/get_favorites_usecase.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/favorite_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_favorites.dart';

void main() {
  late MockFavoritesRepository mockRepository;
  late GetFavoritesUseCase useCase;

  setUp(() {
    mockRepository = MockFavoritesRepository();
    useCase = GetFavoritesUseCase(repository: mockRepository);
  });

  group('GetFavoritesUseCase', () {
    test('retorna lista de favoritos do repositório', () async {
      when(
        () => mockRepository.getFavorites(),
      ).thenAnswer((_) async => tFavoriteEntities);

      final List<FavoriteEntity> result = await useCase.call();

      expect(result, equals(tFavoriteEntities));
      verify(() => mockRepository.getFavorites()).called(1);
    });

    test('retorna lista vazia quando não há favoritos', () async {
      when(
        () => mockRepository.getFavorites(),
      ).thenAnswer((_) async => <FavoriteEntity>[]);

      final List<FavoriteEntity> result = await useCase.call();

      expect(result, isEmpty);
    });

    test('propaga exceção quando repositório lança erro', () async {
      when(
        () => mockRepository.getFavorites(),
      ).thenThrow(Exception('erro de armazenamento'));

      expect(() => useCase.call(), throwsException);
    });
  });
}
