import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_arch_riverpod/core/l10n/generated/app_localizations.dart';
import 'package:flutter_clean_arch_riverpod/domain/entities/preferences_entity.dart';
import 'package:flutter_clean_arch_riverpod/presentation/providers/preferences/preferences_notifier.dart';
import 'package:flutter_clean_arch_riverpod/presentation/providers/preferences/preferences_state.dart';
import 'package:flutter_clean_arch_riverpod/presentation/screens/preferences/widgets/locale_tile_widget.dart';
import 'package:flutter_clean_arch_riverpod/presentation/screens/preferences/widgets/section_title_widget.dart';
import 'package:provider/provider.dart';

/// Screen for managing user preferences.
@RoutePage()
class PreferencesScreen extends StatelessWidget {
  /// Creates an instance of [PreferencesScreen].
  const PreferencesScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final PreferencesState state = context.watch<PreferencesNotifier>().state;

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).settings)),
      body: switch (state) {
        PreferencesStateInitial() || PreferencesStateLoading() => const Center(
          child: CircularProgressIndicator(),
        ),
        PreferencesStateFailure(:final String message) => Center(
          child: Text(message),
        ),
        PreferencesStateSuccess(:final PreferencesEntity preferences) =>
          _PreferencesForm(preferences: preferences),
      },
    );
  }
}

class _PreferencesForm extends StatelessWidget {
  const _PreferencesForm({required this.preferences});

  final PreferencesEntity preferences;

  @override
  Widget build(final BuildContext context) {
    final PreferencesNotifier notifier = context.read<PreferencesNotifier>();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        SectionTitle(title: AppLocalizations.of(context).appearance),
        SwitchListTile(
          title: Text(AppLocalizations.of(context).darkMode),
          value: preferences.darkMode,
          onChanged: notifier.updateDarkMode,
        ),
        const Divider(),
        SectionTitle(title: AppLocalizations.of(context).fontSize),
        Slider(
          value: preferences.fontScale,
          min: 0.8,
          max: 1.4,
          divisions: 6,
          label: preferences.fontScale.toStringAsFixed(1),
          onChanged: notifier.updateFontScale,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('A', style: TextStyle(fontSize: 12)),
            Text('A', style: TextStyle(fontSize: 20)),
          ],
        ),
        const Divider(),
        SectionTitle(title: AppLocalizations.of(context).language),
        LocaleTile(
          label: 'Português',
          value: 'pt',
          selected: preferences.locale,
          onTap: () => notifier.updateLocale('pt'),
        ),
        LocaleTile(
          label: 'English',
          value: 'en',
          selected: preferences.locale,
          onTap: () => notifier.updateLocale('en'),
        ),
        LocaleTile(
          label: 'Español',
          value: 'es',
          selected: preferences.locale,
          onTap: () => notifier.updateLocale('es'),
        ),
      ],
    );
  }
}
