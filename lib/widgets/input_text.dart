import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final bool obscureText, borderEnabled;
  final double fontSize;
  final void Function(String text) onChanged;
  final String? Function(String? text) validator;

  const InputText({
    super.key,
    this.label = '',
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.borderEnabled = true,
    this.fontSize = 15,
    required this.onChanged,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
      style: TextStyle(fontSize: fontSize),
      decoration: InputDecoration(
          labelText: label,
          contentPadding: const EdgeInsets.symmetric(vertical: 5),
          enabledBorder: borderEnabled
              ? const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black26))
              : InputBorder.none,
          border: borderEnabled ? null : InputBorder.none,
          labelStyle: const TextStyle(
              color: Colors.black45, fontWeight: FontWeight.w500)),
    );
  }
}
