import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memory_game/components/MemoryGame.dart';
import 'package:memory_game/models/Levels.dart';

class LevelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final levels = Levels.values.map((level) {
      return ElevatedButton(
        child: Text(level.name),
        onPressed: () {
          Get.to(GameScreen(level));
        },
      );
    }).toList();
    return Column(children: [const Text("Select a level"), ...levels]);
  }
}
