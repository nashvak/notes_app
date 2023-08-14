import 'package:flutter/material.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'A R C H I V E',
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
