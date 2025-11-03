import 'package:dio/dio.dart';
import '../storage/secure_storage.dart';

class DioClient {
  final Dio _dio;
  final SecureStorage _storage;

  DioClient(this._dio, this._storage) {
    _dio.options.baseUrl = "https://piratenode.onrender.com/api/users/login";

    // Add interceptor for auth token
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        // Optional: handle 401, refresh tokens, etc.
        return handler.next(e);
      },
    ));
  }

  Dio get dio => _dio;
}
