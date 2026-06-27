import 'package:flutter/material.dart';

/// Widget for displaying section titles in the preferences screen.
class SectionTitle extends StatelessWidget {
  /// Creates a new instance of [SectionTitle] with the given title.
  const SectionTitle({required this.title, super.key});

  /// The title text to be displayed as the section header.
  final String title;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: Colors.grey,
      ),
    ),
  );
}
