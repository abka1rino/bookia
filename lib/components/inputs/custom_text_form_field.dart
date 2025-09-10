import 'package:bookia/core/utils/text_style.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.validator,
    this.controller,
    this.obscureText = false,
  });
  final String labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function(String)? onChanged;
  final String? Function(dynamic)? validator;
  final bool obscureText;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        fillColor: Color(0xffF7F8F9),
        filled: true,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Color(0xffEDF1F6), width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Color(0xffEDF1F6), width: 1.2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Color(0xffEDF1F6), width: 1.2),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        label: Text(
          labelText,
          style: TextStyles.getBody(
            color: Color(0xff8391A1),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
