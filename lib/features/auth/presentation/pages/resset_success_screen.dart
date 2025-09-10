import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ResetSuccessScreen extends StatelessWidget {
  const ResetSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppAssets.complete, width: 100, height: 100),
              Gap(20),
              Text(
                'Password Changed!',
                style: TextStyles.getTitle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10),
              Text(
                'Your password has been changed \nsuccessfully.',
                style: TextStyles.getBody(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              Gap(30),
              MainButton(text: 'Back to Login', onPressed: () {
                pushWithReplacement(context, Routes.login);
              })
            ],
          ),
        ),
      ),
    );
  }
}
