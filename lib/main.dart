import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memory_game/controllers/GameController.dart';
import 'package:sizer/sizer.dart';
import 'package:memory_game/components/LevelsScreen.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox("storage");

  Get.lazyPut<GameController>(() => GameController(), fenix: true);
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'Memory Game',
          home: Scaffold(
            appBar: AppBar(
              title: const Text("Memory Game"),
            ),
            body: LevelScreen(),
          ),
        );
      },
    ),
  );
}
