import 'package:coding_challenge/api/client/api_client.dart';
import 'package:coding_challenge/api/client/exceptions.dart';
import 'package:coding_challenge/api/model/tax_info.dart';
import 'package:dio/dio.dart';

abstract class TaxInfoRepository {
  Future<TaxInfo> getTaxInfo(String userId, String token);
  Future<void> setTaxInfo(String userId, TaxInfo taxInfo, String token);
}

class TaxInfoRepositoryImpl implements TaxInfoRepository {
  final ApiClient _apiClient;

  TaxInfoRepositoryImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  @override
  Future<TaxInfo> getTaxInfo(String userId, String token) async {
    try {
      return await _apiClient.getTaxData(userId, token);
    } catch (e) {
      throw toHttpRequestErrorException(e);
    }
  }

  @override
  Future<void> setTaxInfo(String userId, TaxInfo taxInfo, String token) async {
    try {
      return await _apiClient.saveTaxData(userId, token, taxInfo.toJson());
    } catch (e) {
      throw toHttpRequestErrorException(e);
    }
  }

  HttpRequestException toHttpRequestErrorException(dynamic e) {
    if (e is DioException) {
      if (e.response?.statusCode == 401 || e.response?.statusCode == 400) {
        return (HttpErrorException(
            errorCode: e.response?.statusCode ?? 401,
            errorMessage:
                "Your credentials seem to be wrong. Give it another try!"));
      }
      if ({
        DioExceptionType.connectionError,
        DioExceptionType.sendTimeout,
        DioExceptionType.connectionTimeout,
      }.contains(e.type)) {
        return ServerNotRespondingException();
      }
      return (HttpErrorException(
          errorCode: e.response?.statusCode ?? 400,
          errorMessage: e.message ?? "Something's wrong, go again"));
    } else {
      return HttpErrorException(
          errorCode: 500,
          errorMessage: "Unknown error just happened. Please try again!");
    }
  }
}
