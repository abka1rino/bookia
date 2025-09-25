
import 'package:bookia/features/home/data/models/book%20list/book_list_response.dart';

class WishListResponse {
  Data? data;
  String? message;
  List<dynamic>? error;
  int? status;

  WishListResponse({this.data, this.message, this.error, this.status});

  WishListResponse.fromJson(Map<String, dynamic> json) {
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

  static List<WishListResponse> fromList(List<Map<String, dynamic>> list) {
    return list.map(WishListResponse.fromJson).toList();
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
  int? currentPage;
  List<Data1>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data({this.currentPage, this.data, this.firstPageUrl, this.from, this.lastPage, this.lastPageUrl, this.links, this.nextPageUrl, this.path, this.perPage, this.prevPageUrl, this.to, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["current_page"] is int) {
      currentPage = json["current_page"];
    }
    if(json["data"] is List) {
      data = json["data"] == null ? null : (json["data"] as List).map((e) => Data1.fromJson(e)).toList();
    }
    if(json["first_page_url"] is String) {
      firstPageUrl = json["first_page_url"];
    }
    if(json["from"] is int) {
      from = json["from"];
    }
    if(json["last_page"] is int) {
      lastPage = json["last_page"];
    }
    if(json["last_page_url"] is String) {
      lastPageUrl = json["last_page_url"];
    }
    if(json["links"] is List) {
      links = json["links"] == null ? null : (json["links"] as List).map((e) => Links.fromJson(e)).toList();
    }
    nextPageUrl = json["next_page_url"];
    if(json["path"] is String) {
      path = json["path"];
    }
    if(json["per_page"] is int) {
      perPage = json["per_page"];
    }
    prevPageUrl = json["prev_page_url"];
    if(json["to"] is int) {
      to = json["to"];
    }
    if(json["total"] is int) {
      total = json["total"];
    }
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["current_page"] = currentPage;
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    _data["first_page_url"] = firstPageUrl;
    _data["from"] = from;
    _data["last_page"] = lastPage;
    _data["last_page_url"] = lastPageUrl;
    if(links != null) {
      _data["links"] = links?.map((e) => e.toJson()).toList();
    }
    _data["next_page_url"] = nextPageUrl;
    _data["path"] = path;
    _data["per_page"] = perPage;
    _data["prev_page_url"] = prevPageUrl;
    _data["to"] = to;
    _data["total"] = total;
    return _data;
  }
}

class Links {
  dynamic url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json["url"];
    if(json["label"] is String) {
      label = json["label"];
    }
    if(json["active"] is bool) {
      active = json["active"];
    }
  }

  static List<Links> fromList(List<Map<String, dynamic>> list) {
    return list.map(Links.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["url"] = url;
    _data["label"] = label;
    _data["active"] = active;
    return _data;
  }
}

class Data1 {
  int? id;
  String? name;
  String? price;
  String? category;
  String? image;
  int? discount;
  int? stock;
  String? description;
  int? bestSeller;


  Data1({this.id, this.name, this.price, this.category, this.image, this.discount, this.stock, this.description, this.bestSeller});
  Products toProduct(){
    return Products(
      id: id,
      name: name,
      image: image,
      price: price,
      discount: discount,
      stock: stock,
      description: description,
      bestSeller: bestSeller,
    );
  }
  Data1.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["price"] is String) {
      price = json["price"];
    }
    if(json["category"] is String) {
      category = json["category"];
    }
    if(json["image"] is String) {
      image = json["image"];
    }
    if(json["discount"] is int) {
      discount = json["discount"];
    }
    if(json["stock"] is int) {
      stock = json["stock"];
    }
    if(json["description"] is String) {
      description = json["description"];
    }
    if(json["best_seller"] is int) {
      bestSeller = json["best_seller"];
    }
  }

  static List<Data1> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data1.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["price"] = price;
    _data["category"] = category;
    _data["image"] = image;
    _data["discount"] = discount;
    _data["stock"] = stock;
    _data["description"] = description;
    _data["best_seller"] = bestSeller;
    return _data;
  }
}