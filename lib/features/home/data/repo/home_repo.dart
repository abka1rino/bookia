import 'package:bookia/core/services/api/api_provider.dart';
import 'package:bookia/features/home/data/models/book%20list/book_list_response.dart';
import 'package:bookia/features/home/data/models/slider/slider_list.dart';

class HomeRepo {
  static Future<BookListResponse?> getProducts(String endPoint) async {
    try {
      var res = await ApiProvider.get(
        endPoint,
      );
      if (res.statusCode == 200) {
        BookListResponse? data = BookListResponse.fromJson(res.data);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  static Future<SliderList?> getSliders(String endPoint) async {
    try {
      var res = await ApiProvider.get(
        endPoint,
      );
      if (res.statusCode == 200) {
        SliderList? data = SliderList.fromJson(res.data);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}