import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BallAnimation extends StatefulWidget {
  final double ballSize;
  const BallAnimation({super.key, required this.ballSize});

  @override
  BallAnimationState createState() => BallAnimationState();
}

class BallAnimationState extends State<BallAnimation> with TickerProviderStateMixin {
  late AnimationController _controller;
  late double ballX, ballY;
  late double velocityX, velocityY;
  // late Color ballColor;
  late double scaleValue;

  @override
  void initState() {
    super.initState();
    _initializeBallPosition();
    _initializeAnimation();
  }

  void _initializeBallPosition() {
    ballX = Get.width / 2 - widget.ballSize / 2;
    ballY = Get.height / 2 - widget.ballSize / 2;
    velocityX = 3.0 * (Random().nextBool() ? 1 : -1);
    velocityY = 3.0 * (Random().nextBool() ? 1 : -1);
    // ballColor = Colors.white;
    scaleValue = 1.0;
  }

  void _initializeAnimation() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 16),
      vsync: this,
    )..addListener(() {
      setState(() {
        ballX += velocityX;
        ballY += velocityY;

        if (ballX <= 0 || ballX >= Get.width - widget.ballSize) {
          velocityX = -velocityX + (Random().nextDouble() * 2 - 1);
          _applyBounceEffect();
        }

        if (ballY <= 0 || ballY >= Get.height - widget.ballSize) {
          velocityY = -velocityY + (Random().nextDouble() * 2 - 1);
          _applyBounceEffect();
        }
      });
    });

    _controller.repeat();
  }

  void _applyBounceEffect() {
    setState(() {
      // ballColor = Theme.of(context).colorScheme.primary;

      scaleValue = 1.2;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        // ballColor = Colors.white;
        scaleValue = 1.0;
      });
    });
  }

  void resetBallPosition() {
    setState(() {
      _initializeBallPosition();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: ballX,
      top: ballY,
      child: Transform.scale(
        scale: scaleValue,
        child: Container(
          width: widget.ballSize,
          height: widget.ballSize,
          decoration: const BoxDecoration(
            // color: ballColor,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/golf_ball.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
