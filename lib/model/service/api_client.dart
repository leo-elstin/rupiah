import 'package:dio/dio.dart';
import 'package:expense_kit/model/service/exceptions.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future<dynamic> get(String path) async {
    Response? response;

    try {
      response = await _dio.get(path);
    } on DioException catch (e) {
      throw ServiceError(
        code: e.response?.statusCode,
        message: e.response?.statusMessage,
        trace: e.stackTrace,
      );
    }

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw ServiceError(
        code: response.statusCode,
        message: response.statusMessage,
      );
    }
  }

  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? headers,
    Object? data,
  }) async {
    Response? response;

    try {
      response = await _dio.post(path,
          data: data,
          options: Options(
            headers: headers,
          ));
    } on DioException catch (e) {
      throw ServiceError(
        code: e.response?.statusCode,
        message: e.response?.statusMessage,
        trace: e.stackTrace,
      );
    }

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw ServiceError(
        code: response.statusCode,
        message: response.statusMessage,
      );
    }
  }
}
