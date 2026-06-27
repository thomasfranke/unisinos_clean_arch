import 'package:flutter_clean_arch_riverpod/data/data_objects/preferences_dao.dart';
import 'package:flutter_clean_arch_riverpod/data/repositories_impl/preferences_repository_impl.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/preferences_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_preferences.dart';

void main() {
  late MockPreferencesDatasource mockDatasource;
  late PreferencesRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(tPreferencesDAO);
  });

  setUp(() {
    mockDatasource = MockPreferencesDatasource();
    repository = PreferencesRepositoryImpl(datasource: mockDatasource);
  });

  group('PreferencesRepositoryImpl.getPreferences', () {
    test('converte DAO em entidade', () async {
      when(
        () => mockDatasource.getPreferences(),
      ).thenReturn(tPreferencesDAO);

      final PreferencesEntity result = await repository.getPreferences();

      expect(result.locale, equals('pt'));
      expect(result.darkMode, isFalse);
      expect(result.fontScale, equals(1));
    });
  });

  group('PreferencesRepositoryImpl.savePreferences', () {
    test('constrói DAO a partir da entidade e delega ao datasource', () async {
      when(
        () => mockDatasource.savePreferences(any()),
      ).thenAnswer((_) async {});

      await repository.savePreferences(tPreferences);

      final PreferencesDAO saved =
          verify(() => mockDatasource.savePreferences(captureAny()))
              .captured
              .single as PreferencesDAO;
      expect(saved.locale, equals('pt'));
      expect(saved.darkMode, isFalse);
      expect(saved.fontScale, equals(1));
    });
  });
}
