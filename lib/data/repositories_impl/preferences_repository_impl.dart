import 'package:flutter_clean_arch_riverpod/data/data_objects/preferences_dao.dart';
import 'package:flutter_clean_arch_riverpod/data/data_sources/preferences_datasource.dart';
import 'package:flutter_clean_arch_riverpod/data/mappers/preferences_mapper.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/preferences_entity.dart';
import 'package:flutter_clean_arch_riverpod/domain/repositories/preferences_repository_interface.dart';

/// Repository implementation for managing user preferences
/// using a [PreferencesDatasource].
class PreferencesRepositoryImpl implements PreferencesRepository {
  /// Creates a [PreferencesRepositoryImpl] with the given [datasource].
  const PreferencesRepositoryImpl({required this.datasource});

  /// Data source used to manage user preferences in storage.
  final PreferencesDatasource datasource;

  @override
  Future<PreferencesEntity> getPreferences() async =>
      datasource.getPreferences().toEntity();

  @override
  Future<void> savePreferences(final PreferencesEntity preferences) =>
      datasource.savePreferences(
        PreferencesDAO(
          locale: preferences.locale,
          darkMode: preferences.darkMode,
          fontScale: preferences.fontScale,
        ),
      );
}
