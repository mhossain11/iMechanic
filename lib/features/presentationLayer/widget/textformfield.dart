import 'package:flutter/material.dart';

class TextFormFields extends StatelessWidget{
  final TextEditingController controller;
  final String? hint;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final TextInputType keyboardType;
  final BorderSide? enabledBorderSide;
  final BorderSide? focusedBorderSide;
  final String? Function(String?) validators;
  final Widget? suffixIcon;
  final bool? obscureText;
  final Widget? levelText;
  final Color? cursorColor;
  final TextStyle? hintStyle;
  final void Function(String)? onChanged;
  final bool? obscure;
  final String? obscuringCharacter;

  const TextFormFields({super.key, this.hint,  this.minLines,
    this.maxLines, required this.keyboardType, this.enabledBorderSide,
    required this.controller,this.focusedBorderSide, this.maxLength, this.suffixIcon,
    this.obscureText=false, required this.validators, this.levelText, this.cursorColor,
    this.hintStyle, this.onChanged, this.obscuringCharacter, this.obscure, });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      controller: controller,
      maxLength: maxLength,
      minLines: minLines,
      validator: validators,
      obscuringCharacter: '*',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: maxLines,
      keyboardType: keyboardType,
      cursorColor: cursorColor,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: hintStyle,
        label: levelText,
        suffixIcon: suffixIcon,
        //floatingLabelBehavior: FloatingLabelBehavior.always,
        border: const OutlineInputBorder(
            gapPadding: 5,
            borderSide: BorderSide(width:.5)
        ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: .5,
              color:Colors.grey,
            ),

        ),
        /* focusedBorder: const OutlineInputBorder(
            borderSide:  BorderSide(
              width: .5,
              color: Colors.blueAccent,
            ),
        ),*/

        errorBorder: OutlineInputBorder(
          borderSide:  BorderSide(
            width: .5,
            color: Colors.red.shade900,
          ),
        ),
      ),

    );

  }

}