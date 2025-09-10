import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

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
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            pushTo(context, Routes.changePassword, extra: context.read<AuthCubit>().copyWith());
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Wrong OTP'),
                backgroundColor: AppColors.primaryColor,
              ),
            );
          }else if (state is AuthSuccessResend) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('OTP Resent Successfully'),
                backgroundColor: AppColors.primaryColor,
              ),
            );
          }
        },
        child: forgetPasswordBody(context.read<AuthCubit>()),
      ),
      bottomNavigationBar: resendOtp(context),
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
                'OTP Verification',
                style: TextStyles.getTitle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Gap(15),
              Text(
                'Enter the verification code we just sent on your email address.',
                style: TextStyles.getBody(
                  fontWeight: FontWeight.w400,
                  color: Color(0xff8391A1),
                ),
              ),
              Gap(35),
              Center(
                child: Pinput(
                  length: 6,

                  defaultPinTheme: PinTheme(
                    width: 70,
                    height: 60,
                    textStyle: TextStyles.getTitle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff24282C),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffF7F8F9),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Color(0xffEDF1F6), width: 1.2),
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                    width: 70,
                    height: 60,
                    textStyle: TextStyles.getTitle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff24282C),
                    ),

                    decoration: BoxDecoration(
                      color: Color(0xffF7F8F9),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 1.2,
                      ),
                    ),
                  ),
                  errorPinTheme: PinTheme(
                    width: 70,
                    height: 60,
                    textStyle: TextStyles.getTitle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff24282C),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffF7F8F9),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red, width: 1.2),
                    ),
                  ),
                  onChanged: (value) {},
                  controller: cubit.otpController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the OTP';
                    } else if (value.length < 6) {
                      return 'OTP must be 6 digits';
                    }
                    return null;
                  },
                ),
              ),
              Gap(35),
              MainButton(
                text: 'Verify',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    cubit.verifyOtp(
                      cubit.emailController.text,
                      int.parse(cubit.otpController.text),
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

  SafeArea resendOtp(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Text(
                    'Didn\'t receive the code?',
                    style: TextStyles.getBody(
                      fontWeight: FontWeight.w400,
                      color: Color(0xff24282C),
                    ),
                  ),
                ),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () {
                      cubit.resendForgetPassword(cubit.emailController.text);
                    },
                    child: Text(
                      ' Resend',
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
