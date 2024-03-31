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
      ScaffoldMessenger.of(context).showSnackBar(getCustomSnackBar("Error Occurred"));
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
          body: FutureBuilder<List<Article>>(
            future: _getArticles(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasData){
                  articles.addAll(snapshot.data!);
                  return _ArticlesList(
                    articles: articles,
                    getArticles: _getArticles,
                  );
                }else if(snapshot.hasError){
                  // Has Error Logic
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

class _ArticlesList extends StatefulWidget{
  const _ArticlesList({super.key, required this.articles, required this.getArticles});

  final List<Article> articles;
  final Function getArticles;

  @override
  State<_ArticlesList> createState() => _ArticlesListState();
}

class _ArticlesListState extends State<_ArticlesList>{

  final _scrollController = ScrollController();

  _scrollListener(){
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
      widget.getArticles();
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {

    double width = ScreenSize.getWidth(context);
    double height = ScreenSize.getHeight(context);

    return Container(
      width: width,
      height: height,
      child: Column(
        children: [
          Expanded(
            flex: 1,
              child: Container(
                color: AppTheme.primaryColor,
                width: width,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10),
                child: const Text('Space News', style: TextStyle(fontSize: 26, color: Colors.white),),
              )
          ),
          Expanded(
            flex: 10,
            child: Container(
              width: width,
              height: 12.3*(height)/14,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: widget.articles.length + 1,
                itemBuilder: (context, index) {
                  if(index < widget.articles.length){
                    Article currentArticle = widget.articles[index];
                    return ArticleCard(
                      article: currentArticle,
                    );
                  }else{
                    return Container(
                      width: width,
                      height: height/12,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}




