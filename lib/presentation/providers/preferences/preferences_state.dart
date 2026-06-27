import 'package:flutter_clean_arch_riverpod/domain/entities/preferences_entity.dart';

/// Base class for representing the state of user preferences.
sealed class PreferencesState {
  const PreferencesState();
}

/// State representing the initial state of user preferences.
class PreferencesStateInitial extends PreferencesState {
  /// Creates an instance of [PreferencesStateInitial].
  const PreferencesStateInitial();
}

/// State representing the loading state of user preferences.
class PreferencesStateLoading extends PreferencesState {
  /// Creates an instance of [PreferencesStateLoading].
  const PreferencesStateLoading();
}

/// State representing the successful retrieval of user preferences.
class PreferencesStateSuccess extends PreferencesState {
  /// Creates an instance of [PreferencesStateSuccess].
  const PreferencesStateSuccess(this.preferences);

  /// Retrieved user preferences.
  final PreferencesEntity preferences;
}

/// State representing the failure to retrieve user preferences.
class PreferencesStateFailure extends PreferencesState {
  /// Creates an instance of [PreferencesStateFailure].
  const PreferencesStateFailure(this.message);

  /// Error message describing the failure to retrieve user preferences.
  final String message;
}
