import 'package:flutter_clean_arch_riverpod/application/preferences/save_preferences_usecase.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/preferences_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_preferences.dart';

void main() {
  late MockPreferencesRepository mockRepository;
  late SavePreferencesUseCase useCase;

  setUpAll(() {
    registerFallbackValue(PreferencesEntity.defaults());
  });

  setUp(() {
    mockRepository = MockPreferencesRepository();
    useCase = SavePreferencesUseCase(repository: mockRepository);
  });

  group('SavePreferencesUseCase', () {
    test('delega salvamento ao repositório', () async {
      when(
        () => mockRepository.savePreferences(any()),
      ).thenAnswer((_) async {});

      await useCase.call(tPreferences);

      verify(() => mockRepository.savePreferences(tPreferences)).called(1);
    });

    test('propaga exceção quando repositório lança erro', () async {
      when(
        () => mockRepository.savePreferences(any()),
      ).thenThrow(Exception('erro de armazenamento'));

      expect(() => useCase.call(tPreferences), throwsException);
    });
  });
}
