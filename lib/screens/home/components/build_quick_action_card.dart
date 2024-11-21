import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../config/app_config.dart';
import '../home.dart';

class QuickActionTiles extends StatelessWidget {
  const QuickActionTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 4,
      itemCount: functionTileData.length,
      itemBuilder: (BuildContext context, int index) {
        final tile = functionTileData[index];
        return QuickActionCard(
          icon: tile.icon,
          imagePath: tile.imagePath,
          name: tile.name,
          targetPage: tile.targetPage,
          email: tile.email,
        );
      },
      staggeredTileBuilder: (int index) =>
          StaggeredTile.count(2, index.isEven ? 1.9 : 1.4),
      mainAxisSpacing: AppConfig.spaceBetween,
      crossAxisSpacing: AppConfig.spaceBetween,
    );
  }
}

class QuickActionCard extends StatefulWidget {
  final IconData? icon;
  final String? imagePath;
  final String name;
  final VoidCallback? onTap;
  final Widget? targetPage;
  final String? email;

  const QuickActionCard({
    super.key,
    this.icon,
    this.imagePath,
    required this.name,
    this.onTap,
    this.targetPage,
    this.email,
  });

  @override
  QuickActionCardState createState() => QuickActionCardState();
}

class QuickActionCardState extends State<QuickActionCard>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _launchEmail() async {
    if (widget.email != null && widget.email!.isNotEmpty) {
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: widget.email,
        queryParameters: {'subject': 'NeedHelp'},
      );
        await launchUrl(emailUri);
    }
  }

  void _handleTap() {
    _animationController.forward().then((_) async {
      _animationController.reverse();
      await Future.delayed(const Duration(milliseconds: 200));
      if (widget.email != null && widget.email!.isNotEmpty) {
        await _launchEmail();
      } else if (widget.targetPage != null) {
        Get.to(() => widget.targetPage!, transition: Transition.cupertino);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary.withOpacity(.2),
            borderRadius: BorderRadius.circular(AppConfig.borderRadius),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null)
                Icon(
                  widget.icon,
                  color: Theme.of(context).colorScheme.primary,
                  size: AppConfig.mediumIconSize,
                )
              else if (widget.imagePath != null)
                Image.asset(
                  widget.imagePath!,
                  height: AppConfig.mediumIconSize,
                  width: AppConfig.mediumIconSize,
                ),
              const SizedBox(height: 10),
              Text(
                widget.name,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: AppConfig.smallBodyFontSize,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
