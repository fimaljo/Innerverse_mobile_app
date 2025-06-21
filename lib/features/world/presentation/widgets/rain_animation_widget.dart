import 'dart:math';
import 'package:flutter/material.dart';

class RainAnimationWidget extends StatefulWidget {
  const RainAnimationWidget({
    required this.isRaining,
    required this.daysSinceLastMemory,
    super.key,
  });

  final bool isRaining;
  final int daysSinceLastMemory;

  @override
  State<RainAnimationWidget> createState() => _RainAnimationWidgetState();
}

class _RainAnimationWidgetState extends State<RainAnimationWidget>
    with TickerProviderStateMixin {
  late AnimationController _rainController;
  late AnimationController _thunderController;
  late Animation<double> _rainAnimation;
  late Animation<double> _thunderAnimation;
  final List<RainDrop> _rainDrops = [];
  final List<Cloud> _clouds = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _rainController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _thunderController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _rainAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _rainController,
      curve: Curves.linear,
    ));

    _thunderAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _thunderController,
      curve: Curves.easeInOut,
    ));

    _generateRainDrops();
    _generateClouds();

    if (widget.isRaining) {
      _startRain();
    }
  }

  @override
  void didUpdateWidget(RainAnimationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRaining && !oldWidget.isRaining) {
      _startRain();
    } else if (!widget.isRaining && oldWidget.isRaining) {
      _stopRain();
    }

    // Regenerate rain drops and clouds if intensity changed
    if (widget.daysSinceLastMemory != oldWidget.daysSinceLastMemory) {
      _generateRainDrops();
      _generateClouds();
    }
  }

  @override
  void dispose() {
    _rainController.dispose();
    _thunderController.dispose();
    super.dispose();
  }

  /// Calculate rain intensity based on minutes since last memory
  double get _rainIntensity {
    if (widget.daysSinceLastMemory <= 0) return 0;
    // More gradual increase: 1 minute = 0.1, 2 minutes = 0.3, 3 minutes = 0.5, 4+ minutes = 1.0
    return (widget.daysSinceLastMemory / 4.0).clamp(0.0, 1.0);
  }

  /// Calculate thunder frequency based on minutes since last memory
  double get _thunderFrequency {
    if (widget.daysSinceLastMemory <= 2) return 0;
    // Thunder starts after 3 minutes and increases with time
    return ((widget.daysSinceLastMemory - 2) / 3.0).clamp(0.0, 1.0);
  }

  void _generateRainDrops() {
    _rainDrops.clear();
    final intensity = _rainIntensity;
    final dropCount =
        (20 + (intensity * 180)).toInt(); // 20-200 drops (lighter start)

    for (var i = 0; i < dropCount; i++) {
      _rainDrops.add(RainDrop(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        speed: (0.5 + _random.nextDouble() * 1.0) *
            (1.0 + intensity * 2.0), // Much faster with intensity
        length: (8.0 + _random.nextDouble() * 15.0) *
            (1.0 + intensity * 0.3), // Shorter start
        opacity: (0.2 + _random.nextDouble() * 0.4) *
            (0.5 + intensity * 0.5), // More transparent start
        thickness: 0.5 + intensity * 2.5, // Thinner start
      ));
    }
  }

  void _generateClouds() {
    _clouds.clear();
    final intensity = _rainIntensity;
    final cloudCount =
        (1 + (intensity * 4)).toInt(); // 1-5 clouds (fewer for better flow)

    for (var i = 0; i < cloudCount; i++) {
      // Create a continuous flow - clouds start at visible positions
      final startX = -1.5 + (i * 0.6); // Closer spacing for better completion

      _clouds.add(Cloud(
        x: startX, // Staggered starting positions
        y: 0.1 + (_random.nextDouble() * 0.2), // Keep clouds in upper portion
        size: 60.0 +
            _random.nextDouble() * 80.0, // Increased size range (60-140px)
        opacity: 0.1 + intensity * 0.8, // Much lighter for 1 minute
        speed:
            0.0003 + _random.nextDouble() * 0.0005, // Extremely slow movement
        direction: 1, // All clouds move left to right
      ));
    }
  }

  void _startRain() {
    _rainController.repeat();
    _startThunder();
  }

  void _stopRain() {
    _rainController.stop();
    _thunderController.stop();
  }

  void _startThunder() {
    if (_thunderFrequency > 0) {
      _scheduleThunder();
    }
  }

  void _scheduleThunder() {
    if (!widget.isRaining) return;

    // Random delay between 5-20 seconds, shorter for higher intensity
    final delay = Duration(
      milliseconds:
          (5000 + _random.nextDouble() * 15000 * (1.0 - _thunderFrequency))
              .toInt(),
    );

    Future.delayed(delay, () {
      if (mounted && widget.isRaining) {
        _flashThunder();
        _scheduleThunder(); // Schedule next thunder
      }
    });
  }

  void _flashThunder() {
    _thunderController.forward().then((_) {
      _thunderController.reverse();
    });
  }

  void _updateClouds() {
    for (var i = 0; i < _clouds.length; i++) {
      final cloud = _clouds[i];
      cloud.x += cloud.speed * cloud.direction;

      // Reset cloud when it goes off-screen to the right
      if (cloud.x > 1.5) {
        // Reset to left side with staggered timing
        cloud.x = -1.5 - (i * 0.3); // Staggered reset positions
        cloud.y = 0.1 + (_random.nextDouble() * 0.2); // Randomize Y position
        cloud.size = 60.0 + _random.nextDouble() * 80.0; // Randomize size
        cloud.opacity =
            0.1 + _rainIntensity * 0.8; // Update opacity based on intensity
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isRaining) return const SizedBox.shrink();

    return Stack(
      children: [
        // Thunder flash overlay
        AnimatedBuilder(
          animation: _thunderAnimation,
          builder: (context, child) {
            return Container(
              color: Colors.white.withOpacity(_thunderAnimation.value * 0.3),
            );
          },
        ),
        // Rain animation
        AnimatedBuilder(
          animation: _rainAnimation,
          builder: (context, child) {
            // Update cloud positions
            _updateClouds();

            return CustomPaint(
              painter: RainPainter(
                rainDrops: _rainDrops,
                clouds: _clouds,
                animationValue: _rainAnimation.value,
                intensity: _rainIntensity,
              ),
              size: Size.infinite,
            );
          },
        ),
      ],
    );
  }
}

