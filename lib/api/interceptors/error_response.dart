import 'package:dio/dio.dart';
import 'package:flat_bloc_flutter/helpers/http_helper.dart';
import 'package:flat_bloc_flutter/helpers/logging_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ErrorResponseInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (await isUnAuthenticated(err.response?.statusCode ?? 0)) {
      return;
    }
    String? validationError;
    try {
      validationError = (err.response!.data["errors"]?[0]["msg"] as String?);
    } catch (error, trace) {
      logError(error, trace);
    }
    Fluttertoast.showToast(
        msg: validationError ??
            (err.response?.data['message'] as String?) ??
            "Something went wrong",
        toastLength: Toast.LENGTH_LONG);
    handler.next(err);
  }
}
