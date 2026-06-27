import 'package:flutter_clean_arch_riverpod/application/preferences/get_preferences_usecase.dart';
import 'package:flutter_clean_arch_riverpod/application/preferences/save_preferences_usecase.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/preferences_entity.dart';

/// Use case for updating the user's dark mode preference.
class UpdateFontScaleUseCase {
  /// Creates an instance of [UpdateFontScaleUseCase] with the
  /// provided [getPreferences] and [savePreferences] use cases.
  const UpdateFontScaleUseCase({
    required this.getPreferences,
    required this.savePreferences,
  });

  /// The use case for fetching the user preferences.
  final GetPreferencesUseCase getPreferences;

  /// The use case for saving the user preferences.
  final SavePreferencesUseCase savePreferences;

  /// Updates the user's dark mode preference to the given darkMode value.
  Future<void> call(final double fontScale) async {
    final PreferencesEntity current = await getPreferences();
    await savePreferences(current.copyWith(fontScale: fontScale));
  }
}
