import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_clean_arch_riverpod/application/preferences/get_preferences_usecase.dart';
import 'package:flutter_clean_arch_riverpod/application/preferences/update_darkmode_preferences_usecase.dart';
import 'package:flutter_clean_arch_riverpod/application/preferences/update_fontscale_usecase.dart';
import 'package:flutter_clean_arch_riverpod/application/preferences/update_locale_usecase.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/preferences_entity.dart';
import 'package:flutter_clean_arch_riverpod/presentation/providers/preferences/preferences_state.dart';

/// Notifier for managing the state of user preferences, including loading,
/// updating, and error handling for preferences such as locale, dark mode,
/// and font scale.
class PreferencesNotifier extends ChangeNotifier {
  /// Creates an instance of [PreferencesNotifier] with the required use cases
  /// and initiates the loading of user preferences.
  PreferencesNotifier({
    required this.getPreferencesUseCase,
    required this.updateLocaleUseCase,
    required this.updateDarkModeUseCase,
    required this.updateFontScaleUseCase,
  }) {
    unawaited(loadPreferences());
  }

  /// Use case for fetching user preferences.
  final GetPreferencesUseCase getPreferencesUseCase;

  /// Use case for updating the locale preference.
  final UpdateLocaleUseCase updateLocaleUseCase;

  /// Use case for updating the dark mode preference.
  final UpdateDarkModeUseCase updateDarkModeUseCase;

  /// Use case for updating the font scale preference.
  final UpdateFontScaleUseCase updateFontScaleUseCase;

  PreferencesState _state = const PreferencesStateLoading();

  /// Current state of user preferences.
  PreferencesState get state => _state;

  /// Loads user preferences and updates the state accordingly, handling
  /// loading, success, and failure scenarios.
  Future<void> loadPreferences() async {
    _state = const PreferencesStateLoading();
    notifyListeners();
    try {
      final PreferencesEntity preferences = await getPreferencesUseCase.call();
      _state = PreferencesStateSuccess(preferences);
    } on Object catch (e) {
      _state = PreferencesStateFailure(e.toString());
    } finally {
      notifyListeners();
    }
  }

  /// Updates the locale preference and reloads the user preferences.
  Future<void> updateLocale(final String locale) async {
    try {
      await updateLocaleUseCase.call(locale);
      await loadPreferences();
    } on Object catch (e) {
      _state = PreferencesStateFailure(e.toString());
      notifyListeners();
    }
  }

  /// Updates the dark mode preference and reloads the user preferences.
  Future<void> updateDarkMode(final bool darkMode) async {
    try {
      await updateDarkModeUseCase.call(darkMode);
      await loadPreferences();
    } on Object catch (e) {
      _state = PreferencesStateFailure(e.toString());
      notifyListeners();
    }
  }

  /// Updates the font scale preference and reloads the user preferences.
  Future<void> updateFontScale(final double fontScale) async {
    try {
      await updateFontScaleUseCase.call(fontScale);
      await loadPreferences();
    } on Object catch (e) {
      _state = PreferencesStateFailure(e.toString());
      notifyListeners();
    }
  }
}
