import 'package:flutter/material.dart';
class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5,top: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context)
              .colorScheme
              .primary
              .withOpacity(.1)),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).colorScheme.primary.withOpacity(1),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
