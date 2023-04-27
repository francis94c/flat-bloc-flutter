import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:no_context_navigation/no_context_navigation.dart';

import 'package:flat_bloc_flutter/screens/auth/sign_in.dart';
import 'package:flat_bloc_flutter/services/auth_service.dart';

int? getHttpErrorCode(error) {
  switch (error.runtimeType) {
    case DioError:
      if ((error as DioError).response != null) {
        return error.response!.statusCode;
      } else {
        return null;
      }
    default:
      return null;
  }
}

Future<bool> isUnAuthenticated(int? code) async {
  if (code == null) return Future.value(false);
  if (code == 401) {
    navService.pushNamedAndRemoveUntil(SignInScreen.routeName,
        predicate: (route) => false);

    Fluttertoast.showToast(msg: "You've been logged out.");
    return Future.value(true);
  }
  return Future.value(false);
}

Future<String> getAuthorization() async {
  return "Bearer ${await AuthService().getToken() ?? "<none>"}";
}
