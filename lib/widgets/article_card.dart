import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utils/constants.dart';

class ArticleCard extends StatefulWidget{
  const ArticleCard({
    super.key,
    required this.title,
    required this.summary,
    required this.image,
    required this.url,
    required this.source,
    required this.publishedAt,
    required this.updatedAt
  });

  final String title;
  final String summary;
  final String image;
  final String url;
  final String source;
  final String publishedAt;
  final String updatedAt;

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard>{
  @override
  Widget build(BuildContext context) {

    double width = ScreenSize.getWidth(context);
    double height = ScreenSize.getHeight(context);

    return Container(
      width: width,
      height: height/1.8,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 5,
            offset: Offset(10, 10)
          )
        ]
      ),
      child: Column(
        children: [
            ArticleImage(image: widget.image)
        ],
      ),
    );
  }
}

class ArticleImage extends StatelessWidget{
  const ArticleImage({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    double width = ScreenSize.getWidth(context);
    double height = ScreenSize.getHeight(context);
    return Container(
      width: width,
      height: height/4,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          // fit: BoxFit.fill,
          imageUrl: image,
          placeholder: (context, url){
            return Container(
              color: Colors.red,
              width: width/20,
              height: height/20,
              child: const CircularProgressIndicator(),
            );
          },
          errorWidget: (context, url, error) => const Icon(Icons.error, size: 20,),
        ),
      ),
    );
  }
}