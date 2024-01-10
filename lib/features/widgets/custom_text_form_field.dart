import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscure, isReadOnly;
  final InputDecoration decoration;
  final TextInputType? inputType;
  final Function(String?) validator;
  final List<String>? autofillHints;
  final Color? cursorColor;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.validator,
    required this.decoration,
    this.inputType,
    this.isReadOnly = false,
    this.obscure = false,
    this.autofillHints,
    this.cursorColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontSize: 14, letterSpacing: 1),
      controller: controller,
      cursorColor: cursorColor,
      maxLines: 1,
      autofillHints: autofillHints,
      obscureText: obscure,
      readOnly: isReadOnly,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (_) => validator(_),
      decoration: decoration,
      keyboardType: inputType,
    );
  }
}
