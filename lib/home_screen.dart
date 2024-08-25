import 'package:flutter/material.dart';

import 'package:life/game.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      body: const Center(
        child: Game(),
      ),
    );
  }
}
