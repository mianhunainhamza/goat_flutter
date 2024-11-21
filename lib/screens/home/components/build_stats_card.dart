import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../../config/app_config.dart';
import '../home.dart';

class StatsTiles extends StatelessWidget {
  const StatsTiles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: taskProgressList.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) => Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(AppConfig.borderRadius),
        ),
        color:
        Theme.of(context).colorScheme.tertiary.withOpacity(.8),
        child: StatsCard(
          status: taskProgressList[index].status.toInt(),
          title: taskProgressList[index].title,
        ),
      ),
      staggeredTileBuilder: (int index) =>
          StaggeredTile.count(2, index.isEven ? 1.9 : 1.4),
      mainAxisSpacing: AppConfig.spaceBetween / 2,
      crossAxisSpacing: AppConfig.spaceBetween / 2,
    );
  }
}

class StatsCard extends StatefulWidget {
  final int status;
  final String title;

  const StatsCard({
    super.key,
    required this.status,
    required this.title,
  });

  @override
  StatsCardState createState() => StatsCardState();
}

class StatsCardState extends State<StatsCard> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _shakeAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.1, 0),
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticInOut),
    );
  }

  void _triggerShake() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _triggerShake,
      child: SlideTransition(
        position: _shakeAnimation,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.status.toString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: AppConfig.headingFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: AppConfig.bodyFontSize,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}