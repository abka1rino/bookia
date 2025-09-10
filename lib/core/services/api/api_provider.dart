import 'package:bookia/core/services/api/api_endpoints.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  static late Dio dio = Dio();

  static void init() {
    dio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
  }

  static Future<Response> post(String endpoint, {Map<String, dynamic>? data, 
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,}) async {
  
      return await dio.post(endpoint, data: data, queryParameters: queryParameters, options: Options(headers: headers));
   
  }

  static Future<Response> get(String endpoint,{Map<String, dynamic>? data, 
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,}) async {
   
      return await dio.get(endpoint, queryParameters: queryParameters, options: Options(headers: headers));
    
  }
  static Future<Response> put(String endpoint,{Map<String, dynamic>? data, 
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,}) async {
 
      return await dio.put(endpoint, data: data, queryParameters: queryParameters, options: Options(headers: headers));
   
  }
  static Future<Response> delete(String endpoint,{Map<String, dynamic>? data, 
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,}) async {
    
      return await dio.delete(endpoint, data: data, queryParameters: queryParameters, options: Options(headers: headers));
    }


}
