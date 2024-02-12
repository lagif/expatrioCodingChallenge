import 'package:coding_challenge/api/model/tax_info.dart';
import 'package:coding_challenge/api/model/user.dart';
import 'package:coding_challenge/api/model/user_info.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'app_config.dart';

part 'api_client.g.dart';

/// The API client based on DIO,
/// wrapped with annotation-poered retrofit client
///
@RestApi(baseUrl: AppConfig.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  /// get the user basic info along with the access token
  ///
  @POST("/auth/login")
  Future<UserInfo> logIn(@Body() Map<String, dynamic> map);

  /// get the user profile info (this request needs authorized access)
  ///
  @GET("/portal/users/{userId}/profile")
  @Headers(AppConfig.standardHeaders)
  Future<User> getUser(
    @Path() String userId,
    @Header('Authorization') String bearerToken,
  );

  /// get the user tax info (this request needs authorized access)
  ///
  @GET("/v3/customers/{userId}/tax-data")
  @Headers(AppConfig.standardHeaders)
  Future<TaxInfo> getTaxData(
    @Path() String userId,
    @Header('Authorization') String bearerToken,
  );

  /// put the user tax info (this request needs authorized access)
  ///
  @PUT("/v3/customers/{userId}/tax-data")
  @Headers(AppConfig.standardHeaders)
  Future<void> saveTaxData(
    @Path() String userId,
    @Header('Authorization') String bearerToken,
    @Body() Map<String, dynamic> taxData,
  );
}
