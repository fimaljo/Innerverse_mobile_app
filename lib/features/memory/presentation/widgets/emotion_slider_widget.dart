import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:innerverse/features/memory/domain/entities/emoji_option.dart';
import 'package:innerverse/features/memory/presentation/constants/memory_creation_constants.dart';
import 'package:innerverse/shared/buttons/app_primary_button.dart';

/// Widget for the emotion slider with half-circle design
class EmotionSliderWidget extends StatefulWidget {
  const EmotionSliderWidget({
    required this.selectedEmoji,
    required this.onChanged,
    required this.onNextPressed,
    required this.initialValue,
    super.key,
  });

  final EmojiOption selectedEmoji;
  final ValueChanged<double> onChanged;
  final VoidCallback onNextPressed;
  final double initialValue;

  @override
  State<EmotionSliderWidget> createState() => _EmotionSliderWidgetState();
}

class _EmotionSliderWidgetState extends State<EmotionSliderWidget> {
  late double sliderValue;

  @override
  void initState() {
    super.initState();
    sliderValue = widget.initialValue;
  }

  void _updateSlider(Offset localPosition, Size size) {
    final center = Offset(size.width / 2, size.height);
    final dx = localPosition.dx - center.dx;
    final dy = localPosition.dy - center.dy;
    final angle = atan2(dy, dx);

    if (angle >= -pi && angle <= 0) {
      final normalized = 1 - (angle.abs() / pi); // 0 (left) to 1 (right)
      final rawValue = normalized * MemoryCreationConstants.maxEmotionValue;
      final snappedValue = rawValue
          .round()
          .clamp(
            MemoryCreationConstants.minEmotionValue.toInt(),
            MemoryCreationConstants.maxEmotionValue.toInt(),
          )
          .toDouble();

      if (snappedValue != sliderValue) {
        HapticFeedback.lightImpact();
        setState(() => sliderValue = snappedValue);
        widget.onChanged(sliderValue);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxAvailableWidth = constraints.maxWidth;
        final maxAvailableHeight = constraints.maxHeight;
        final size = min(maxAvailableWidth, maxAvailableHeight * 0.7);
        final radius = size / 2;
        final strokeWidth = size / 7;

        return GestureDetector(
          onPanUpdate: (details) {
            final box = context.findRenderObject()! as RenderBox;
            _updateSlider(box.globalToLocal(details.globalPosition), box.size);
          },
          child: SizedBox(
            width: size,
            height: radius + 60,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomPaint(
                  size: Size(size, radius),
                  painter: GradientArcPainter(
                    value: sliderValue,
                    colors: widget.selectedEmoji.gradient,
                    strokeWidth: strokeWidth,
                  ),
                ),
                Positioned(
                  bottom: size * 0.26,
                  child: Text(
                    sliderValue.toInt().toString(),
                    style: textTheme.bodyLarge,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: AppPrimaryButton(
                    onTap: widget.onNextPressed,
                    height: size * 0.2,
                    minWidth: size * 0.2,
                    maxWidth: size * 0.3,
                    gradientColors: widget.selectedEmoji.gradient,
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Custom painter for the gradient arc slider
class GradientArcPainter extends CustomPainter {
  GradientArcPainter({
    required this.value,
    required this.colors,
    required this.strokeWidth,
  });

  final double value;
  final List<Color> colors;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final bgPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final gradient = SweepGradient(
      startAngle: pi,
      colors: colors,
    );

    final fgPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progress = value / MemoryCreationConstants.maxEmotionValue;
    final sweepAngle = pi * progress;

    // Arc drawing
    canvas
      ..drawArc(rect, pi, pi, false, bgPaint)
      ..drawArc(rect, pi, sweepAngle, false, fgPaint);

    // Thumb (with shadow)
    final thumbAngle = pi + sweepAngle;
    final thumbRadius = strokeWidth * 0.6;
    final thumbX = center.dx + radius * cos(thumbAngle);
    final thumbY = center.dy + radius * sin(thumbAngle);

    final thumbCenter = Offset(thumbX, thumbY);
    final thumbPath = Path()
      ..addOval(Rect.fromCircle(center: thumbCenter, radius: thumbRadius));

    canvas
      ..drawShadow(thumbPath, Colors.black.withValues(alpha: 0.4), 4, true)
      ..drawCircle(thumbCenter, thumbRadius, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
