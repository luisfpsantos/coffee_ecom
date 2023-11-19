import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String? value)? validator;
  const AppInput({
    super.key,
    required this.label,
    this.validator,
    required this.keyboardType,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        label: Text(label, style: const TextStyle(color: Colors.white)),
        filled: true,
        fillColor: const Color(0xff100708).withOpacity(0.2),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xff100708)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
