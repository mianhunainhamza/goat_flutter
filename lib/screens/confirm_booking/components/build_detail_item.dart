import 'package:flutter/material.dart';

import '../../../config/app_config.dart';

Widget buildDetailItem(BuildContext context,
    {required String label, required String value, required IconData icon}) {
  return Row(
    children: [
      Icon(
        icon,
        size: 30,
        color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
      ),
      const SizedBox(width: 15),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: AppConfig.bodyFontSize,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: AppConfig.bodyFontSize,
                color: Theme.of(context).colorScheme.primary,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ],
  );
}