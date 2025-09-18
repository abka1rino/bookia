
class BookListResponse {
  Data? data;
  String? message;
  List<dynamic>? error;
  int? status;

  BookListResponse({this.data, this.message, this.error, this.status});

  BookListResponse.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
    message = json["message"];
    error = json["error"] ?? [];
    status = json["status"];
  }

  static List<BookListResponse> fromList(List<Map<String, dynamic>> list) {
    return list.map(BookListResponse.fromJson).toList();
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
  List<Products>? products;
  Meta? meta;
  Links? links;

  Data({this.products, this.meta, this.links});

  Data.fromJson(Map<String, dynamic> json) {
    products = json["products"] == null ? null : (json["products"] as List).map((e) => Products.fromJson(e)).toList();
    meta = json["meta"] == null ? null : Meta.fromJson(json["meta"]);
    links = json["links"] == null ? null : Links.fromJson(json["links"]);
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(products != null) {
      _data["products"] = products?.map((e) => e.toJson()).toList();
    }
    if(meta != null) {
      _data["meta"] = meta?.toJson();
    }
    if(links != null) {
      _data["links"] = links?.toJson();
    }
    return _data;
  }
}

class Links {
  String? first;
  String? last;
  dynamic prev;
  String? next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json["first"];
    last = json["last"];
    prev = json["prev"];
    next = json["next"];
  }

  static List<Links> fromList(List<Map<String, dynamic>> list) {
    return list.map(Links.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["first"] = first;
    _data["last"] = last;
    _data["prev"] = prev;
    _data["next"] = next;
    return _data;
  }
}

class Meta {
  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;

  Meta({this.total, this.perPage, this.currentPage, this.lastPage});

  Meta.fromJson(Map<String, dynamic> json) {
    total = json["total"];
    perPage = json["per_page"];
    currentPage = json["current_page"];
    lastPage = json["last_page"];
  }

  static List<Meta> fromList(List<Map<String, dynamic>> list) {
    return list.map(Meta.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["total"] = total;
    _data["per_page"] = perPage;
    _data["current_page"] = currentPage;
    _data["last_page"] = lastPage;
    return _data;
  }
}

class Products {
  int? id;
  String? name;
  String? description;
  String? price;
  int? discount;
  double? priceAfterDiscount;
  int? stock;
  int? bestSeller;
  String? image;
  String? category;

  Products({this.id, this.name, this.description, this.price, this.discount, this.priceAfterDiscount, this.stock, this.bestSeller, this.image, this.category});

  Products.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    price = json["price"];
    discount = json["discount"];
    priceAfterDiscount = json["price_after_discount"];
    stock = json["stock"];
    bestSeller = json["best_seller"];
    image = json["image"];
    category = json["category"];
  }

  static List<Products> fromList(List<Map<String, dynamic>> list) {
    return list.map(Products.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["description"] = description;
    _data["price"] = price;
    _data["discount"] = discount;
    _data["price_after_discount"] = priceAfterDiscount;
    _data["stock"] = stock;
    _data["best_seller"] = bestSeller;
    _data["image"] = image;
    _data["category"] = category;
    return _data;
  }
}