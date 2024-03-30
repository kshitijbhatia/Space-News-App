import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:news_app/controllers/article_controllers.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/models/custom_error.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/widgets/article_card.dart';
import 'package:news_app/widgets/loading_screen.dart';
import 'package:news_app/widgets/snackbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Article> articles = [];

  Future<List<Article>> _getArticles() async {
    final response = await ArticleController.getInstance.getArticles();
    if(response.isRight){
      CustomError res = response.right;
      log('Status Code : ${res.statusCode}, Status Message : ${res.statusMessage}');
      throw Error();
    }
    return response.left;
  }


  @override
  Widget build(BuildContext context) {
    double width = ScreenSize.getWidth(context);
    double height = ScreenSize.getHeight(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: height/14,
          elevation: 10,
          title: const Text('Space Flight News', style: TextStyle(color: Colors.white),),
          backgroundColor: AppTheme.primaryColor,
        ),
          body: FutureBuilder<List<Article>>(
            future: _getArticles(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasData){
                  articles = snapshot.data!;
                  return ArticlesList(articles: articles);
                }else if(snapshot.hasError){
                  ScaffoldMessenger.of(context).showSnackBar(getCustomSnackBar("Error Occurred"));
                }
              }else if(snapshot.connectionState == ConnectionState.waiting){
                return const LoadingScreen();
              }
              return Container();
            },
          )
      ),
    );
  }
}

class ArticlesList extends StatefulWidget{
  const ArticlesList({super.key, required this.articles});

  final List<Article> articles;

  @override
  State<ArticlesList> createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList>{

  @override
  Widget build(BuildContext context) {

    double width = ScreenSize.getWidth(context);
    double height = ScreenSize.getHeight(context);

    return SingleChildScrollView(
      child: Container(
        width: width,
        height: 13*(height/14),
        child: ListView.builder(
          itemCount: widget.articles.length,
          itemBuilder: (context, index) {
            Article currentArticle = widget.articles[index];
            return ArticleCard(
              title: currentArticle.title,
              summary: currentArticle.summary,
              image: currentArticle.image,
              source: currentArticle.newsSite,
              url: currentArticle.url,
              publishedAt: currentArticle.publishedAt,
              updatedAt: currentArticle.updatedAt,
            );
          },
        ),
      ),
    );
  }
}


