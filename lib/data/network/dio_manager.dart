import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../app/constants.dart';

class DioManger {
  static late Dio dioApi;

  static init() async {
    dioApi = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        // validateStatus: (v) => v! < 500,
        connectTimeout: Constants.timeOut,
        receiveTimeout: Constants.timeOut,
        headers: {
          'CONTENT-TYPE': Constants.contentType,
          'ACCEPT': Constants.contentType,
          "AUTHORIZATION": Constants.token,
        },
      ),
    );

    if (!kReleaseMode) {
      dioApi.interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true));
    }
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    dioApi.options.headers = {'Content-Type': 'application/json'};
    return await dioApi.get(
      url,
      queryParameters: query,
    );
  }
}
