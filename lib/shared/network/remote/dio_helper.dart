import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = init();

  static init() {
    return Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    String lang = 'en',
    String? token,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token
    };

    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> PostData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
    required Map<String, dynamic> data,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? ""
    };
    return await dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> PUTData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
    required Map<String, dynamic> data,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? ""
    };
    return await dio.put(url, queryParameters: query, data: data);
  }
}
