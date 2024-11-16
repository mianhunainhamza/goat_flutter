import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goat_flutter/config/app_config.dart';
import 'package:goat_flutter/widgets/custom_button.dart';

class CustomConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;

  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CustomConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {

    return Platform.isIOS
        ? CupertinoAlertDialog(
      title: Text(
        title,
        style: TextStyle(
          fontSize: AppConfig.subheadingFontSize,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          message,
          style: TextStyle(
            fontSize: AppConfig.bodyFontSize,
            color: Theme.of(context).colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: () {
            onCancel();
            Navigator.of(context).pop();
          },
          child: Text(cancelText),
        ),
        CupertinoDialogAction(
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          child: Text(confirmText,style: const TextStyle(color: Colors.red),),
        ),
      ],
    )
        : Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 24.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: AppConfig.subheadingFontSize,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppConfig.bodyFontSize,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    onCancel();
                    Navigator.of(context).pop();
                  },
                  child: Text(cancelText),
                ),
                CustomButton(
                  width: 90,
                  onPressed: () {
                    onConfirm();
                  },
                  text: confirmText,
                  tag: '',
                  isLoading: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
