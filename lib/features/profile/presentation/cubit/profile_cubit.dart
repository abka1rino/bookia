import 'package:bookia/core/services/cashing/caching.dart';
import 'package:bookia/features/profile/data/repo/profile_repo.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  var data = Caching.getUserData();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isPasswordHidden = true;
  initData() {
    nameController.text = data?.data?.user?.name ?? '';
    phoneController.text = data?.data?.user?.phone ?? '';
    addressController.text = data?.data?.user?.address ?? '';
  }

  Future<void> updateProfile() async {
    emit(ProfileUpdating());
    try {
      var res = await ProfileRepo.updateProfile(
        name: nameController.text,
        phone: phoneController.text,
        address: addressController.text,
      );
      if (res != null) {
        data?.data?.user?.name = nameController.text;
        data?.data?.user?.phone = phoneController.text;
        data?.data?.user?.address = addressController.text;
        Caching.setUserData(data);
        emit(ProfileUpdated());
      } else {
        emit(ProfileUpdateError("Failed to update profile"));
      }
    } catch (e) {
      emit(ProfileUpdateError("Failed to update profile"));
    }
  }

  Future<void> updatePasswordScreen() async {
    emit(PasswordChanging());
    try {
      var res = await ProfileRepo.updatePassword(
        currentPassword: currentPasswordController.text,
        newPassword: newPasswordController.text,
        confirmPassword: confirmPasswordController.text,
      );
      if (res) {
        emit(PasswordChanged());
      } else {
        emit(PasswordChangedError("Failed to update password"));
      }
    } catch (e) {
      emit(PasswordChangedError("Failed to update password"));
    }
  }

  void togglePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    emit(PasswordVisibilityChanged());
  }
}
