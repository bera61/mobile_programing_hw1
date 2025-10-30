import 'package:flutter/material.dart';

class hakkinda extends StatelessWidget {
  const hakkinda({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: const Center(
          child: Text(
            'Hakkında Sayfası',
            style: TextStyle(fontSize: 24),
          ),
        ),
      );
  }
}