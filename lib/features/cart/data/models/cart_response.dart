
import 'package:bookia/features/home/data/models/book%20list/book_list_response.dart';

class CartResponse {
  Data? data;
  String? message;
  List<dynamic>? error;
  int? status;

  CartResponse({this.data, this.message, this.error, this.status});

  CartResponse.fromJson(Map<String, dynamic> json) {
    if(json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
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

  static List<CartResponse> fromList(List<Map<String, dynamic>> list) {
    return list.map(CartResponse.fromJson).toList();
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

class Data {
  int? id;
  User? user;
  String? total;
  List<CartItems>? cartItems;

  Data({this.id, this.user, this.total, this.cartItems});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["user"] is Map) {
      user = json["user"] == null ? null : User.fromJson(json["user"]);
    }
    if(json["total"] is String) {
      total = json["total"];
    }
    if(json["cart_items"] is List) {
      cartItems = json["cart_items"] == null ? null : (json["cart_items"] as List).map((e) => CartItems.fromJson(e)).toList();
    }
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    if(user != null) {
      _data["user"] = user?.toJson();
    }
    _data["total"] = total;
    if(cartItems != null) {
      _data["cart_items"] = cartItems?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class CartItems {
  int? itemId;
  int? itemProductId;
  String? itemProductName;
  String? itemProductImage;
  String? itemProductPrice;
  int? itemProductDiscount;
  double? itemProductPriceAfterDiscount;
  int? itemProductStock;
  int? itemQuantity;
  double? itemTotal;

  CartItems({this.itemId, this.itemProductId, this.itemProductName, this.itemProductImage, this.itemProductPrice, this.itemProductDiscount, this.itemProductPriceAfterDiscount, this.itemProductStock, this.itemQuantity, this.itemTotal});
  Products toProduct(){
    return Products(
      id: itemProductId,
      name: itemProductName,
      image: itemProductImage,
      price: itemProductPrice,
      discount: itemProductDiscount,
      priceAfterDiscount: itemProductPriceAfterDiscount,
      stock: itemProductStock,
    );
  }
  CartItems.fromJson(Map<String, dynamic> json) {
    if(json["item_id"] is int) {
      itemId = json["item_id"];
    }
    if(json["item_product_id"] is int) {
      itemProductId = json["item_product_id"];
    }
    if(json["item_product_name"] is String) {
      itemProductName = json["item_product_name"];
    }
    if(json["item_product_image"] is String) {
      itemProductImage = json["item_product_image"];
    }
    if(json["item_product_price"] is String) {
      itemProductPrice = json["item_product_price"];
    }
    if(json["item_product_discount"] is int) {
      itemProductDiscount = json["item_product_discount"];
    }
    if(json["item_product_price_after_discount"] is double) {
      itemProductPriceAfterDiscount = json["item_product_price_after_discount"];
    }
    if(json["item_product_stock"] is int) {
      itemProductStock = json["item_product_stock"];
    }
    if(json["item_quantity"] is int) {
      itemQuantity = json["item_quantity"];
    }
    if(json["item_total"] is double) {
      itemTotal = json["item_total"];
    }
  }

  static List<CartItems> fromList(List<Map<String, dynamic>> list) {
    return list.map(CartItems.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["item_id"] = itemId;
    _data["item_product_id"] = itemProductId;
    _data["item_product_name"] = itemProductName;
    _data["item_product_image"] = itemProductImage;
    _data["item_product_price"] = itemProductPrice;
    _data["item_product_discount"] = itemProductDiscount;
    _data["item_product_price_after_discount"] = itemProductPriceAfterDiscount;
    _data["item_product_stock"] = itemProductStock;
    _data["item_quantity"] = itemQuantity;
    _data["item_total"] = itemTotal;
    return _data;
  }
}

class User {
  int? userId;
  String? userName;

  User({this.userId, this.userName});

  User.fromJson(Map<String, dynamic> json) {
    if(json["user_id"] is int) {
      userId = json["user_id"];
    }
    if(json["user_name"] is String) {
      userName = json["user_name"];
    }
  }

  static List<User> fromList(List<Map<String, dynamic>> list) {
    return list.map(User.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["user_id"] = userId;
    _data["user_name"] = userName;
    return _data;
  }
}