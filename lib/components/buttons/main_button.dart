import 'package:flutter/material.dart';
import 'package:bookia/core/utils/app_colors.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.bgColor,
    this.height = 60,
    this.textColor,
    this.textStyle
  });
  final String text;
  final Function() onPressed;
  final double? height;
  final double? width;
  final Color? bgColor;
  final Color? textColor;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor ?? AppColors.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style:textStyle??TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
