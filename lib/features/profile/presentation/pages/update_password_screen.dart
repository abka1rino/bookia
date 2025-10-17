import 'package:bookia/components/app%20bar/app_bar.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/inputs/custom_text_form_field.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class UpdatePasswordScreen extends StatelessWidget {
  UpdatePasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      builder: (BuildContext context, state) {
        var cubit = context.read<ProfileCubit>();
        return Scaffold(
          appBar: AppBarBackSpace(),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
            child: MainButton(
              text: 'Update Password',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  cubit.updatePasswordScreen();
                }
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(60),
                    Text(
                      'New Password',
                      style: TextStyles.getTitle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Gap(40),
                    CustomTextFormField(
                      controller: cubit.currentPasswordController,
                      labelText: 'current Password',
                      validator: (val) {
                        if (val == null || val == '') {
                          return 'Please enter your current password';
                        } else {
                          return null;
                        }
                      },
                      obscureText: cubit.isPasswordHidden,
                      suffixIcon: Transform.flip(
                        flipY: true,
                        child: IconButton(
                          icon: Icon(
                            cubit.isPasswordHidden
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
                    CustomTextFormField(
                      controller: cubit.newPasswordController,
                      labelText: 'New Password',
                      validator: (val) {
                        if (val == null || val == '') {
                          return 'Please enter your new password';
                        } else {
                          return null;
                        }
                      },
                      obscureText: cubit.isPasswordHidden,
                      suffixIcon: Transform.flip(
                        flipY: true,
                        child: IconButton(
                          icon: Icon(
                            cubit.isPasswordHidden
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
                    CustomTextFormField(
                      controller: cubit.confirmPasswordController,
                      labelText: 'Confirm Password',
                      validator: (val) {
                        if (val == null || val == '') {
                          return 'Please enter your confirm password';
                        } else {
                          return null;
                        }
                      },
                       obscureText: cubit.isPasswordHidden,
                      suffixIcon: Transform.flip(
                        flipY: true,
                        child: IconButton(
                          icon: Icon(
                            cubit.isPasswordHidden
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, state) {
        if (state is PasswordChanging) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Center(
              child: Lottie.asset(
                AppAssets.loadingAnimation,
                width: 150,
                height: 150,
              ),
            ),
          );
        }
        if (state is PasswordChanged) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password changed successfully')),
          );
        }
        if (state is PasswordChangedError) {
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
    );
  }
}
