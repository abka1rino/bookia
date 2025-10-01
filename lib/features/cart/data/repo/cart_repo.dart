import 'dart:developer';

import 'package:bookia/core/services/api/api_endpoints.dart';
import 'package:bookia/core/services/api/api_provider.dart';
import 'package:bookia/core/services/cashing/caching.dart';
import 'package:bookia/features/cart/data/models/cart_response.dart';

class CartRepo {
  static Future<CartResponse?> addToCart({required int productId}) async {
    try {
      var res = await ApiProvider.post(
        ApiEndpoints.addToCart,
        data: {"product_id": productId},
        headers: {
          "Authorization": "Bearer ${Caching.getUserData()?.data?.token}",
        },
      );
      if (res.statusCode == 201) {
        return CartResponse.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<CartResponse?> removeFromCart({required int cartItemId}) async {
    try {
      var res = await ApiProvider.post(
        ApiEndpoints.removeFromCart,
        data: {"cart_item_id": cartItemId},
        headers: {
          "Authorization": "Bearer ${Caching.getUserData()?.data?.token}",
        },
      );
      if (res.statusCode == 200) {
        return CartResponse.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<CartResponse?> showCart() async {
    try {
      var res = await ApiProvider.get(
        ApiEndpoints.showCart,
        headers: {
          "Authorization": "Bearer ${Caching.getUserData()?.data?.token}",
        },
      );

      if (res.statusCode == 200) {
        return CartResponse.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<CartResponse?> updateCart({
    required int cartItemId,
    required int quantity,
  }) async {
    try {
      var res = await ApiProvider.post(
        ApiEndpoints.updateCart,
        data: {"cart_item_id": cartItemId, "quantity": quantity},
        headers: {
          "Authorization": "Bearer ${Caching.getUserData()?.data?.token}",
        },
      );
      if (res.statusCode == 201) {
        return CartResponse.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool> checkout() async {
    try {
      var res = await ApiProvider.get(
        ApiEndpoints.checkout,
        headers: {
          "Authorization": "Bearer ${Caching.getUserData()?.data?.token}",
        },
      );
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<bool> placeOrder({
    required int governorateId,
    required String name,
    required String phone,
    required String email,
    required String address,
  }) async {
    try {
      var res = await ApiProvider.post(
        ApiEndpoints.placeOrder,
        data: {
          "governorate_id": governorateId,
          "name": name,
          "phone": phone,
          "address": address,
          "email": email,
        },
        headers: {
          "Authorization": "Bearer ${Caching.getUserData()?.data?.token}",
        },
      );
      if (res.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
