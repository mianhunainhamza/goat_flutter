import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Icon? prefixIcon;
  final IconButton? suffixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.obscureText,
    required this.keyboardType,
    required this.validator,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(.3),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary,
          ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          prefixIcon: prefixIcon,
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 17,
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(.3),
          ),
          suffixIcon: suffixIcon,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        ),
      ),
    );
  }
}
