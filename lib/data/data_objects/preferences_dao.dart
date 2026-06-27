/// Data Access Object (DAO) for user preferences, responsible for retrieving
/// and storing user settings such as locale, dark mode, and font scale
/// using SharedPreferences.
class PreferencesDAO {
  /// Creates a [PreferencesDAO] with the given parameters.
  const PreferencesDAO({this.locale, this.darkMode, this.fontScale});

  /// Factory constructor to create a [PreferencesDAO] from a JSON map.
  final String? locale;

  /// Indicates whether dark mode is enabled.
  final bool? darkMode;

  /// The font scale factor for the application.
  final double? fontScale;
}
