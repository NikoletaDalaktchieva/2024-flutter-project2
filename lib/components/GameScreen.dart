import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memory_game/components/LevelsScreen.dart';
import 'package:memory_game/components/MemoryGame.dart';
import 'package:memory_game/models/Levels.dart';

class GameScreen extends StatelessWidget {
  final Levels level;

  const GameScreen(this.level);
  @override
  Widget build(BuildContext context) {
    var game = MemoryGame(level);
    return
        // Center(
        // child: Column(children: [
        GameWidget(game: game);
    // ElevatedButton(
    //   onPressed: () {
    //     Get.to(LevelScreen());
    //   },
    //   child: const Text("Stop Game"),
    // ),
    // ]),
    // );
  }
}
