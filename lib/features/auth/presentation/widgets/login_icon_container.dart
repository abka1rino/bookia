import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginIconContainer extends StatelessWidget {
  const LoginIconContainer({super.key, required this.icon, required this.onTap});
  final String icon;
  final void Function()onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 105,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffE8ECF4), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: SvgPicture.asset(icon),
          ),
        ),
      ),
    );
  }
}
