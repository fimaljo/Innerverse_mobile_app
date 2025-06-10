import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomeTextField extends StatefulWidget {
  const CustomeTextField({
    super.key,
    this.hintText,
    this.controller,
    this.keyboardType = TextInputType.multiline,
    this.obscureText = false,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.enabled = true,
    this.maxLines,
    this.textStyle,
    this.hintStyle,
    this.textColor,
    this.hintColor,
    this.fontSize = 18.0,
    this.fontWeight = FontWeight.w400,
    this.focusNode,
    this.contentPadding,
    this.animateHint = false,
  });

  final String? hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final bool enabled;
  final int? maxLines;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Color? textColor;
  final Color? hintColor;
  final double fontSize;
  final FontWeight fontWeight;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final bool animateHint;

  @override
  State<CustomeTextField> createState() => _CustomeTextFieldState();
}

class _CustomeTextFieldState extends State<CustomeTextField> {
  late FocusNode _focusNode;
  late TextEditingController _controller;
  String? _errorText;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? TextEditingController();

    _focusNode.addListener(_onFocusChange);
    _controller.addListener(_onTextChange);

    _errorText = widget.validator?.call(_controller.text);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _onTextChange() {
    final newErrorText = widget.validator?.call(_controller.text);
    if (_errorText != newErrorText) {
      setState(() {
        _errorText = newErrorText;
      });
    }
    widget.onChanged?.call(_controller.text);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultTextColor = widget.textColor ?? Colors.white;
    final defaultHintColor = widget.hintColor ?? Colors.white.withOpacity(0.6);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
              controller: _controller,
              focusNode: _focusNode,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText,
              onFieldSubmitted: widget.onSubmitted,
              onTap: widget.onTap,
              enabled: widget.enabled,
              maxLines: widget.maxLines ?? null,
              textAlign: TextAlign.start,
              style:
                  widget.textStyle ??
                  TextStyle(
                    fontSize: widget.fontSize,
                    fontWeight: widget.fontWeight,
                    color: defaultTextColor,
                    height: 1.6,
                  ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle:
                    widget.hintStyle ??
                    TextStyle(
                      color: defaultHintColor,
                      fontSize: widget.fontSize,
                    ),
                contentPadding:
                    widget.contentPadding ??
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                isDense: true,
              ),
            )
            .animate(target: _isFocused ? 1 : 0)
            .shimmer(
              duration: 1500.ms,
              color: defaultTextColor.withOpacity(0.2),
            ),

        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 8),
            child: Text(
              _errorText ?? '',
              style: const TextStyle(
                color: Colors.redAccent,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
      ],
    );
  }
}
