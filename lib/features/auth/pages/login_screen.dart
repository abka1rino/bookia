import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/inputs/custom_text_form_field.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extentions/navigation.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/auth/pages/register_screen.dart';
import 'package:bookia/features/auth/widgets/login_icon_container.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffE8ECF4), width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(Icons.arrow_back_ios_new),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back! Glad \nto see you, Again!',
              style: TextStyles.getTitle(
                fontSize: 30,
                fontWeight: FontWeight.w400,
              ),
            ),
            Gap(35),
            CustomTextFormField(labelText: 'Enter your email'),
            Gap(15),
            CustomTextFormField(labelText: 'Enter your password'),
            Gap(60),
            MainButton(text: 'Login', onPressed: () {}),
            Gap(35),
            Row(
              children: [
                Expanded(
                  child: Divider(color: Color(0xffE8ECF4), endIndent: 18),
                ),
                Text(
                  'Or Login with',
                  style: TextStyles.getSmall(fontWeight: FontWeight.w400),
                ),
                Expanded(child: Divider(color: Color(0xffE8ECF4), indent: 18)),
              ],
            ),
            Gap(30),
            Row(
              spacing: 10,
              children: [
                LoginIconContainer(icon: AppAssets.facebookLogo, onTap: () {}),
                LoginIconContainer(icon: AppAssets.googleLogo, onTap: () {}),
                LoginIconContainer(icon: AppAssets.appleLogo, onTap: () {}),
              ],
            ),
            Expanded(child: Gap(10)),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Text(
                        'Don’t have an account?',
                        style: TextStyles.getBody(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff24282C),
                        ),
                      ),
                    ),
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () {
                          pushWithReplacement(context, RegisterScreen());
                        },
                        child: Text(
                          ' Register Now',
                          style: TextStyles.getBody(
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(15),
          ],
        ),
      ),
    );
  }
}
