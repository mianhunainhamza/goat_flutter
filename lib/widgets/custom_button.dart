import 'package:flutter/material.dart';

import '../config/app_config.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final String tag;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isLoading;
  final double? height;
  final double? width;
  final double? textHeight;

  const CustomButton({
    super.key,
    required this.text,
    this.width,
    this.textHeight,
    required this.onPressed,
    this.height,
    required this.isLoading,
    this.icon,
    this.backgroundColor,
    this.textColor,
    required this.tag,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color finalBackgroundColor = widget.backgroundColor ?? Theme.of(context).colorScheme.tertiary;
    final Color finalTextColor = widget.textColor ?? Theme.of(context).colorScheme.secondary;

    return GestureDetector(
      onTap: widget.isLoading
          ? null
          : () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onPressed();
      },
      child: Hero(
        tag: widget.tag,
        child: ScaleTransition(
          scale: _tween.animate(
            CurvedAnimation(
              parent: _controller,
              curve: Curves.easeOut,
              reverseCurve: Curves.easeIn,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: finalBackgroundColor,
              borderRadius: BorderRadius.circular(AppConfig.borderRadius),
            ),
            alignment: Alignment.center,
            height: widget.height ?? AppConfig.buttonHeight,
            width: widget.width ?? MediaQuery.of(context).size.width,
            child: widget.isLoading
                ? SizedBox(
              height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                                color: finalTextColor,
                                strokeWidth: 6,
                              ),
                )
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  color: Colors.transparent,
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      color: widget.textColor ?? Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize:widget.textHeight??  AppConfig.subheadingFontSize,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                if (widget.icon != null) ...[
                  const SizedBox(width: 8.0),
                  Icon(
                    widget.icon,
                    size: 25,
                    color: finalTextColor,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
