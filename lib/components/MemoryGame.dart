import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memory_game/components/MemoryCard.dart';
import 'package:memory_game/models/Levels.dart';

import 'ResultScreen.dart';

class GameScreen extends StatelessWidget {
  final Levels level;

  GameScreen(this.level);
  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: MemoryGame(level),
    );
  }
}

class MemoryGame extends FlameGame {
  List<MemoryCard> flippedCards = [];
  var gameFinished = false;
  double timeLeft;
  final Levels level;
  int flipped = 0;

  MemoryGame(this.level) : timeLeft = level.timeLimit;

  @override
  Future<void> onLoad() async {
    initializeGame();
    super.onLoad();
  }

  @override
  Color backgroundColor() {
    return Color(0xFFD8CAB8);
  }

  void initializeGame() {
    List<String> symbols = generateShuffledSymbols(level.pairs);
    for (int i = 0; i < symbols.length; i++) {
      final position =
          Vector2(100.0 * ((i + 1) % 4) + 100, 150.0 * (i ~/ 4) + 100);
      add(MemoryCard(
        position,
        symbols[i],
        onFlip: handleCardFlip,
      ));
    }
  }

  List<String> generateShuffledSymbols(int x) {
    List<String> uniqueSymbols = List.generate(x, (index) => '$index');
    List<String> duplicatedSymbols = [...uniqueSymbols, ...uniqueSymbols];
    duplicatedSymbols.shuffle(Random());
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
}
