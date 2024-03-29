import 'package:dio/dio.dart';

import '../../../shared/models/custom_error.model.dart';
import '../dtos/auth.dto.dart';

class AuthService {
  late final Dio _dio;

  AuthService(Dio dio)
      : _dio = dio; // Injeção de dependencia (Injection dependecy)

  Future<bool> createAccount(AuthDto auth) async {
    try {
      await _dio.post(
        '/register',
        data: {
          'email': 'teste@teste.com',
          'password': '123456',
        },
      );

      return true;
    } on DioException catch (e) {
      throw CustomError(e.response!.data['error']);
    }
  }

  Future<String> login(AuthDto auth) async {
    try {
      final result = await _dio.post(
        '/login',
        data: {
          'email': 'email',
          'password': 'password',
        },
      );

      return result.data;
    } on DioException catch (e) {
      throw CustomError(e.response!.data['error']);
    }
  }
}
