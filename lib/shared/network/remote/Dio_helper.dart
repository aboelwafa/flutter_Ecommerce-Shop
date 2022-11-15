// ignore_for_file: file_names, prefer_if_null_operators, unused_import, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:market/shared/Components/constants.dart';

class DioHelper
{
  static late Dio dio;

  static init()
  {
    dio=Dio(
      BaseOptions(
        baseUrl:'https://student.valuxapps.com/api/' ,
        receiveDataWhenStatusError: true,

      ),
    );
  }

  static Future<Response<dynamic>> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,

  }) async {
    String? localToken = token;
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': localToken==null?'':localToken,
      'lang': lang,
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

   static Future<Response<dynamic>> postData(
      {required String url,
      Map<String, dynamic>? query,
      String lang = 'en',
      String? token,
      // required String? email,

        required Map<String, dynamic> data}) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization' : token!=null?token:'',

     };
    return await dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response<dynamic>> PutData(
      {
        required String url,
        Map<String, dynamic>? query,
        String lang = 'en',
        String? token,
        required Map<String, dynamic> data}) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization' : token!=null?token:'',
    };
    return await dio.put(
      url,
      data: data,
      queryParameters: query,
    );
  }

}

