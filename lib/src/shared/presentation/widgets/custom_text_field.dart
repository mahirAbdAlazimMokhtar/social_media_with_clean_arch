import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    this.errorText,
    this.textInputType = TextInputType.text,
    this.onChanged,
    this.obscureText = false,
  });
  final String labelText;
  final String? errorText;
  final TextInputType textInputType;
  final Function(String)? onChanged;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      keyboardType: textInputType,
      obscureText: obscureText,
      style:
          Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }
}
