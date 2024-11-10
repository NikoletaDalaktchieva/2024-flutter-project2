import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memory_game/components/MemoryCard.dart';
import 'package:memory_game/controllers/GameController.dart';
import 'package:memory_game/models/Levels.dart';
import 'package:memory_game/widget/config.dart';

import 'ResultScreen.dart';

class MemoryGame extends FlameGame {
  List<MemoryCard> flippedCards = [];
  var gameFinished = false;
  double timeLeft;
  final Levels level;
  int flipped = 0;
  GameController gameController = Get.find<GameController>();

  MemoryGame(this.level)
      : timeLeft = level.timeLimit,
        super(
          camera: CameraComponent.withFixedResolution(
            width: gameWidth,
            height: gameHeight,
          ),
        );

  @override
  Future<void> onLoad() async {
    initializeGame();
    super.onLoad();
  }

  @override
  Color backgroundColor() {
    return backgroundColorConf;
  }

  void initializeGame() {
    List<String> symbols = generateShuffledSymbols(level.pairs);
    for (int i = 0; i < symbols.length; i++) {
      add(MemoryCard(
        i,
        symbols[i],
        handleCardFlip,
      ));
    }
  }

  List<String> generateShuffledSymbols(int x) {
    List<String> uniqueSymbols = gameController.getLevelProgress(level.name);
    if (uniqueSymbols.isNotEmpty) return uniqueSymbols;

    uniqueSymbols = List.generate(x, (index) => '$index');
    List<String> duplicatedSymbols = [...uniqueSymbols, ...uniqueSymbols];
    duplicatedSymbols.shuffle(Random());
    gameController.saveLevel(level.name, duplicatedSymbols);
    return duplicatedSymbols;
  }

  void handleCardFlip(MemoryCard card) async {
    if (flippedCards.contains(card) || flippedCards.length >= 2) return;

    card.isFlipped = true;
    flippedCards.add(card);

    if (flippedCards.length == 2) {
      if (flippedCards[0].cardText == flippedCards[1].cardText) {
        flippedCards.clear();
        flipped++;
      } else {
        await Future.delayed(const Duration(seconds: 1));
        flippedCards.forEach((card) => card.isFlipped = false);
        flippedCards.clear();
      }

      checkWinCondition();
    }
  }

  void checkWinCondition() {
    if (flipped == level.pairs) {
      Get.offAll(() => const ResultScreen(true));
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    timeLeft -= dt;

    if (timeLeft <= 0 && !gameFinished) {
      gameFinished = true;
      Get.offAll(() => const ResultScreen(false));
    }
  }

  stopGame() {
    gameFinished = true;
  }
}
