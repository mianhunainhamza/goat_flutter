import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../config/app_config.dart';

class BookTeeTimeCard extends StatefulWidget {
  final Widget targetScreen;
  final String? tag;

  const BookTeeTimeCard({super.key, required this.targetScreen, this.tag});

  @override
  BookTeeTimeCardState createState() => BookTeeTimeCardState();
}

class BookTeeTimeCardState extends State<BookTeeTimeCard>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  void _triggerTransition() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      Get.to(() => widget.targetScreen, transition: Transition.cupertino);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _triggerTransition,
      child: AnimatedBuilder(
        animation: _offsetAnimation,
        builder: (context, child) {
          return SlideTransition(
            position: _offsetAnimation,
            child: child,
          );
        },
        child: Container(
          height: 150,
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary.withOpacity(.9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Book Tee Time",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: AppConfig.headingFontSize,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Ready to play?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: AppConfig.bodyFontSize,
                    ),
                  ),
                ],
              ),
              Hero(
                tag: widget.tag ?? 'notDefined',
                child: Icon(
                  Ionicons.arrow_forward_circle,
                  size: 50,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
