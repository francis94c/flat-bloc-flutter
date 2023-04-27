import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import 'package:flat_bloc_flutter/api/clients/authentication.dart';
import 'package:flat_bloc_flutter/api/interceptors/error_response.dart';
import 'package:flat_bloc_flutter/api/interceptors/response_logging.dart';
import 'package:flat_bloc_flutter/config/env_keys.dart';

import 'config/app.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // HTTP Clients.
  Dio dio = Dio(BaseOptions(headers: baseHeaders));

  // Interceptors.
  if (kDebugMode) {
    dio.interceptors.add(ResponseLoggingInterceptor());
  }

  dio.interceptors.add(ErrorResponseInterceptor());

  if (kDebugMode) {
    locator.registerFactory<AuthenticationClient>(() => AuthenticationClient(
        dio,
        baseUrl: kDebugMode ? null : dotenv.env[EnvKeys.baseUrl]));
  } else {
    locator.registerSingleton<AuthenticationClient>(AuthenticationClient(dio,
        baseUrl: kDebugMode ? null : dotenv.env[EnvKeys.baseUrl]));
  }

  // 3rd Party Services
  // locator.registerLazySingleton<GoogleMapsPlaces>(
  //     () => GoogleMapsPlaces(apiKey: dotenv.env['GOOGLE_MAPS_API_KEY']));

  // Event Bus
  // locator.registerSingleton<EventBus>(EventBus());
}
