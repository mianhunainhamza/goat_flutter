import 'package:flutter/material.dart';

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
    final Color finalBackgroundColor = widget.backgroundColor ?? Theme.of(context).colorScheme.onPrimary;
    final Color finalTextColor = widget.textColor ?? Theme.of(context).colorScheme.onSecondary;

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
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            height: widget.height ?? 59,
            width: widget.width ?? MediaQuery.of(context).size.width,
            child: widget.isLoading
                ? CircularProgressIndicator(
              color: finalTextColor,
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  color: Colors.transparent,
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:widget.textHeight??  22,
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
