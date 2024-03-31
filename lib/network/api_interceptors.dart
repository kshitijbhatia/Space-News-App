import 'dart:developer';
import 'package:dio/dio.dart';

class GetInterceptor extends Interceptor{
  static int _offset = 0;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _offset += 4;
    log('Inside Request Interceptor, $_offset');
    options.queryParameters = {
      'limit' : '4',
      'offset' : '$_offset'
    };
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('Inside Response Interceptor');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('Inside Error Interceptor');
    super.onError(err, handler);
  }
}