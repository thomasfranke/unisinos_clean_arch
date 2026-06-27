import 'package:flutter_clean_arch_riverpod/presentation/providers/preferences/preferences_notifier.dart';
import 'package:flutter_clean_arch_riverpod/presentation/providers/preferences/preferences_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_preferences.dart';

void main() {
  late MockGetPreferencesUseCase mockGetPreferences;
  late MockUpdateLocaleUseCase mockUpdateLocale;
  late MockUpdateDarkModeUseCase mockUpdateDarkMode;
  late MockUpdateFontScaleUseCase mockUpdateFontScale;

  setUpAll(() {
    registerFallbackValue(tPreferences);
  });

  setUp(() {
    mockGetPreferences = MockGetPreferencesUseCase();
    mockUpdateLocale = MockUpdateLocaleUseCase();
    mockUpdateDarkMode = MockUpdateDarkModeUseCase();
    mockUpdateFontScale = MockUpdateFontScaleUseCase();
  });

  PreferencesNotifier buildNotifier() => PreferencesNotifier(
    getPreferencesUseCase: mockGetPreferences,
    updateLocaleUseCase: mockUpdateLocale,
    updateDarkModeUseCase: mockUpdateDarkMode,
    updateFontScaleUseCase: mockUpdateFontScale,
  );

  void stubGetPreferencesSuccess() {
    when(
      () => mockGetPreferences.call(),
    ).thenAnswer((_) async => tPreferences);
  }

  group('PreferencesState', () {
    test('PreferencesStateInitial pode ser instanciada', () {
      expect(
        const PreferencesStateInitial(),
        isA<PreferencesStateInitial>(),
      );
    });
  });

  group('PreferencesNotifier.loadPreferences', () {
    test('inicia em loading e transiciona para success', () async {
      stubGetPreferencesSuccess();

      final PreferencesNotifier notifier = buildNotifier();

      expect(notifier.state, isA<PreferencesStateLoading>());

      await Future<void>.delayed(Duration.zero);

      expect(notifier.state, isA<PreferencesStateSuccess>());
      final PreferencesStateSuccess success =
          notifier.state as PreferencesStateSuccess;
      expect(success.preferences, equals(tPreferences));
    });

    test('transiciona para failure quando use case lança exceção', () async {
      when(
        () => mockGetPreferences.call(),
      ).thenThrow(Exception('erro de armazenamento'));

      final PreferencesNotifier notifier = buildNotifier();

      await Future<void>.delayed(Duration.zero);

      expect(notifier.state, isA<PreferencesStateFailure>());
    });
  });

  group('PreferencesNotifier.updateLocale', () {
    test('atualiza locale e recarrega preferências', () async {
      stubGetPreferencesSuccess();
      when(
        () => mockUpdateLocale.call(any()),
      ).thenAnswer((_) async {});

      final PreferencesNotifier notifier = buildNotifier();
      await Future<void>.delayed(Duration.zero);

      await notifier.updateLocale('en');

      verify(() => mockUpdateLocale.call('en')).called(1);
      expect(notifier.state, isA<PreferencesStateSuccess>());
    });

    test('transiciona para failure quando update lança exceção', () async {
      stubGetPreferencesSuccess();
      when(
        () => mockUpdateLocale.call(any()),
      ).thenThrow(Exception('erro'));

      final PreferencesNotifier notifier = buildNotifier();
      await Future<void>.delayed(Duration.zero);

      await notifier.updateLocale('en');

      expect(notifier.state, isA<PreferencesStateFailure>());
    });
  });

  group('PreferencesNotifier.updateDarkMode', () {
    test('ativa dark mode e recarrega preferências', () async {
      stubGetPreferencesSuccess();
      when(
        () => mockUpdateDarkMode.call(any()),
      ).thenAnswer((_) async {});

      final PreferencesNotifier notifier = buildNotifier();
      await Future<void>.delayed(Duration.zero);

      await notifier.updateDarkMode(true);

      verify(() => mockUpdateDarkMode.call(true)).called(1);
      expect(notifier.state, isA<PreferencesStateSuccess>());
    });

    test('transiciona para failure quando update lança exceção', () async {
      stubGetPreferencesSuccess();
      when(
        () => mockUpdateDarkMode.call(any()),
      ).thenThrow(Exception('erro'));

      final PreferencesNotifier notifier = buildNotifier();
      await Future<void>.delayed(Duration.zero);

      await notifier.updateDarkMode(true);

      expect(notifier.state, isA<PreferencesStateFailure>());
    });
  });

  group('PreferencesNotifier.updateFontScale', () {
    test('atualiza escala de fonte e recarrega preferências', () async {
      stubGetPreferencesSuccess();
      when(
        () => mockUpdateFontScale.call(any()),
      ).thenAnswer((_) async {});

      final PreferencesNotifier notifier = buildNotifier();
      await Future<void>.delayed(Duration.zero);

      await notifier.updateFontScale(1.5);

      verify(() => mockUpdateFontScale.call(1.5)).called(1);
      expect(notifier.state, isA<PreferencesStateSuccess>());
    });

    test('transiciona para failure quando update lança exceção', () async {
      stubGetPreferencesSuccess();
      when(
        () => mockUpdateFontScale.call(any()),
      ).thenThrow(Exception('erro'));

      final PreferencesNotifier notifier = buildNotifier();
      await Future<void>.delayed(Duration.zero);

      await notifier.updateFontScale(1.5);

      expect(notifier.state, isA<PreferencesStateFailure>());
    });
  });
}
