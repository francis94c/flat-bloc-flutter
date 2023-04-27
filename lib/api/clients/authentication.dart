import 'package:flat_bloc_flutter/api/models/auth_data.dart';
import 'package:flat_bloc_flutter/config/app.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'authentication.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class AuthenticationClient {
  factory AuthenticationClient(Dio dio, {String? baseUrl}) =
      _AuthenticationClient;

  @POST("auth")
  @FormUrlEncoded()
  Future<AuthData> signIn(
    @Field("phone") String phone,
    @Field("password") String password,
  );
}
