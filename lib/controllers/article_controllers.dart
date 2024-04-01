import 'dart:developer';
import 'package:either_dart/either.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/models/custom_error.dart';
import 'package:news_app/network/api_service.dart';

class ArticleController{

  ArticleController._();
  static final ArticleController _instance = ArticleController._();
  static ArticleController get getInstance => _instance;

  final ApiService _api = ApiService.getInstance;

  Future<Either<List<Article>,CustomError>> getArticles(int pageSize, int currentPage) async{
    try{
      final response = await _api.getArticles(pageSize, currentPage);

      if(response.isRight){
        return Right(response.right);
      }

      final List<Map<String, dynamic>> resListJson = List<Map<String, dynamic>>.from(response.left["results"]);
      List<Article> articles = resListJson.map((json) => Article.fromJson(json)).toList();
      return Left(articles);

    }catch(err){
      CustomError res = CustomError(
          statusCode: null,
          statusMessage: "Error Parsing Json"
      );
      return Right(res);
    }
  }
}