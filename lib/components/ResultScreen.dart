import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memory_game/components/LevelsScreen.dart';

class ResultScreen extends StatelessWidget {
  final bool result;
  const ResultScreen(this.result);
  @override
  Widget build(BuildContext context) {
    String text = result ? "You win" : "You lose";
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(text, style: TextStyle(fontSize: 48)),
            const Padding(
              padding: EdgeInsets.all(16),
            ),
            ElevatedButton(
              child: const Text(
                "Back to start",
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () => Get.to(() => LevelScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
