import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/inputs/custom_text_form_field.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/features/auth/presentation/widgets/login_icon_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: navigateToSignUp(context),
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
          } else if (AuthState is AuthSuccess) {
            Navigator.of(context).pop(); 
            pushUntil(context, Routes.home);
            
          } else if (AuthState is AuthError) {
            Navigator.of(context).pop(); 
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Wrong email or password'),backgroundColor: AppColors.primaryColor,),
            );
          }
        },
        builder: (BuildContext context, AuthState state) {
          return loginBody(context);
        },
      ),
    );
  }

  SingleChildScrollView loginBody(BuildContext context) {
    var cubit = context.read<AuthCubit>();
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
                'Welcome back! Glad \nto see you, Again!',
                style: TextStyles.getTitle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
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
              Gap(15),
              CustomTextFormField(
                labelText: 'Enter your password',
                controller: cubit.passwordController,
                validator: (val) {
                  if (val == null || val == '') {
                    return 'Please enter your password';
                  }else{
                    return null;
                  }
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
              Gap(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      pushTo(context, Routes.forgetPassword);
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyles.getBody(
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              Gap(25),
              MainButton(text: 'Login', onPressed: () {
                if(formKey.currentState!.validate()){
                  cubit.signIn(cubit.emailController.text, cubit.passwordController.text);
                }
              }),
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
                  Expanded(
                    child: Divider(color: Color(0xffE8ECF4), indent: 18),
                  ),
                ],
              ),
              Gap(30),
              Row(
                spacing: 10,
                children: [
                  LoginIconContainer(
                    icon: AppAssets.facebookLogo,
                    onTap: () {},
                  ),
                  LoginIconContainer(icon: AppAssets.googleLogo, onTap: () {}),
                  LoginIconContainer(icon: AppAssets.appleLogo, onTap: () {}),
                ],
              ),
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
                      pushWithReplacement(context, Routes.register);
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
        ],
      ),
    );
  }
}
