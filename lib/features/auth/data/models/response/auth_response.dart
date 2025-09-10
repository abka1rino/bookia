class AuthResponse {
  Data? data;
  String? message;
  List<dynamic>? error;
  int? status;

  AuthResponse({this.data, this.message, this.error, this.status});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    if (json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["error"] is List) {
      error = json["error"] ?? [];
    }
    if (json["status"] is int) {
      status = json["status"];
    }
  }

  static List<AuthResponse> fromList(List<Map<String, dynamic>> list) {
    return list.map(AuthResponse.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    _data["message"] = message;
    if (error != null) {
      _data["error"] = error;
    }
    _data["status"] = status;
    return _data;
  }
}

class Data {
  User? user;
  String? token;

  Data({this.user, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["user"] is Map) {
      user = json["user"] == null ? null : User.fromJson(json["user"]);
    }
    if (json["token"] is String) {
      token = json["token"];
    }
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    _data["token"] = token;
    return _data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  dynamic address;
  dynamic city;
  dynamic phone;
  bool? emailVerified;
  String? image;

  User({
    this.id,
    this.name,
    this.email,
    this.address,
    this.city,
    this.phone,
    this.emailVerified,
    this.image,
  });

  User.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    address = json["address"];
    city = json["city"];
    phone = json["phone"];
    if (json["email_verified"] is bool) {
      emailVerified = json["email_verified"];
    }
    if (json["image"] is String) {
      image = json["image"];
    }
  }

  static List<User> fromList(List<Map<String, dynamic>> list) {
    return list.map(User.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["email"] = email;
    _data["address"] = address;
    _data["city"] = city;
    _data["phone"] = phone;
    _data["email_verified"] = emailVerified;
    _data["image"] = image;
    return _data;
  }
}
