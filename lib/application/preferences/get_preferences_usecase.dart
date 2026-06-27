import 'package:flutter_clean_arch_riverpod/domain/entities/preferences_entity.dart';
import 'package:flutter_clean_arch_riverpod/domain/repositories/preferences_repository_interface.dart';

/// Use case for fetching the user preferences.
class GetPreferencesUseCase {
  /// Creates an instance of [GetPreferencesUseCase] with the
  /// provided [repository].
  const GetPreferencesUseCase({required this.repository});

  /// The repository used to fetch the user preferences.
  final PreferencesRepository repository;

  /// Fetches the user preferences.
  Future<PreferencesEntity> call() => repository.getPreferences();
}
