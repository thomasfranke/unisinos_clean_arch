import 'package:flutter_clean_arch_riverpod/domain/entities/preferences_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PreferencesEntity.defaults', () {
    test('retorna valores padrão corretos', () {
      final PreferencesEntity defaults = PreferencesEntity.defaults();

      expect(defaults.locale, equals('pt'));
      expect(defaults.darkMode, isFalse);
      expect(defaults.fontScale, equals(1));
    });
  });

  group('PreferencesEntity.copyWith', () {
    const PreferencesEntity original = PreferencesEntity(
      locale: 'pt',
      darkMode: false,
      fontScale: 1,
    );

    test('atualiza apenas o locale', () {
      final PreferencesEntity result = original.copyWith(locale: 'en');

      expect(result.locale, equals('en'));
      expect(result.darkMode, equals(original.darkMode));
      expect(result.fontScale, equals(original.fontScale));
    });

    test('atualiza apenas o darkMode', () {
      final PreferencesEntity result = original.copyWith(darkMode: true);

      expect(result.locale, equals(original.locale));
      expect(result.darkMode, isTrue);
      expect(result.fontScale, equals(original.fontScale));
    });

    test('atualiza apenas o fontScale', () {
      final PreferencesEntity result = original.copyWith(fontScale: 1.5);

      expect(result.locale, equals(original.locale));
      expect(result.darkMode, equals(original.darkMode));
      expect(result.fontScale, equals(1.5));
    });

    test('retorna cópia idêntica quando nenhum campo é alterado', () {
      final PreferencesEntity result = original.copyWith();

      expect(result.locale, equals(original.locale));
      expect(result.darkMode, equals(original.darkMode));
      expect(result.fontScale, equals(original.fontScale));
    });
  });
}
