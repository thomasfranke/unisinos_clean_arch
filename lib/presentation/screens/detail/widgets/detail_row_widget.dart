import 'package:flutter/material.dart';

/// A reusable widget for displaying a labeled value in the detail screen,
/// with optional color styling for the value.
class DetailRow extends StatelessWidget {
  /// Creates a new instance of [DetailRow].
  const DetailRow({
    required this.label,
    required this.value,
    super.key,
    this.valueColor,
  });

  /// The label to display on the left side of the row.
  final String label;

  /// The value to display on the right side of the row.
  final String value;

  /// Optional color for the value text, used to indicate positive/negative changes.
  final Color? valueColor;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, color: valueColor),
        ),
      ],
    ),
  );
}
