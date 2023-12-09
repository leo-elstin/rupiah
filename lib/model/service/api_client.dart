import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>?> get(String path) async {
    Response response = await _dio.get(path);

    if (response.statusCode == 200) {
      return response.data;
    }

    return null;
  }
}
