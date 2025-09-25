import 'dart:developer';

import 'package:bookia/core/services/api/api_endpoints.dart';
import 'package:bookia/core/services/api/api_provider.dart';
import 'package:bookia/core/services/cashing/caching.dart';
import 'package:bookia/features/wishlist/data/models/wish_list_response.dart';

class WishListRepo {
  static Future<WishListResponse?> addToWishList({
    required int productId,
  }) async {
    try {
      var res = await ApiProvider.post(
        ApiEndpoints.addToWishlist,
        data: {"product_id": productId},
        headers: {
          "Authorization": "Bearer ${Caching.getUserData()?.data?.token}",
        },
      );
      if (res.statusCode == 200) {
        Caching.setWishListData(WishListResponse.fromJson(res.data));
        return WishListResponse.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<WishListResponse?> removeFromWishList({
    required int productId,
  }) async {
    try {
      var res = await ApiProvider.post(
        ApiEndpoints.removeFromWishlist,
        data: {"product_id": productId},
        headers: {
          "Authorization": "Bearer ${Caching.getUserData()?.data?.token}",
        },
      );
      if (res.statusCode == 200) {
        Caching.setWishListData(WishListResponse.fromJson(res.data));
        return WishListResponse.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<WishListResponse?> addRemoveFromWishList({
    required int productId,
  }) async {
    var wishList = Caching.getWishListData()?.data?.data;
    bool isInWishList = wishList?.any((item) => item.id == productId) ?? false;
    try {
      var res = await ApiProvider.post(
        isInWishList
            ? ApiEndpoints.removeFromWishlist
            : ApiEndpoints.addToWishlist,
        data: {"product_id": productId},
        headers: {
          "Authorization": "Bearer ${Caching.getUserData()?.data?.token}",
        },
      );
      if (res.statusCode == 200) {
        Caching.setWishListData(WishListResponse.fromJson(res.data));
        return WishListResponse.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<WishListResponse?> showWishList() async {
    try {
      var res = await ApiProvider.get(
        ApiEndpoints.showWishlist,
        headers: {
          "Authorization": "Bearer ${Caching.getUserData()?.data?.token}",
        },
      );
     
      if (res.statusCode == 200) {
        Caching.setWishListData(WishListResponse.fromJson(res.data));
        return WishListResponse.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) { 
      log(e.toString());
      return null;
    }
  }
}
