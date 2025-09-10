import 'package:bookia/features/auth/data/models/requests/auth_params.dart';
import 'package:bookia/features/auth/data/repo/auth_repo.dart';
import 'package:flutter/material.dart';

import 'auth_state.dart';
import 'package:bloc/bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool isPasswordVisible = true;
  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      await AuthRepo.login(
        // Assuming AuthParams is a class that takes email and password
        AuthParams(email: email, password: password),
      );
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError());
    }
  }

  Future<void> register(
    String username,
    String email,
    String password,
    String confirmPassword,
  ) async {
    emit(AuthLoading());
    try {
      if (password != confirmPassword) {
        emit(AuthError());
        return;
      }
      await AuthRepo.register(
        AuthParams(
          name: username,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
        ),
      );
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError());
    }
  }

  Future<void> forgetPassword(String email) async {
    emit(AuthLoading());
    try {
      await AuthRepo.forgetPassword(email);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError());
    }
  }

  Future<void> resendForgetPassword(String email) async {
    emit(AuthLoading());
    try {
      await AuthRepo.forgetPassword(email);
      emit(AuthSuccessResend());
    } catch (e) {
      emit(AuthError());
    }
  }

  Future<void> verifyOtp(String email, int otp) async {
    emit(AuthLoading());
    try {
      await AuthRepo.verifyOtp(email, otp);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError());
    }
  }
  Future<void> changePassword(int otpcode, String password, String confirmPassword) async {
    emit(AuthLoading());
    try {
      if (password != confirmPassword) {
        emit(AuthError());
        return;
      }
      await AuthRepo.changePassword(otpcode, password, confirmPassword);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError());
    }
  }
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordVisibilityChanged());
  }
  AuthCubit copyWith() {
    return AuthCubit()
      ..emailController = emailController
      ..passwordController = passwordController
      ..confirmPasswordController = confirmPasswordController
      ..otpController = otpController;
  }
}
