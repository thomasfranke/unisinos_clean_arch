import 'package:flutter_clean_arch_riverpod/domain/entities/preferences_entity.dart';
import 'package:flutter_clean_arch_riverpod/domain/repositories/preferences_repository_interface.dart';

/// Use case for saving the user preferences.
class SavePreferencesUseCase {
  /// Creates an instance of [SavePreferencesUseCase] with the
  /// provided [repository].
  const SavePreferencesUseCase({required this.repository});

  /// The repository used to save the user preferences.
  final PreferencesRepository repository;

  /// Saves the user preferences.
  Future<void> call(final PreferencesEntity preferences) =>
      repository.savePreferences(preferences);
}
