
class SliderList {
  Data? data;
  String? message;
  List<dynamic>? error;
  int? status;

  SliderList({this.data, this.message, this.error, this.status});

  SliderList.fromJson(Map<String, dynamic> json) {
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

  static List<SliderList> fromList(List<Map<String, dynamic>> list) {
    return list.map(SliderList.fromJson).toList();
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
  List<Sliders>? sliders;

  Data({this.sliders});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["sliders"] is List) {
      sliders = json["sliders"] == null ? null : (json["sliders"] as List).map((e) => Sliders.fromJson(e)).toList();
    }
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(sliders != null) {
      _data["sliders"] = sliders?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Sliders {
  String? image;

  Sliders({this.image});

  Sliders.fromJson(Map<String, dynamic> json) {
    if(json["image"] is String) {
      image = json["image"];
    }
  }

  static List<Sliders> fromList(List<Map<String, dynamic>> list) {
    return list.map(Sliders.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["image"] = image;
    return _data;
  }
}