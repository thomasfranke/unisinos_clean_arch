import 'package:flutter_clean_arch_riverpod/application/preferences/get_preferences_usecase.dart';
import 'package:flutter_clean_arch_riverpod/application/preferences/save_preferences_usecase.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/preferences_entity.dart';

/// Use case for updating the user's locale preference.
class UpdateLocaleUseCase {
  /// Creates an instance of [UpdateLocaleUseCase] with the
  /// provided [getPreferences] and [savePreferences] use cases.
  const UpdateLocaleUseCase({
    required this.getPreferences,
    required this.savePreferences,
  });

  /// The use case for fetching the user preferences.
  final GetPreferencesUseCase getPreferences;

  /// The use case for saving the user preferences.
  final SavePreferencesUseCase savePreferences;

  /// Updates the user's locale preference to the given [locale].
  Future<void> call(final String locale) async {
    final PreferencesEntity current = await getPreferences();
    await savePreferences(current.copyWith(locale: locale));
  }
}
