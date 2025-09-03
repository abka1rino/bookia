import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/inputs/custom_text_form_field.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extentions/navigation.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/auth/pages/login_screen.dart';
import 'package:bookia/features/auth/widgets/login_icon_container.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
              'Hello! Register to get started',
              style: TextStyles.getTitle(
                fontSize: 30,
                fontWeight: FontWeight.w400,
              ),
            ),
            Gap(35),
            CustomTextFormField(labelText: 'Username'),
            Gap(12),
            CustomTextFormField(labelText: 'Email'),
            Gap(12),
            CustomTextFormField(labelText: 'Password'),
            Gap(12),
            CustomTextFormField(labelText: 'Confirm password'),
            Gap(40),
            MainButton(text: 'Register', onPressed: () {}),
            Expanded(child: Gap(10)),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Text(
                        'Already have an account?',
                        style: TextStyles.getBody(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff24282C),
                        ),
                      ),
                    ),
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () {
                          pushWithReplacement(context, LoginScreen());
                        },
                        child: Text(
                          ' Login Now',
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