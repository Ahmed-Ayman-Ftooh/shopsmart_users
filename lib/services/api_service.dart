import 'package:dio/dio.dart';

class ApiService {
  Dio dio = Dio();
  Future<Response> post({
    required String url,
    required body,
    required String token,
    Map<String, String>? headers,
    String? contentType,
  }) async {
    var response = await dio.post(
      url,
      data: body,
      options: Options(
        contentType: contentType,
        headers: headers ?? {"Authorization": "Bearer $token"},
      ),
    );
    return response;
  }
}
