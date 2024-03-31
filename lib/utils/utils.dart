import 'package:dio/dio.dart';

class Utils{

  static String getDaysAgo(String updatedAt){
    DateTime updatedAtDate = DateTime.parse(updatedAt);
    DateTime now = DateTime.now();
    Duration difference = now.difference(updatedAtDate);
    int days = difference.inDays;
    if(days == 0){
      int hours = difference.inHours;
      if(hours == 0){
        int minutes = difference.inMinutes;
        return minutes == 1 ? '1 minute ago' : '$minutes minutes ago';
      }
      return hours == 1 ? '1 hour ago' : '$hours hours ago';
    }else if(days >= 7 && days < 31){
      int weeks = days~/7;
      return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
    }else if(days >= 31 && days<365){
      int months = days~/31;
      return months == 1 ? '1 months ago' : '$months months ago';
    }else if(days >= 365){
      int years = days~/365;
      return years == 1 ? '1 year ago' : '$years years ago';
    }
    return days == 1 ? '1 day ago' : '$days days ago';
  }

  static String handleError(DioException error){
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
}