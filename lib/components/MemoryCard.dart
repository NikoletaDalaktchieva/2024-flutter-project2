import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/text.dart';

class MemoryCard extends RectangleComponent with TapCallbacks {
  final String cardText;
  late final TextPaint _textPaint;
  void onTapFunc;
  bool isFlipped = false;
  final Function(MemoryCard) onFlip;

  MemoryCard(Vector2 position, this.cardText, {required this.onFlip})
      : super(
          position: position,
          size: Vector2(50, 100),
          anchor: Anchor.center,
        ) {
    _textPaint = TextPaint(
      style: const TextStyle(
        fontSize: 24.0,
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
}
