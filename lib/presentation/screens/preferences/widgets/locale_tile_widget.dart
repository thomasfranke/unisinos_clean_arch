import 'package:flutter/material.dart';

/// Tile widget for selecting a locale in the preferences screen.
class LocaleTile extends StatelessWidget {
  /// Creates a new instance of [LocaleTile].
  const LocaleTile({
    required this.label,
    required this.value,
    required this.selected,
    required this.onTap,
    super.key,
  });

  /// The display label for the locale option.
  final String label;

  /// The locale value associated with this tile (e.g., 'en', 'pt').
  final String value;

  /// The currently selected locale value to determine if this tile is active.
  final String selected;

  /// Callback function to be invoked when the tile is tapped, typically to
  /// update the selected locale in the preferences state.
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) => ListTile(
    title: Text(label),
    trailing: selected == value
        ? const Icon(Icons.check, color: Colors.green)
        : null,
    onTap: onTap,
  );
}
