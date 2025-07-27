import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isRequired;
  final int? maxLines;
  final int? maxLength;
  final Widget? suffixIcon;

  const FormTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.isRequired = false,
    this.maxLines = 1,
    this.maxLength,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: isRequired ? '$labelText *' : labelText,
        border: const OutlineInputBorder(),
        suffixIcon: suffixIcon,
      ),
      maxLines: maxLines,
      maxLength: maxLength,
    );
  }
}