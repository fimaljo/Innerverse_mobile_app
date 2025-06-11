import 'package:flutter/material.dart';

class GradientIconButton extends StatefulWidget {
  const GradientIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 50,
    this.gradientColors = const [Colors.purple, Colors.blue],
    this.iconColor = Colors.white,
  });

  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final List<Color> gradientColors;
  final Color iconColor;

  @override
  State<GradientIconButton> createState() => _GradientIconButtonState();
}

class _GradientIconButtonState extends State<GradientIconButton>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(_) {
    setState(() {
      _scale = 0.92; // Shrink on press
    });
  }

  void _onTapUp(_) {
    setState(() {
      _scale = 1.0;
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: (details) {
        _onTapUp(details);
        widget.onTap();
      },
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: _scale,
        curve: Curves.easeOut,
        child: Container(
          height: widget.size,
          width: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: widget.gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Icon(
            widget.icon,
            color: widget.iconColor,
            size: widget.size * 0.5,
          ),
        ),
      ),
    );
  }
}
