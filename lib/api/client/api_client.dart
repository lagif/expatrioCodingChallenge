import 'package:coding_challenge/api/model/tax_info.dart';
import 'package:coding_challenge/api/model/user.dart';
import 'package:coding_challenge/api/model/user_info.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'app_config.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: AppConfig.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST("/auth/login")
  Future<UserInfo> logIn(@Body() Map<String, dynamic> map);

  @GET("/portal/users/{userId}/profile")
  @Headers(AppConfig.standardHeaders)
  Future<User> getUser(
    @Path() String userId,
    @Header('Authorization') String bearerToken,
  );

  @GET("/v3/customers/{userId}/tax-data")
  @Headers(AppConfig.standardHeaders)
  Future<TaxInfo> getTaxData(
    @Path() String userId,
    @Header('Authorization') String bearerToken,
  );

  @PUT("/v3/customers/{userId}/tax-data")
  @Headers(AppConfig.standardHeaders)
  Future<TaxInfo> saveTaxData(
    @Path() String userId,
    @Header('Authorization') String bearerToken,
    @Body() Map<String, dynamic> taxData,
  );
}
