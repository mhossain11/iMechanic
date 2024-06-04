import 'package:flutter/material.dart';

class TextFormFields extends StatelessWidget{
  final TextEditingController controller;
  final String hint;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final TextInputType keyboardType;
  final BorderSide? enabledBorderSide;
  final BorderSide? focusedBorderSide;
  final String? Function(String) validators;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final bool? obscureText;
  final bool? filled;

  const TextFormFields({super.key, required this.hint,  this.minLines,
     this.maxLines, required this.keyboardType, this.enabledBorderSide,
    required this.controller,this.focusedBorderSide, this.maxLength, this.suffixIcon,
    this.obscureText=false, required this.validators, this.onChanged, this.filled, });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: obscureText!,
      controller: controller,
      maxLength: maxLength,
      minLines: minLines,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: false ?? filled,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
            borderSide: enabledBorderSide ?? const BorderSide()
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: focusedBorderSide ?? const BorderSide()
        ),
        hintText: hint,

      ),

    );

  }

}