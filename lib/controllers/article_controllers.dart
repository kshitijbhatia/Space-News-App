import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/network/api_service.dart';

class ArticleController{
  ArticleController._();
  static final ArticleController _instance = ArticleController._();
  static ArticleController get getInstance => _instance;

  final ApiService _api = ApiService.getInstance;

  Future<List<Article>?> getArticles() async{
    try{
      Response<Map<String, dynamic>>? response = await _api.getArticles();
      if(response == null){
        return null;
      }
      List<Map<String, dynamic>> resListJson = List<Map<String, dynamic>>.from(response.data!["results"]);
      List<Article> articles = resListJson.map((json) => Article.fromJson(json)).toList();
      return articles;
    }catch(err){
      log(err.toString());
      return null;
    }
  }
}