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
  final Widget? suffixIcon;
  final bool? obscureText;
  final Widget? levelText;
  final Color? cursorColor;
  final TextStyle? hintStyle;
  final void Function(String)? onChanged;

  const TextFormFields({super.key, required this.hint,  this.minLines,
    this.maxLines, required this.keyboardType, this.enabledBorderSide,
    required this.controller,this.focusedBorderSide, this.maxLength, this.suffixIcon,
    this.obscureText=false, required this.validators, this.levelText, this.cursorColor, this.hintStyle, this.onChanged, });

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
      cursorColor: cursorColor,
      decoration: InputDecoration(
          label: levelText,
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderSide: enabledBorderSide ?? const BorderSide(color: Colors.white),

          ),
          focusedBorder: OutlineInputBorder(
              borderSide: focusedBorderSide ?? const BorderSide(color: Colors.white)
          ),
          hintText: hint,
          hintStyle: hintStyle

      ),

    );

  }

}