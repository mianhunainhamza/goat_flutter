import 'package:flutter/material.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String labelText;
  final T? value;
  final List<T> items;
  final void Function(T?)? onChanged;

  const CustomDropdownField({
    super.key,
    required this.labelText,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: DropdownButtonFormField<T>(
        value: value,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(.3)),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 17,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          ),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        ),
        items: items
            .map((item) => DropdownMenuItem<T>(
          value: item,
          child: Text(item.toString()),
        ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
