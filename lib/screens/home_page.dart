import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:news_app/controllers/article_controllers.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/models/custom_error.dart';
import 'package:news_app/screens/error_page.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/widgets/article_card.dart';
import 'package:news_app/screens/loading_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final ScrollController _scrollController = ScrollController();
  final StreamController<List<Article>> _dataStreamController = StreamController<List<Article>>();
  Stream<List<Article>> get dataStream => _dataStreamController.stream;

  final List<Article> _articles = [];

  int _currentPage = 0;
  final int _pageSize = 4;

  bool _isFetchingData = false;
  bool _stopFetchingData = false;
  bool _pleaseTryAgain = false;

  Future<void> _getArticles() async {
    if(_isFetchingData){
      return;
    }
    try{
      setState(() {
        _isFetchingData = true;
      });
      final response = await ArticleController.getInstance.getArticles(_pageSize, _currentPage);

      if(response.isRight){
        CustomError res = response.right;
        throw res;
      }else{
        if(response.left.isEmpty){
          setState(() {
            _stopFetchingData = true;
          });
          return;
        }
        _articles.addAll(response.left);
        _dataStreamController.add(_articles);
        _currentPage++;
      }
    } on CustomError catch(err){
      _dataStreamController.addError(err);
    } finally {
      setState(() {
        _isFetchingData = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getArticles();
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if(maxScroll == currentScroll && !_stopFetchingData){
        _getArticles();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    double width = ScreenSize.getWidth(context);
    double height = ScreenSize.getHeight(context);

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: SafeArea(
        child: Scaffold(
            body: StreamBuilder<List<Article>>(
              stream: dataStream,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const LoadingScreen();
                }else if(snapshot.hasError){
                  CustomError error = snapshot.error as CustomError;
                  return const ErrorPage();
                }else{
                  final items = snapshot.data;
                  return _ArticlesList(
                    articles: items!,
                    scrollController: _scrollController,
                    isFetchingData: _isFetchingData,
                    stopFetchingData: _stopFetchingData,
                    pleaseTryAgain: _pleaseTryAgain,
                  );
                }
              },
            )
        ),
      ),
    );
  }
}


class _ArticlesList extends StatefulWidget{
  const _ArticlesList({
    super.key,
    required this.articles,
    required this.scrollController,
    required this.isFetchingData,
    required this.stopFetchingData,
    required this.pleaseTryAgain
  });

  final List<Article> articles;
  final ScrollController scrollController;
  final bool isFetchingData;
  final bool stopFetchingData;
  final bool pleaseTryAgain;

  @override
  State<_ArticlesList> createState() => _ArticlesListState();
}

class _ArticlesListState extends State<_ArticlesList>{

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
                padding: const EdgeInsets.only(left: 10),
                child: const Text('Space News', style: TextStyle(fontSize: 26, color: Colors.white),),
              )
          ),
          Expanded(
            flex: 12,
            child: Container(
              width: width,
              child: ListView.builder(
                controller: widget.scrollController,
                itemCount: widget.articles.length + 1,
                itemBuilder: (context, index) {
                  if(index < widget.articles.length){
                    Article currentArticle = widget.articles[index];
                    return ArticleCard(
                      article: currentArticle,
                    );
                  }else if(!widget.stopFetchingData && !widget.pleaseTryAgain && index == widget.articles.length){
                    return Container(
                      width: width,
                      height: height/12,
                      child: const Center(
                        child: CircularProgressIndicator(color: AppTheme.primaryColor,),
                      ),
                    );
                  }else{
                    return Container();
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




