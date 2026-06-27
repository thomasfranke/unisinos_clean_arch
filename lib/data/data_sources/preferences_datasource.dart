import 'package:flutter_clean_arch_riverpod/data/data_objects/preferences_dao.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/preferences_entity.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/storage/storage_interface.dart';

/// A datasource for managing user preferences using shared preferences.
class PreferencesDatasource {
  /// Creates a [PreferencesDatasource] with the given [storage].
  const PreferencesDatasource({required this.storage});

  /// Storage interface used to persist and retrieve user preferences
  /// such as locale, dark mode, and font scale.
  final StorageInterface storage;

  /// Retrieves the user preferences from storage and returns
  /// them as a [PreferencesDAO].
  PreferencesDAO getPreferences() => PreferencesDAO(
    locale: storage.getString(key: 'pref_locale'),
    darkMode: storage.getBool(key: 'pref_dark_mode'),
    fontScale: storage.getDouble(key: 'pref_font_scale'),
  );

  /// Saves the user preferences to storage using the provided [PreferencesDAO].
  Future<void> savePreferences(final PreferencesDAO dao) async {
    final PreferencesEntity defaults = PreferencesEntity.defaults();
    await Future.wait(<Future<void>>[
      storage.setString(
        key: 'pref_locale',
        value: dao.locale ?? defaults.locale,
      ),
      storage.setBool(
        key: 'pref_dark_mode',
        value: dao.darkMode ?? defaults.darkMode,
      ),
      storage.setDouble(
        key: 'pref_font_scale',
        value: dao.fontScale ?? defaults.fontScale,
      ),
    ]);
  }
}
