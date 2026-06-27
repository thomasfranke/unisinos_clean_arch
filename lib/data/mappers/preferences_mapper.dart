import 'package:flutter_clean_arch_riverpod/data/data_objects/preferences_dao.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/preferences_entity.dart';

/// Extension to map [PreferencesDAO] to domain entities.
extension PreferencesDAOMapper on PreferencesDAO {
  /// Converts this DAO to a [PreferencesEntity] domain entity.
  PreferencesEntity toEntity() {
    final PreferencesEntity defaults = PreferencesEntity.defaults();
    return PreferencesEntity(
      locale: locale ?? defaults.locale,
      darkMode: darkMode ?? defaults.darkMode,
      fontScale: fontScale ?? defaults.fontScale,
    );
  }
}
