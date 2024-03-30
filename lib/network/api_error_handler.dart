import 'package:dio/dio.dart';

String handleError(DioException error){
  switch(error.type){
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.sendTimeout:
      return "Timeout occurred while sending or receiving";
    case DioExceptionType.badResponse:
      final statusCode = error.response!.statusCode;
      switch(statusCode){
        case 400:
          return "Bad Request";
        case 401:
          return "Unauthorized";
        case 403:
          return "Forbidden";
        case 404:
          return "Not Required";
        case 409:
          return "Conflict";
        case 500:
          return "Internal Server Error";
      }
      break;
    case DioExceptionType.cancel:
      return "Request Cancelled";
    case DioExceptionType.connectionError:
      return "Connection Error";
    default:
      return "Unknown Error";
  }
  return "Unknown Error";
}