import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:news_app/controllers/article_controllers.dart';
import 'package:news_app/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    double width = ScreenSize.getWidth(context);
    double height = ScreenSize.getHeight(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          elevation: 10,
          title: const Text('Space Flight News', style: TextStyle(color: Colors.white),),
          backgroundColor: AppTheme.primaryColor,
        ),
          body: SingleChildScrollView(
            child: Container(
              width: width,
              height: height,
              // child: ListView.builder(itemBuilder: ),
            ),
          )
      ),
    );
  }
}
