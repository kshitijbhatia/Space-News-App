import 'dart:developer';
import 'package:dio/dio.dart';
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

  Future<Response<Map<String, dynamic>>?> getArticles() async {
    try{

      Map<String, dynamic> queryParams = {
        'has_event' : true,
        'has_launch' : true,
        'is_featured' : true
      };

      final Response<Map<String, dynamic>> response = await _dio.get(Constants.getArticlesEndpoint, queryParameters: queryParams);
      return response;
    }on DioException catch(err){
      return null;
    }
  }

}