class RainDrop {
  RainDrop({
    required this.x,
    required this.y,
    required this.speed,
    required this.length,
    required this.opacity,
    required this.thickness,
  });

  double x;
  double y;
  final double speed;
  final double length;
  final double opacity;
  final double thickness;
}

class Cloud {
  Cloud({
    required this.x,
    required this.y,
    required this.size,
    required this.opacity,
    required this.speed,
    required this.direction,
  });

  double x;
  double y;
  double size;
  double opacity;
  final double speed;
  final int direction; // 1 for right, -1 for left
}

class RainPainter extends CustomPainter {
  RainPainter({
    required this.rainDrops,
    required this.clouds,
    required this.animationValue,
    required this.intensity,
  });

  final List<RainDrop> rainDrops;
  final List<Cloud> clouds;
  final double animationValue;
  final double intensity;

  @override
  void paint(Canvas canvas, Size size) {
    // Draw clouds first (background)
    _drawClouds(canvas, size);

    // Draw rain drops
    _drawRainDrops(canvas, size);
  }

  void _drawClouds(Canvas canvas, Size size) {
    for (final cloud in clouds) {
      // Use actual cloud position (already updated by _updateClouds)
      final centerX = cloud.x * size.width;
      final centerY = cloud.y * size.height;

      // Create cloud using a single path for consistent opacity
      final paint = Paint()
        ..color = Colors.grey.shade600.withOpacity(cloud.opacity)
        ..style = PaintingStyle.fill;

      // Create cloud shape using a single path
      final cloudWidth = cloud.size * 1.2; // Increased width
      final cloudHeight = cloud.size * 0.6;

      final path = Path();

      // Main cloud body - rounded rectangle
      final mainRect = RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(centerX, centerY),
          width: cloudWidth,
          height: cloudHeight,
        ),
        Radius.circular(cloud.size * 0.3),
      );

      path.addRRect(mainRect);

      // Add cloud bumps on top
      final topBumpRadius = cloud.size * 0.25;
      final topBumpPositions = [
        Offset(centerX - cloudWidth * 0.3, centerY - cloudHeight * 0.3),
        Offset(centerX - cloudWidth * 0.1, centerY - cloudHeight * 0.4),
        Offset(centerX + cloudWidth * 0.1, centerY - cloudHeight * 0.4),
        Offset(centerX + cloudWidth * 0.3, centerY - cloudHeight * 0.3),
      ];

      for (final position in topBumpPositions) {
        path.addOval(Rect.fromCircle(center: position, radius: topBumpRadius));
      }

      // Add cloud bumps on bottom for better shape
      final bottomBumpRadius = cloud.size * 0.2;
      final bottomBumpPositions = [
        Offset(centerX - cloudWidth * 0.25, centerY + cloudHeight * 0.25),
        Offset(centerX, centerY + cloudHeight * 0.3),
        Offset(centerX + cloudWidth * 0.25, centerY + cloudHeight * 0.25),
      ];

      for (final position in bottomBumpPositions) {
        path.addOval(
            Rect.fromCircle(center: position, radius: bottomBumpRadius));
      }

      // Draw the entire cloud as a single shape
      canvas.drawPath(path, paint);
    }
  }

  void _drawRainDrops(Canvas canvas, Size size) {
    for (final drop in rainDrops) {
      final currentY = (drop.y + animationValue * drop.speed) % 1.0;
      final startY = currentY * size.height;
      final endY = startY + drop.length;

      if (endY < size.height) {
        final paint = Paint()
          ..color = Colors.white.withOpacity(drop.opacity * 0.6)
          ..strokeWidth = drop.thickness
          ..strokeCap = StrokeCap.round;

        canvas.drawLine(
          Offset(drop.x * size.width, startY),
          Offset(drop.x * size.width, endY),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(RainPainter oldDelegate) => true;
}
