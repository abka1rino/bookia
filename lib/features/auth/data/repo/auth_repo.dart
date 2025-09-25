import 'package:bookia/core/services/api/api_endpoints.dart';
import 'package:bookia/core/services/api/api_provider.dart';
import 'package:bookia/core/services/cashing/caching.dart';
import 'package:bookia/features/auth/data/models/requests/auth_params.dart';
import 'package:bookia/features/auth/data/models/response/auth_response.dart';

class AuthRepo {
  static Future<AuthResponse?> login(AuthParams params) async {
    try {
      var res = await ApiProvider.post(
        ApiEndpoints.login,
        data: params.toJson(),
      );
      if (res.statusCode == 200) {
        AuthResponse? data = AuthResponse.fromJson(res.data);
        await Caching.setUserData(data);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<AuthResponse?> register(AuthParams params) async {
    try {
      var res = await ApiProvider.post(
        ApiEndpoints.register,
        data: params.toJson(),
      );
      if (res.statusCode == 201) {
        AuthResponse? data = AuthResponse.fromJson(res.data);
        await Caching.setUserData(data);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<void> forgetPassword(String email) {
    try {
      return ApiProvider.post(
        ApiEndpoints.forgotPassword,
        data: {'email': email},
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> verifyOtp(String email, int otp) {
    try {
      return ApiProvider.post(
        ApiEndpoints.verifyOtp,
        data: {'email': email, 'verify_code': otp},
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> changePassword(
    int otpcode,
    String password,
    String confirmPassword,
  ) {
    try {
      return ApiProvider.post(
        ApiEndpoints.changePassword,
        data: {
          'verify_code': otpcode,
          'new_password': password,
          'new_password_confirmation': confirmPassword,
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
