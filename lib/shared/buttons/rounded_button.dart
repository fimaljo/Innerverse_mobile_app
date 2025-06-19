import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.buttonTxt,
    required this.verticalPadding,
    required this.horizontalPadding,
    super.key,
    this.isBorderedButton = false,
    this.isDisabled = false,
    this.borderColor,
    this.textColor,
    this.gradientFirstColor = Colors.blue,
    this.gradientSecondColor = Colors.purple,
    this.borderRadius = 30.0,
    this.isLoading = false,
    this.buttonTextCategory,
    this.loadingIndicatorSize = 25,
    this.loadingIndicatorStrokeWidth = 4,
    this.onTap,
  });

  final String buttonTxt;
  final double verticalPadding;
  final double horizontalPadding;

  final bool isBorderedButton;
  final bool isDisabled;
  final Color? borderColor;
  final Color? textColor;
  final Color gradientFirstColor;
  final Color gradientSecondColor;
  final double borderRadius;
  final bool isLoading;
  final double loadingIndicatorSize;
  final double loadingIndicatorStrokeWidth;
  final dynamic buttonTextCategory;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = BorderRadius.circular(borderRadius);
    final buttonChild = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: isLoading
          ? SizedBox(
              height: loadingIndicatorSize,
              width: loadingIndicatorSize,
              child: CircularProgressIndicator(
                strokeWidth: loadingIndicatorStrokeWidth,
                color: textColor ?? Colors.white,
              ),
            )
          : Text(
              buttonTxt,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color:
                    textColor ??
                    (isBorderedButton ? gradientFirstColor : Colors.white),
              ),
            ),
    );

    return GestureDetector(
      onTap: isDisabled || isLoading ? null : onTap,
      child: ClipRRect(
        borderRadius: effectiveRadius,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: effectiveRadius,
            color: isBorderedButton || isDisabled ? null : null,
            gradient: isBorderedButton || isDisabled
                ? null
                : LinearGradient(
                    colors: [gradientFirstColor, gradientSecondColor],
                  ),
            border: isBorderedButton
                ? Border.all(color: borderColor ?? gradientFirstColor)
                : null,
          ),
          child: Center(child: buttonChild),
        ),
      ),
    );
  }
}
