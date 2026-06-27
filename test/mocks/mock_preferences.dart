import 'package:flutter_clean_arch_riverpod/application/preferences/get_preferences_usecase.dart';
import 'package:flutter_clean_arch_riverpod/application/preferences/save_preferences_usecase.dart';
import 'package:flutter_clean_arch_riverpod/application/preferences/update_darkmode_preferences_usecase.dart';
import 'package:flutter_clean_arch_riverpod/application/preferences/update_fontscale_usecase.dart';
import 'package:flutter_clean_arch_riverpod/application/preferences/update_locale_usecase.dart';
import 'package:flutter_clean_arch_riverpod/data/data_objects/preferences_dao.dart';
import 'package:flutter_clean_arch_riverpod/data/data_sources/preferences_datasource.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/preferences_entity.dart';
import 'package:flutter_clean_arch_riverpod/domain/repositories/preferences_repository_interface.dart';
import 'package:mocktail/mocktail.dart';

class MockPreferencesRepository extends Mock implements PreferencesRepository {}

class MockPreferencesDatasource extends Mock implements PreferencesDatasource {}

class MockGetPreferencesUseCase extends Mock implements GetPreferencesUseCase {}

class MockSavePreferencesUseCase extends Mock
    implements SavePreferencesUseCase {}

class MockUpdateLocaleUseCase extends Mock implements UpdateLocaleUseCase {}

class MockUpdateDarkModeUseCase extends Mock
    implements UpdateDarkModeUseCase {}

class MockUpdateFontScaleUseCase extends Mock
    implements UpdateFontScaleUseCase {}

const PreferencesEntity tPreferences = PreferencesEntity(
  locale: 'pt',
  darkMode: false,
  fontScale: 1,
);

const PreferencesDAO tPreferencesDAO = PreferencesDAO(
  locale: 'pt',
  darkMode: false,
  fontScale: 1,
);
