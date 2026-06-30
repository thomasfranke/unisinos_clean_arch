import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_arch_riverpod/application/favorites/get_favorites_usecase.dart';
import 'package:flutter_clean_arch_riverpod/application/favorites/toggle_favorite_usecase.dart';
import 'package:flutter_clean_arch_riverpod/application/preferences/get_preferences_usecase.dart';
import 'package:flutter_clean_arch_riverpod/application/preferences/save_preferences_usecase.dart';
import 'package:flutter_clean_arch_riverpod/application/preferences/update_darkmode_preferences_usecase.dart';
import 'package:flutter_clean_arch_riverpod/application/preferences/update_fontscale_usecase.dart';
import 'package:flutter_clean_arch_riverpod/application/preferences/update_locale_usecase.dart';
import 'package:flutter_clean_arch_riverpod/application/quotes/get_crypto_quotes_usecase.dart';
import 'package:flutter_clean_arch_riverpod/application/quotes/get_klines_usecase.dart';
import 'package:flutter_clean_arch_riverpod/core/constants/app_config.dart';
import 'package:flutter_clean_arch_riverpod/core/l10n/generated/app_localizations.dart';
import 'package:flutter_clean_arch_riverpod/core/routes/auto_route.dart';
import 'package:flutter_clean_arch_riverpod/core/theme/app_theme.dart';
import 'package:flutter_clean_arch_riverpod/data/data_sources/crypto_quotes_local_datasource.dart';
import 'package:flutter_clean_arch_riverpod/data/data_sources/crypto_quotes_remote_datasource.dart';
import 'package:flutter_clean_arch_riverpod/data/data_sources/favorites_datasource.dart';
import 'package:flutter_clean_arch_riverpod/data/data_sources/kline_datasource.dart';
import 'package:flutter_clean_arch_riverpod/data/data_sources/preferences_datasource.dart';
import 'package:flutter_clean_arch_riverpod/data/repositories_impl/crypto_quotes_repository_impl.dart';
import 'package:flutter_clean_arch_riverpod/data/repositories_impl/favorites_repository_impl.dart';
import 'package:flutter_clean_arch_riverpod/data/repositories_impl/kline_repository_impl.dart';
import 'package:flutter_clean_arch_riverpod/data/repositories_impl/preferences_repository_impl.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/preferences_entity.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/api_client/api_client_constants.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/api_client/dio/dio_impl.dart';
import 'package:flutter_clean_arch_riverpod/infrastructure/storage/shared_preferences/shared_preferences_impl.dart';
import 'package:flutter_clean_arch_riverpod/presentation/providers/crypto_quote/crypto_quote_notifier.dart';
import 'package:flutter_clean_arch_riverpod/presentation/providers/favorites/favorites_notifier.dart';
import 'package:flutter_clean_arch_riverpod/presentation/providers/preferences/preferences_notifier.dart';
import 'package:flutter_clean_arch_riverpod/presentation/providers/preferences/preferences_state.dart';
import 'package:nested/nested.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // -- Infrastructure --
  final SharedPreferencesImpl storage = await SharedPreferencesImpl.create();

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(
        seconds: ApiClientConstants.connectionTimeout,
      ),
      receiveTimeout: const Duration(
        seconds: ApiClientConstants.receiveTimeout,
      ),
      sendTimeout: const Duration(seconds: ApiClientConstants.sendTimeout),
      headers: const <String, dynamic>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      validateStatus: (int? status) =>
          status != null && status >= 200 && status < 300,
    ),
  );

  final ApiClientDioImpl apiClient = ApiClientDioImpl(dio: dio);

  // -- Data Sources --
  final CryptoQuotesRemoteDatasource cryptoQuotesRemoteDatasource =
      CryptoQuotesRemoteDatasource(apiClient: apiClient);
  final CryptoQuotesLocalDatasource cryptoQuotesLocalDatasource =
      CryptoQuotesLocalDatasource(storage: storage);

  final KlineDatasource klineDatasource = KlineDatasource(apiClient: apiClient);
  final FavoritesDatasource favoritesDatasource = FavoritesDatasource(
    storage: storage,
  );
  final PreferencesDatasource preferencesDatasource = PreferencesDatasource(
    storage: storage,
  );

  // -- Repositories --
  final CryptoQuotesRepositoryImpl cryptoQuotesRepository =
      CryptoQuotesRepositoryImpl(
        remoteDatasource: cryptoQuotesRemoteDatasource,
        localDatasource: cryptoQuotesLocalDatasource,
      );
  final KlineRepositoryImpl klineRepository = KlineRepositoryImpl(
    datasource: klineDatasource,
  );
  final FavoritesRepositoryImpl favoritesRepository = FavoritesRepositoryImpl(
    datasource: favoritesDatasource,
  );
  final PreferencesRepositoryImpl preferencesRepository =
      PreferencesRepositoryImpl(datasource: preferencesDatasource);

  // -- Use Cases --
  final GetPreferencesUseCase getPreferencesUseCase = GetPreferencesUseCase(
    repository: preferencesRepository,
  );
  final SavePreferencesUseCase savePreferencesUseCase = SavePreferencesUseCase(
    repository: preferencesRepository,
  );

  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<PreferencesNotifier>(
          create: (_) => PreferencesNotifier(
            getPreferencesUseCase: getPreferencesUseCase,
            updateLocaleUseCase: UpdateLocaleUseCase(
              getPreferences: getPreferencesUseCase,
              savePreferences: savePreferencesUseCase,
            ),
            updateDarkModeUseCase: UpdateDarkModeUseCase(
              getPreferences: getPreferencesUseCase,
              savePreferences: savePreferencesUseCase,
            ),
            updateFontScaleUseCase: UpdateFontScaleUseCase(
              getPreferences: getPreferencesUseCase,
              savePreferences: savePreferencesUseCase,
            ),
          ),
        ),
        ChangeNotifierProvider<CryptoQuoteNotifier>(
          create: (_) => CryptoQuoteNotifier(
            getQuotesUseCase: GetCryptoQuotesUseCase(
              repository: cryptoQuotesRepository,
            ),
          ),
        ),
        ChangeNotifierProvider<FavoritesNotifier>(
          create: (_) => FavoritesNotifier(
            getFavoritesUseCase: GetFavoritesUseCase(
              repository: favoritesRepository,
            ),
            toggleFavoriteUseCase: ToggleFavoriteUseCase(
              repository: favoritesRepository,
            ),
          ),
        ),
        Provider<GetKlinesUseCase>(
          create: (_) => GetKlinesUseCase(repository: klineRepository),
        ),
        ChangeNotifierProvider<AppRouter>(create: (_) => AppRouter()),
      ],
      child: const MyApp(),
    ),
  );
}

/// Root widget of the application.
class MyApp extends StatelessWidget {
  /// Creates a [MyApp] widget.
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) {
    final AppRouter appRouter = context.read<AppRouter>();
    final PreferencesState preferencesState = context
        .watch<PreferencesNotifier>()
        .state;

    final PreferencesEntity preferences = switch (preferencesState) {
      PreferencesStateSuccess(:final PreferencesEntity preferences) =>
        preferences,
      _ => PreferencesEntity.defaults(),
    };

    return MaterialApp.router(
      routerConfig: appRouter.config(),
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget? child) => MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(textScaler: TextScaler.linear(preferences.fontScale)),
        child: child!,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(preferences.locale),
      themeMode: preferences.darkMode ? ThemeMode.dark : ThemeMode.light,
      theme: AppTheme().light,
      darkTheme: AppTheme().dark,
    );
  }
}
