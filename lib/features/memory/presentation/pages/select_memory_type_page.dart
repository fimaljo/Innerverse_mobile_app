import 'dart:math';
import 'dart:ui';

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:innerverse/core/constants/emoji_options.dart';
import 'package:innerverse/core/navigation/route_constants.dart';
import 'package:innerverse/features/memory/domain/entities/emoji_option.dart';
import 'package:innerverse/shared/buttons/app_primary_button.dart';
import 'package:innerverse/shared/buttons/rounded_icon_button.dart'
    show GradientIconButton;
import 'package:innerverse/shared/widgets/custome_text_field.dart';
import 'package:rive/rive.dart' as rive;

class SelectMemoryTypePage extends StatefulWidget {
  const SelectMemoryTypePage({super.key});

  @override
  State<SelectMemoryTypePage> createState() => _SelectMemoryTypePageState();
}

class _SelectMemoryTypePageState extends State<SelectMemoryTypePage>
    with TickerProviderStateMixin {
  late PageController pageController;
  late AnimationController animationController;
  late CurvedAnimation bounceAnimation;
  int selectedIndex = 0;
  double speed = 5;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    bounceAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.elasticOut,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      onEmojiSelected(0);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    animationController.dispose();
    super.dispose();
  }

  void onEmojiSelected(int index, {bool fromBottom = false}) {
    if (fromBottom) {
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutBack,
      );
    }

    setState(() => selectedIndex = index);
    animationController.forward(from: 0);
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final selectedEmoji = emojiOptions[selectedIndex];
    // Assuming `speed` is from 0.0 to 10.0
    final normalized = (speed / 10).clamp(0.0, 1.0);

    // Particle properties
    final minSpeed = lerpDouble(0, 100, normalized)!;
    final maxSpeed = lerpDouble(0, 200, normalized)!;
    final particleCount = lerpDouble(0, 300, normalized)!.toInt();

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: selectedEmoji.gradient,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              child: AnimatedBackground(
                behaviour: RandomParticleBehaviour(
                  options: ParticleOptions(
                    baseColor: selectedEmoji.particleColor,
                    maxOpacity: 0.3,
                    spawnMinSpeed: minSpeed,
                    spawnMaxSpeed: maxSpeed,
                    spawnMinRadius: 2,
                    spawnMaxRadius: 5,
                    particleCount: particleCount,
                  ),
                ),
                vsync: this,
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: GradientIconButton(
                            icon: Icons.close,
                            onTap: () =>
                                context.pushNamed(RouteConstants.homeName),
                            size: 48,
                            gradientColors: selectedEmoji.gradient,
                            iconColor: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        selectedEmoji.label,
                        textAlign: TextAlign.center,
                        style: textTheme.headlineLarge,
                      ),
                      Expanded(
                        child: PageView.builder(
                          controller: pageController,
                          itemCount: emojiOptions.length,
                          onPageChanged: onEmojiSelected,
                          itemBuilder: (context, index) {
                            final isSelected = index == selectedIndex;
                            return ScaleTransition(
                              scale: isSelected
                                  ? bounceAnimation
                                  : const AlwaysStoppedAnimation(1),
                              child: rive.RiveAnimation.asset(
                                'assets/rive/innerverse3.riv',
                                artboard: emojiOptions[index].id,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(emojiOptions.length, (index) {
                          final isActive = index == selectedIndex;
                          return GestureDetector(
                            onTap: () =>
                                onEmojiSelected(index, fromBottom: true),
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  if (isActive)
                                    Container(
                                      height: 48,
                                      width: 48,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(),
                                      ),
                                    ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: emojiOptions[index].gradient,
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      border: Border.all(
                                        width: isActive ? 1 : 0.5,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'How does \nthis memory feel?',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: HalfCircleSliderWithAppButton(
                    selectedData: selectedEmoji,
                    gradientColors: selectedEmoji.gradient,
                    onChanged: (val) {
                      setState(() {
                        speed = val;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HalfCircleSliderWithAppButton extends StatefulWidget {
  const HalfCircleSliderWithAppButton({
    required this.gradientColors,
    required this.onChanged,
    required this.selectedData,
    super.key,
  });
  final List<Color> gradientColors;
  final void Function(double value) onChanged;
  final EmojiOption selectedData;

  @override
  State<HalfCircleSliderWithAppButton> createState() =>
      _HalfCircleSliderWithAppButtonState();
}

class _HalfCircleSliderWithAppButtonState
    extends State<HalfCircleSliderWithAppButton> {
  double sliderValue = 5;

  void _updateSlider(Offset localPosition, Size size) {
    final center = Offset(size.width / 2, size.height);
    final dx = localPosition.dx - center.dx;
    final dy = localPosition.dy - center.dy;
    final angle = atan2(dy, dx);

    if (angle >= -pi && angle <= 0) {
      final normalized = 1 - (angle.abs() / pi); // 0 (left) to 1 (right)
      final rawValue = normalized * 10; // 0 to 10
      final snappedValue = rawValue.round().clamp(0, 10);

      setState(() => sliderValue = snappedValue.toDouble());
      widget.onChanged(sliderValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        // Limit max size based on available space (esp. height)
        final maxAvailableWidth = constraints.maxWidth;
        final maxAvailableHeight = constraints.maxHeight;

        // Pick the smallest to avoid overflow
        final double size = min(maxAvailableWidth, maxAvailableHeight * 0.7);
        final radius = size / 2;
        final strokeWidth = size * 0.08;

        return GestureDetector(
          onPanUpdate: (details) {
            final box = context.findRenderObject() as RenderBox;
            _updateSlider(box.globalToLocal(details.globalPosition), box.size);
          },
          child: SizedBox(
            width: size,
            height: radius + 60, // reduced from +70 to +60
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomPaint(
                  size: Size(size, radius),
                  painter: GradientArcPainter(
                    value: sliderValue,
                    colors: widget.gradientColors,
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
                  child: Hero(
                    tag: 'next_button',
                    child: AppPrimaryButton(
                      onTap: () {
                        context.pushNamed(
                          RouteConstants.addMemoryDetailName,
                          extra: widget.selectedData,
                        );
                      },
                      height: size * 0.2,
                      minWidth: size * 0.2,
                      maxWidth: size * 0.3,
                      gradientColors: widget.gradientColors,
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      ),
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
      endAngle: 2 * pi,
      colors: colors,
    );

    final fgPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progress = value / 10;
    final sweepAngle = pi * progress;

    // Arc drawing
    canvas.drawArc(rect, pi, pi, false, bgPaint);
    canvas.drawArc(rect, pi, sweepAngle, false, fgPaint);

    // Thumb (with shadow)
    final thumbAngle = pi + sweepAngle;
    final thumbRadius = strokeWidth * 0.6;
    final thumbX = center.dx + radius * cos(thumbAngle);
    final thumbY = center.dy + radius * sin(thumbAngle);

    final thumbCenter = Offset(thumbX, thumbY);
    final thumbPath = Path()
      ..addOval(Rect.fromCircle(center: thumbCenter, radius: thumbRadius));

    canvas.drawShadow(thumbPath, Colors.black.withOpacity(0.4), 4, true);
    canvas.drawCircle(thumbCenter, thumbRadius, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
