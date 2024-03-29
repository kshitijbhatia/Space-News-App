import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app/controllers/article_controllers.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState () => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  void api() async{
    final response = await ArticleController.getInstance.getArticles();
    log('${response}');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: TextButton(onPressed: () async {
            api();
    }, child: Text('Request'),
        )
    ));
  }
}