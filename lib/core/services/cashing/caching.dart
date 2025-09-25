import 'dart:convert';

import 'package:bookia/features/auth/data/models/response/auth_response.dart';
import 'package:bookia/features/wishlist/data/models/wish_list_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Caching {
  static late SharedPreferences prefs;
  static String userDataKey = 'userData';
  static String wishListKey = 'wishListData';
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static setData(String key, dynamic val) {
    if (val is String) {
      prefs.setString(key, val);
    } else if (val is int) {
      prefs.setInt(key, val);
    } else if (val is bool) {
      prefs.setBool(key, val);
    } else if (val is double) {
      prefs.setDouble(key, val);
    } else if (val is List<String>) {
      prefs.setStringList(key, val);
    }
  }

  static int? getInt(String key) {
    return prefs.getInt(key);
  }

  static String? getString(String key) {
    return prefs.getString(key);
  }

  static bool? getBool(String key) {
    return prefs.getBool(key);
  }

  static double? getDouble(String key) {
    return prefs.getDouble(key);
  }

  static List<String>? getStringList(String key) {
    return prefs.getStringList(key);
  }

  static remove(String key) {
    prefs.remove(key);
  }

  static setUserData(AuthResponse? response) async {
    if (response == null) return;
    var data = response.toJson();
    String dataString = jsonEncode(data);
    await Caching.setData(Caching.userDataKey, dataString);
  }

  static AuthResponse? getUserData() {
    String? data = Caching.getString(Caching.userDataKey);
    if (data == null) return null;
    Map<String, dynamic> dataString = jsonDecode(data);
    return AuthResponse.fromJson(dataString);
  }

  static setWishListData(WishListResponse? response) async {
    if (response == null) return;
    var data = response.toJson();
    String dataString = jsonEncode(data);
    await Caching.setData(Caching.wishListKey, dataString);
  }

  static WishListResponse? getWishListData() {
    String? data = Caching.getString(Caching.wishListKey);
    if (data == null) return null;
    Map<String, dynamic> dataString = jsonDecode(data);
    return WishListResponse.fromJson(dataString);
  }
}
