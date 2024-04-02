import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:news_app/models/custom_error.dart';
import 'package:news_app/utils/utils.dart';

class GetInterceptor extends Interceptor{

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('Inside Request Interceptor');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('Inside Response Interceptor');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage = Utils.handleError(err);
    CustomError customError = CustomError(
      statusCode: err.response?.statusCode,
      statusMessage: errorMessage,
    );
    throw DioException(requestOptions: err.requestOptions, response: err.response, error: customError);
  }
}