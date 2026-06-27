/// Domain entity representing user preferences, including locale, dark mode,
/// and font scale, used within the application to encapsulate user settings.
class PreferencesEntity {
  /// Constructs a [PreferencesEntity] with the given [locale], [darkMode],
  /// and [fontScale].
  const PreferencesEntity({
    required this.locale,
    required this.darkMode,
    required this.fontScale,
  });

  /// Factory constructor to create a [PreferencesEntity] with default values.
  factory PreferencesEntity.defaults() =>
      const PreferencesEntity(locale: 'pt', darkMode: false, fontScale: 1);

  /// The user's preferred locale (e.g., 'en', 'pt').
  final String locale;

  /// Whether dark mode is enabled.
  final bool darkMode;

  /// The user's preferred font scale (e.g., 1 for normal size).
  final double fontScale;

  /// Creates a copy of this [PreferencesEntity] with the given fields replaced
  /// by new values.
  PreferencesEntity copyWith({
    String? locale,
    bool? darkMode,
    double? fontScale,
  }) => PreferencesEntity(
    locale: locale ?? this.locale,
    darkMode: darkMode ?? this.darkMode,
    fontScale: fontScale ?? this.fontScale,
  );
}
