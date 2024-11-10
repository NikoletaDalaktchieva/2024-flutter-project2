import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memory_game/components/GameScreen.dart';
import 'package:memory_game/models/Levels.dart';
import 'package:sizer/sizer.dart';

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
    return Center(
        child: Column(children: [
      Text(
        "Select a level",
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.brown, fontSize: 28.sp),
      ),
      ...levels
    ]));
  }
}
