import 'package:flutter/cupertino.dart';

class Constants{
  Constants._();

  static const baseUrl = 'https://api.spaceflightnewsapi.net/';
  static const getArticlesEndpoint = 'v4/articles/';
}

class AppTheme{
  static const Color primaryColor = Color.fromRGBO(24, 56, 131, 1);
}

class ScreenSize{
  static getWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  static getHeight(BuildContext context){
    return MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
  }
}