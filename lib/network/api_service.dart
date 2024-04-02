import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:news_app/models/custom_error.dart';
import 'package:news_app/network/api_interceptors.dart';
import 'package:news_app/utils/constants.dart';

class ApiService{
  ApiService._();
  static final ApiService _instance = ApiService._();
  static ApiService get getInstance => _instance;

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Accept' : 'application/json'
      },
    ),
  );

  // Get All Articles
  Future<Either<Map<String, dynamic>, CustomError>> getArticles(int pageSize, int currentPage) async {
    try{
      _dio.interceptors.add(GetInterceptor());

      String method = 'GET';
      int offset = 4*currentPage;

      Map<String, dynamic> queryParams = {
        'has_event' : true,
        'has_launch' : true,
        'is_featured' : true,
        'limit' : pageSize,
        'offset' : offset
      };

      final Response<Map<String, dynamic>> response = await _dio.request(
          Constants.getArticlesEndpoint,
          options: Options(method: method),
          queryParameters: queryParams);

      final Map<String, dynamic> resJson = response.data!;
      return Left(resJson);

    } on DioException catch(err){
      CustomError res = err.error as CustomError;
      log('${res.statusCode} ${res.statusMessage}');
      return Right(res);
    }catch(err){
      log('inside normal catch');
      CustomError res = CustomError(
          statusCode: null,
          statusMessage: err.toString());
      return Right(res);
    }
  }
}