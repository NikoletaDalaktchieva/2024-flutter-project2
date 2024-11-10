import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/text.dart';
import 'package:memory_game/widget/config.dart';

class MemoryCard extends RectangleComponent with TapCallbacks {
  final String cardText;
  late final TextPaint _textPaint;
  void onTapFunc;
  bool isFlipped = false;
  final Function(MemoryCard) onFlip;
  final int index;

  MemoryCard(this.index, this.cardText, this.onFlip)
      : super(anchor: Anchor.center, size: Vector2(cardWidth, cardHeight)) {
    _textPaint = TextPaint(
      style: const TextStyle(
        color: Color(0xFF000000),
      ),
    );
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    Paint paint = Paint()
      ..color = isFlipped ? Color(0xFFC69C6D) : Color(0xFF8E7C5D);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), paint);

    String text = isFlipped ? cardText : "?";
    _textPaint.render(
      canvas,
      text,
      Vector2(size.x / 2, size.y / 2),
      anchor: Anchor.center,
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    onFlip(this);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    var padding = 10;
    // double width = gameSize.x > 1000 ? 100 : 10.w;
    // double height = 2 * width;
    // size = Vector2(width, height);

    position = Vector2(
      ((index + 1) % 4) * (cardWidth + padding),
      (index ~/ 4) * (cardHeight + padding),
    );
  }
}
