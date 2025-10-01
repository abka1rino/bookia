import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/inputs/custom_text_form_field.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extentions/app_regex.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

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
              pushWithReplacement(context, Routes.welcome);
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
      bottomNavigationBar: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
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
                        pushWithReplacement(context,Routes.login);
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
          ],
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
           showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Center(
                child: Lottie.asset(AppAssets.loadingAnimation, width: 150, height: 150),
              ),
            );
          } else if (state is AuthSuccess) {
            Navigator.of(context).pop(); 
            pushUntil(context, Routes.main);
          } else if (state is AuthError) {
            Navigator.of(context).pop(); 
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Registration failed'), backgroundColor: AppColors.primaryColor),
            );
          }
        },
        builder: (BuildContext context, AuthState state) { 
          return registerBody(context);
        },
      ),
    );
  }

  SingleChildScrollView registerBody(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    var formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
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
              CustomTextFormField(labelText: 'Username', controller: cubit.usernameController,validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please enter your username';
                } else if (!AppRegex.username.hasMatch(val)) {
                  return 'Please enter a valid username';
                }

                return null;
              },),
              Gap(12),
              CustomTextFormField(labelText: 'Email', controller: cubit.emailController,validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please enter your email';
                } else if (!AppRegex.email.hasMatch(val)) {
                  return 'Please enter a valid email';
                }
                return null;
              },),
              Gap(12),
              CustomTextFormField(labelText: 'Password', controller: cubit.passwordController,  validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please enter your password';
                } else if (!AppRegex.password.hasMatch(val)) {
                  return 'Please enter a valid password';
                }
                return null;
              },
              obscureText: cubit.isPasswordVisible,
                suffixIcon: Transform.flip(
                  flipY: true,
                  child: IconButton(
                    icon: Icon(
                      cubit.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Color(0xffB1B5C4),
                    ),
                    onPressed: () {
                      cubit.togglePasswordVisibility();
                    },
                  ),
                ),
              ),
              Gap(12),
              CustomTextFormField(labelText: 'Confirm password', controller: cubit.confirmPasswordController, validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please confirm your password';
                }
                if (val != cubit.passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
              obscureText: cubit.isPasswordVisible,
                suffixIcon: Transform.flip(
                  flipY: true,
                  child: IconButton(
                    icon: Icon(
                      cubit.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Color(0xffB1B5C4),
                    ),
                    onPressed: () {
                      cubit.togglePasswordVisibility();
                    },
                  ),
                ),
              ),
              Gap(40),
              MainButton(text: 'Register', onPressed: () {
                if (formKey.currentState!.validate()) {
                  cubit.register(
                    cubit.usernameController.text,
                    cubit.emailController.text,
                    cubit.passwordController.text,
                    cubit.confirmPasswordController.text,
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}