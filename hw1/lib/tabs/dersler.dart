import 'package:flutter/material.dart';

class dersler extends StatelessWidget {
  const dersler({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: const Center(
          child: Text(
            'Dersler sayfası',
            style: TextStyle(fontSize: 24),
          ),
        ),
      );
  }
}