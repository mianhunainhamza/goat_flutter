
import 'package:flutter/material.dart';

import '../config/app_config.dart';

class StepTitle extends StatelessWidget {
  final String title;

  const StepTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: AppConfig.headingFontSize,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}