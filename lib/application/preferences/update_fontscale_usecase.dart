import 'package:flutter_clean_arch_riverpod/application/preferences/get_preferences_usecase.dart';
import 'package:flutter_clean_arch_riverpod/application/preferences/save_preferences_usecase.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/preferences_entity.dart';

/// Use case for updating the user's dark mode preference.
class UpdateDarkModeUseCase {
  /// Creates an instance of [UpdateDarkModeUseCase] with the
  /// provided [getPreferences] and [savePreferences] use cases.
  const UpdateDarkModeUseCase({
    required this.getPreferences,
    required this.savePreferences,
  });

  /// The use case for fetching the user preferences.
  final GetPreferencesUseCase getPreferences;

  /// The use case for saving the user preferences.
  final SavePreferencesUseCase savePreferences;

  /// Updates the user's dark mode preference to the given [darkMode] value.
  Future<void> call(final bool darkMode) async {
    final PreferencesEntity current = await getPreferences();
    await savePreferences(current.copyWith(darkMode: darkMode));
  }
}
