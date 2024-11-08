import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:memory_game/components/LevelsScreen.dart';

void main() {
  runApp(
    GetMaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text("Memory Game")),
          body: LevelScreen()),
    ),
  );
}
