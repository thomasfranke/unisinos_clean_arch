import 'package:flutter/material.dart';

/// Banner widget indicating that the displayed data is from cache due to
/// lack of connection.
class CacheBanner extends StatelessWidget {
  /// Creates a new instance of [CacheBanner].
  const CacheBanner({super.key});

  @override
  Widget build(final BuildContext context) => Container(
    width: double.infinity,
    color: Colors.amber.shade100,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: const Row(
      children: <Widget>[
        Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 16),
        SizedBox(width: 8),
        Text(
          'Dados do cache — sem conexão',
          style: TextStyle(
            color: Colors.orange,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
