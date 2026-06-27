import 'package:flutter_clean_arch_riverpod/data/data_objects/preferences_dao.dart';
import 'package:flutter_clean_arch_riverpod/data/data_sources/preferences_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_storage.dart';

void main() {
  late MockStorageInterface mockStorage;
  late PreferencesDatasource datasource;

  setUp(() {
    mockStorage = MockStorageInterface();
    datasource = PreferencesDatasource(storage: mockStorage);
  });

  group('PreferencesDatasource.getPreferences', () {
    test('lê locale, darkMode e fontScale do storage', () {
      when(
        () => mockStorage.getString(key: any(named: 'key')),
      ).thenReturn('pt');
      when(
        () => mockStorage.getBool(key: any(named: 'key')),
      ).thenReturn(false);
      when(
        () => mockStorage.getDouble(key: any(named: 'key')),
      ).thenReturn(1);

      final PreferencesDAO result = datasource.getPreferences();

      expect(result.locale, equals('pt'));
      expect(result.darkMode, isFalse);
      expect(result.fontScale, equals(1));
    });

    test('retorna campos nulos quando storage está vazio', () {
      when(
        () => mockStorage.getString(key: any(named: 'key')),
      ).thenReturn(null);
      when(
        () => mockStorage.getBool(key: any(named: 'key')),
      ).thenReturn(null);
      when(
        () => mockStorage.getDouble(key: any(named: 'key')),
      ).thenReturn(null);

      final PreferencesDAO result = datasource.getPreferences();

      expect(result.locale, isNull);
      expect(result.darkMode, isNull);
      expect(result.fontScale, isNull);
    });
  });

  group('PreferencesDatasource.savePreferences', () {
    test('persiste locale, darkMode e fontScale no storage', () async {
      when(
        () => mockStorage.setString(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});
      when(
        () => mockStorage.setBool(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});
      when(
        () => mockStorage.setDouble(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});

      await datasource.savePreferences(
        const PreferencesDAO(locale: 'en', darkMode: true, fontScale: 1.5),
      );

      verify(
        () => mockStorage.setString(
          key: any(named: 'key'),
          value: 'en',
        ),
      ).called(1);
      verify(
        () => mockStorage.setBool(
          key: any(named: 'key'),
          value: true,
        ),
      ).called(1);
      verify(
        () => mockStorage.setDouble(
          key: any(named: 'key'),
          value: 1.5,
        ),
      ).called(1);
    });

    test('usa valores padrão para campos nulos no DAO', () async {
      when(
        () => mockStorage.setString(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});
      when(
        () => mockStorage.setBool(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});
      when(
        () => mockStorage.setDouble(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});

      await datasource.savePreferences(const PreferencesDAO());

      verify(
        () => mockStorage.setString(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).called(1);
    });
  });
}
