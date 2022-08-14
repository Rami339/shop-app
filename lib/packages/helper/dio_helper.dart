import 'package:dio/dio.dart';
import '../constants/constants.dart';

class DioHelper {
  static late Dio dio;

  static init() async {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'lang': defaultLangData,
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> getData({
    String? token,
    Map<String, dynamic>? query,
    required String url,
  }) async {
    dio.options.headers = {
      'lang': defaultLangData,
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> putData({
    String? token,
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      'lang': defaultLangData,
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return dio.put(
      queryParameters: query,
      url,
      data: data,
    );
  }
}
