
import 'package:bookia/features/auth/data/models/response/auth_response.dart';

class UpdateProfileModel {
  AuthResponse? data;
  String? message;
  List<dynamic>? error;
  int? status;

  UpdateProfileModel({this.data, this.message, this.error, this.status});

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    if(json["data"] is Map) {
      data = json["data"] == null ? null : AuthResponse.fromJson(json["data"]);
    }
    if(json["message"] is String) {
      message = json["message"];
    }
    if(json["error"] is List) {
      error = json["error"] ?? [];
    }
    if(json["status"] is int) {
      status = json["status"];
    }
  }

  static List<UpdateProfileModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(UpdateProfileModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(data != null) {
      _data["data"] = data?.toJson();
    }
    _data["message"] = message;
    if(error != null) {
      _data["error"] = error;
    }
    _data["status"] = status;
    return _data;
  }
}
