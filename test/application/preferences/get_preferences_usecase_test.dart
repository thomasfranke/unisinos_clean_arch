import 'package:flutter_clean_arch_riverpod/application/preferences/get_preferences_usecase.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/preferences_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_preferences.dart';

void main() {
  late MockPreferencesRepository mockRepository;
  late GetPreferencesUseCase useCase;

  setUp(() {
    mockRepository = MockPreferencesRepository();
    useCase = GetPreferencesUseCase(repository: mockRepository);
  });

  group('GetPreferencesUseCase', () {
    test('retorna preferências do repositório', () async {
      when(
        () => mockRepository.getPreferences(),
      ).thenAnswer((_) async => tPreferences);

      final PreferencesEntity result = await useCase.call();

      expect(result, equals(tPreferences));
      verify(() => mockRepository.getPreferences()).called(1);
    });

    test('propaga exceção quando repositório lança erro', () async {
      when(
        () => mockRepository.getPreferences(),
      ).thenThrow(Exception('erro de armazenamento'));

      expect(() => useCase.call(), throwsException);
    });
  });
}
