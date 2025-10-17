import 'package:bookia/core/services/api/api_endpoints.dart';
import 'package:bookia/core/services/api/api_provider.dart';
import 'package:bookia/core/services/cashing/caching.dart';
import 'package:bookia/features/profile/data/models/update_profile_model.dart';

class ProfileRepo{
  static Future<UpdateProfileModel?> updateProfile({
    required String name,
    required String phone,
    required String address,
  }) async {
    try {
      var response = await ApiProvider.post(
        ApiEndpoints.updateUserProfile,
        headers: {
          "Authorization": "Bearer ${Caching.getUserData()?.data?.token}",
        },
        data: {
          'name': name,
          'address': address,
          'phone': phone,
        },
      );
      return UpdateProfileModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
  static Future<bool> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      var response = await ApiProvider.post(
        ApiEndpoints.updateUserPassword,
        headers: {
          "Authorization": "Bearer ${Caching.getUserData()?.data?.token}",
        },
        data: {
          'current_password': currentPassword,
          'new_password': newPassword,
          'new_password_confirmation': confirmPassword,
        },
      );
      if(response.statusCode == 200){
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

}