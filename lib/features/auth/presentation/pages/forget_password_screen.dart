
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/inputs/custom_text_form_field.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: GestureDetector(
            onTap: () {
              pop(context);
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
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            pushTo(context, Routes.otp, extra: cubit.copyWith());
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Wrong email'),backgroundColor: AppColors.primaryColor,),
            );
          }
        },
        child: forgetPasswordBody(cubit),
      ),
      bottomNavigationBar: navigateToSignUp(context),
    );
  }

  SingleChildScrollView forgetPasswordBody(AuthCubit cubit) {
    var formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
    child: Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Forget Password?',
              style: TextStyles.getTitle(
                fontSize: 30,
                fontWeight: FontWeight.w400,
              ),
            ),
            Gap(15),
            Text(
              'Don’t worry! It occurs. Please enter the email address linked with your account.',
              style: TextStyles.getBody(
                fontWeight: FontWeight.w400,
                color: Color(0xff8391A1),
              ),
            ),
            Gap(35),
            CustomTextFormField(
              labelText: 'Enter your email',
              controller: cubit.emailController,
              validator: (val) {
                if (val == null || val == '') {
                  return 'Please enter your email';
                }else{
                  return null;
                }
              },
            ),
            Gap(35),
            MainButton(text: 'Send Code', onPressed: () {
              if(formKey.currentState!.validate()){
                cubit.forgetPassword(cubit.emailController.text);
              }
            }),
          ],
        ),
      ),
    ),
  );
  }

  SafeArea navigateToSignUp(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Text(
                    'Remember Password?',
                    style: TextStyles.getBody(
                      fontWeight: FontWeight.w400,
                      color: Color(0xff24282C),
                    ),
                  ),
                ),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () {
                      pop(context);
                    },
                    child: Text(
                      ' Login',
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
        ],
      ),
    );
  }
}
