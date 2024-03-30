import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:news_app/models/custom_error.dart';
import 'package:news_app/network/api_error_handler.dart';
import 'package:news_app/utils/constants.dart';

class ApiService{
  ApiService._();
  static final ApiService _instance = ApiService._();
  static ApiService get getInstance => _instance;

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {
        'Accept' : 'application/json'
      },
    )
  );

  // Get All Articles
  Future<Either<Map<String, dynamic>, CustomError>> getArticles() async {
    try{
      String method = 'GET';

      Map<String, dynamic> queryParams = {
        'has_event' : true,
        'has_launch' : true,
        'is_featured' : true
      };

      final Response<Map<String, dynamic>> response = await _dio.request(
          Constants.getArticlesEndpoint,
          options: Options(method: method),
          queryParameters: queryParams);

      final Map<String, dynamic> resJson = response.data!;
      return Left(resJson);

    } on DioException catch(error){
      if(error.response == null){
        CustomError res = CustomError(
            statusCode: null,
            statusMessage: "DNS/Network Error");
        return Right(res);
      }
      String errorMessage = handleError(error);
      CustomError res = CustomError(
          statusCode: error.response!.statusCode,
          statusMessage: errorMessage);
      return Right(res);
    }catch(err){
      CustomError res = CustomError(
          statusCode: null,
          statusMessage: err.toString());
      return Right(res);
    }
  }
}