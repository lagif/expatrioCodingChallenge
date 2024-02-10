import 'package:coding_challenge/api/client/api_client.dart';
import 'package:coding_challenge/api/client/exceptions.dart';
import 'package:coding_challenge/api/model/user_info.dart';
import 'package:dio/dio.dart';

abstract class AuthRepository {
  Future<UserInfo> logIn(String email, String password);
}

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;

  AuthRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<UserInfo> logIn(String email, String password) async {
    try {
      return await _apiClient.logIn({
        "email": email,
        "password": password,
      });
    } catch (e) {
      if (e is DioException) {
        if ({
          DioExceptionType.connectionError,
          DioExceptionType.sendTimeout,
          DioExceptionType.connectionTimeout,
        }.contains(e.type)) {
          throw ServerNotRespondingException;
        }
        throw (HttpErrorException(
            errorCode: e.response?.statusCode ?? 400,
            errorMessage: e.message ?? "Something's wrong, go again"));
      } else {
        rethrow;
      }
    }
  }
}
