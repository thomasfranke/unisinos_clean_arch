import 'package:flutter_clean_arch_riverpod/data/data_objects/preferences_dao.dart';
import 'package:flutter_clean_arch_riverpod/data/mappers/preferences_mapper.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/preferences_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PreferencesDAOMapper.toEntity', () {
    test('converte DAO em entidade com valores definidos', () {
      const PreferencesDAO dao = PreferencesDAO(
        locale: 'en',
        darkMode: true,
        fontScale: 1.5,
      );

      final PreferencesEntity entity = dao.toEntity();

      expect(entity.locale, equals('en'));
      expect(entity.darkMode, isTrue);
      expect(entity.fontScale, equals(1.5));
    });

    test('usa valores padrão para campos nulos', () {
      const PreferencesDAO dao = PreferencesDAO();
      final PreferencesEntity defaults = PreferencesEntity.defaults();

      final PreferencesEntity entity = dao.toEntity();

      expect(entity.locale, equals(defaults.locale));
      expect(entity.darkMode, equals(defaults.darkMode));
      expect(entity.fontScale, equals(defaults.fontScale));
    });
  });
}
