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

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            pushTo(context, Routes.resetSuccess);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Password should be same'),
                backgroundColor: AppColors.primaryColor,
              ),
            );
          }
        },
        builder: (BuildContext context, AuthState state) {
          return changePasswordBody(context.read<AuthCubit>());
        },
      ),
    );
  }

  SingleChildScrollView changePasswordBody(AuthCubit cubit) {
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
                'Create new password',
                style: TextStyles.getTitle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Gap(15),
              Text(
                'Your new password must be unique from those previously used.',
                style: TextStyles.getBody(
                  fontWeight: FontWeight.w400,
                  color: Color(0xff8391A1),
                ),
              ),
              Gap(35),
              CustomTextFormField(
                labelText: 'New password',
                controller: cubit.passwordController,
                validator: (val) {
                  if (val == null || val == '') {
                    return 'Please enter your new password';
                  } else {
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
              CustomTextFormField(
                labelText: 'Confirm Password',
                controller: cubit.confirmPasswordController,
                validator: (val) {
                  if (val == null || val == '') {
                    return 'Please enter your confirm password';
                  } else {
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
              Gap(35),
              MainButton(
                text: 'Reset Password',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    cubit.changePassword(
                      int.parse(cubit.otpController.text),
                      cubit.passwordController.text,
                      cubit.confirmPasswordController.text,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
