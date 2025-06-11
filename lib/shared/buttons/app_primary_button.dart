import 'package:flutter/material.dart';

enum ButtonCornerSide { left, right, none, all }

class AppPrimaryButton extends StatefulWidget {
  const AppPrimaryButton({
    super.key,
    required this.onTap,
    this.child,
    this.height = 48,
    this.minWidth = 100,
    this.maxWidth,
    this.cornerSide = ButtonCornerSide.all,
    this.radius = 20,
    this.gradientColors = const [Colors.indigo, Colors.blue],
    this.isLoading = false,
    this.loadingColor = Colors.white,
    this.enableShrinkEffect = true,
  });

  final VoidCallback onTap;
  final Widget? child;
  final double height;
  final double minWidth;
  final double? maxWidth;
  final ButtonCornerSide cornerSide;
  final double radius;
  final List<Color> gradientColors;
  final bool isLoading;
  final Color loadingColor;
  final bool enableShrinkEffect;

  @override
  State<AppPrimaryButton> createState() => _AppPrimaryButtonState();
}

class _AppPrimaryButtonState extends State<AppPrimaryButton> {
  double _scale = 1.0;

  void _onTapDown(_) {
    if (widget.enableShrinkEffect) {
      setState(() => _scale = 0.95);
    }
  }

  void _onTapUp(_) {
    if (widget.enableShrinkEffect) {
      setState(() => _scale = 1.0);
    }
  }

  void _onTapCancel() {
    if (widget.enableShrinkEffect) {
      setState(() => _scale = 1.0);
    }
  }

  BorderRadius _getBorderRadius() {
    switch (widget.cornerSide) {
      case ButtonCornerSide.left:
        return BorderRadius.only(
          topRight: Radius.circular(widget.radius),
        );
      case ButtonCornerSide.right:
        return BorderRadius.only(
          topLeft: Radius.circular(widget.radius),
        );
      case ButtonCornerSide.none:
        return BorderRadius.zero;
      case ButtonCornerSide.all:
        return BorderRadius.circular(widget.radius);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: (details) {
        _onTapUp(details);
        if (!widget.isLoading) widget.onTap();
      },
      onTapCancel: _onTapCancel,
      child: Transform.scale(
        scale: _scale,
        child: Container(
          height: widget.height,
          constraints: BoxConstraints(
            minWidth: widget.minWidth,
            maxWidth: widget.maxWidth ?? double.infinity,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: _getBorderRadius(),
            boxShadow: [
              if (_scale == 1.0)
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 4),
                  blurRadius: 6,
                ),
            ],
          ),
          child: Center(
            child: widget.isLoading
                ? SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: widget.loadingColor,
                    ),
                  )
                : widget.child ??
                      const Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}
