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
      Response? response = await _api.getArticles();
      if(response == null){
        return null;
      }
      if(response.statusCode == 200){
        final Map<String, dynamic> resJson = response.data;
        log('1');
        final List<Map<String, dynamic>> resListJson = resJson["results"].cast<List<Map<String, dynamic>>>();
        log('2');
        List<Article> articles = resListJson.map((json) => Article.fromJson(json)).toList();
        return articles;
      }else{
        return null;
      }
    }catch(err){
      log(err.toString());
      return null;
    }
  }
}