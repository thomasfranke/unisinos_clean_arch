import 'package:flutter_clean_arch_riverpod/domain/entities/preferences_entity.dart';

/// Repository interface for managing user preferences.
abstract interface class PreferencesRepository {
  /// Fetches the user preferences.
  Future<PreferencesEntity> getPreferences();

  /// Saves the user preferences.
  Future<void> savePreferences(final PreferencesEntity preferences);
}
