import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/inputs/custom_text_form_field.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/services/cashing/caching.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      builder: (BuildContext context, state) {
        print(Caching.getUserData()?.data?.user);
        var cubit = context.read<ProfileCubit>();
        return Scaffold(
          appBar: AppBar(
            leading: Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffE8ECF4), width: 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(Icons.arrow_back_ios_new),
              ),
            ),
          ),
          title: Text(
            'Edit Profile',
            style: TextStyles.getTitle(fontSize: 24, fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
          child: MainButton(text: 'Update Profile', onPressed: () {
            if (formKey.currentState!.validate()) {
              cubit.updateProfile();
            }
          }),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(AppAssets.welcome),
                      radius: 80,
                    ),
                  ),
                  Gap(30),
                  CustomTextFormField(
                    controller: cubit.nameController,
                    labelText: 'Full Name',
                    validator: (val) {
                      if (val == null || val == '') {
                        return 'Please enter your full name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Gap(15),
                  CustomTextFormField(
                    controller: cubit.addressController,
                    labelText: 'Address',
                    validator: (val) {
                      if (val == null || val == '') {
                        return 'Please enter your address';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Gap(15),
                  CustomTextFormField(
                    controller: cubit.phoneController,
                    labelText: 'Phone',
                    validator: (val) {
                      if (val == null || val == '') {
                        return 'Please enter your phone number';
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      },
      listener: (BuildContext context, state) {
        if (state is ProfileUpdating) {
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
        if (state is ProfileUpdated) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Profile updated successfully'),
            ),
          );
        }
        if (state is ProfileUpdateError) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
    );
  }
}
