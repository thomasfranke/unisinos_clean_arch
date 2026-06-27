import 'package:flutter/material.dart';

/// A card widget that displays a section with a title and a list of
/// child widgets.
class SectionCard extends StatelessWidget {
  /// Creates a new instance of [SectionCard].
  const SectionCard({required this.title, required this.children, super.key});

  /// The title of the section, displayed at the top of the card.
  final String title;

  /// The list of child widgets to display within the card, shown below the
  /// title.
  final List<Widget> children;

  @override
  Widget build(final BuildContext context) => Card(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: Colors.grey.withAlpha(31)),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    ),
  );
}
