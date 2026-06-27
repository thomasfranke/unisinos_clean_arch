// UpdateFontScaleUseCase está definida em update_locale_usecase.dart
import 'package:flutter_clean_arch_riverpod/application/preferences/update_locale_usecase.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/preferences_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_preferences.dart';

void main() {
  late MockGetPreferencesUseCase mockGetPreferences;
  late MockSavePreferencesUseCase mockSavePreferences;
  late UpdateFontScaleUseCase useCase;

  setUpAll(() {
    registerFallbackValue(tPreferences);
  });

  setUp(() {
    mockGetPreferences = MockGetPreferencesUseCase();
    mockSavePreferences = MockSavePreferencesUseCase();
    useCase = UpdateFontScaleUseCase(
      getPreferences: mockGetPreferences,
      savePreferences: mockSavePreferences,
    );
  });

  group('UpdateFontScaleUseCase', () {
    test('atualiza escala de fonte e salva preferências', () async {
      when(
        () => mockGetPreferences.call(),
      ).thenAnswer((_) async => tPreferences);
      when(
        () => mockSavePreferences.call(any()),
      ).thenAnswer((_) async {});

      await useCase.call(1.5);

      verify(() => mockGetPreferences.call()).called(1);
      final PreferencesEntity saved =
          verify(() => mockSavePreferences.call(captureAny()))
              .captured
              .single as PreferencesEntity;
      expect(saved.locale, equals(tPreferences.locale));
      expect(saved.darkMode, equals(tPreferences.darkMode));
      expect(saved.fontScale, equals(1.5));
    });

    test('propaga exceção quando busca de preferências falha', () async {
      when(
        () => mockGetPreferences.call(),
      ).thenThrow(Exception('erro'));

      expect(() => useCase.call(1.5), throwsException);
    });
  });
}
