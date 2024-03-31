import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/utils/utils.dart';
import 'package:readmore/readmore.dart';

class ArticleCard extends StatefulWidget{
  const ArticleCard({
    super.key,
    required this.article
  });

  final Article article;

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
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 10,
            offset: Offset(-10, 5)
          ),
          BoxShadow(
              color: Colors.black45,
              blurRadius: 10,
              offset: Offset(10, 5)
          )
        ]
      ),
      child: Column(
        children: [
            _ArticleImage(image: widget.article.image),
            _ArticleTitle(title: widget.article.title),
            _ArticleSummary(summary: widget.article.summary),
            _ArticleDate(publishedAt: widget.article.publishedAt, updatedAt: widget.article.updatedAt)
        ],
      ),
    );
  }
}

class _ArticleImage extends StatelessWidget{
  const _ArticleImage({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    double width = ScreenSize.getWidth(context);
    double height = ScreenSize.getHeight(context);
    return CachedNetworkImage(
        imageUrl: image,
        imageBuilder: (context, imageProvider) {
          return Container(
            width: width,
            height : height/4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.fill
              )
            )
          );
        },
        progressIndicatorBuilder: (context, url, progress) {
          return Container(
            width: width,
            height: height/4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey
            ),
            child: Center(
              child: SizedBox(
                width: width/8,
                height: height/16,
                child: const CircularProgressIndicator(color: AppTheme.primaryColor,),
              ),
            ),
          );
        },
        errorWidget: (context, url, error) {
          return Container(
            width: width,
            height: height/4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey
            ),
            child: const Icon(Icons.error_outline, size: 60),
          );
        },
    );
  }
}

class _ArticleTitle extends StatelessWidget{
  const _ArticleTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    double width = ScreenSize.getWidth(context);
    double height = ScreenSize.getHeight(context);
    return Container(
      width: width,
      padding: const EdgeInsets.all(10),
      child: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
      ),
    );
  }
}

class _ArticleSummary extends StatefulWidget{
  const _ArticleSummary({super.key, required this.summary});

  final String summary;

  @override
  State<_ArticleSummary> createState() => _ArticleSummaryState();
}

class _ArticleSummaryState extends State<_ArticleSummary> {


  @override
  Widget build(BuildContext context) {

    double width = ScreenSize.getWidth(context);
    double height = ScreenSize.getHeight(context);

    return Container(
      width: width,
      // height: height/8,
      padding: const EdgeInsets.all(10),
      child: ReadMoreText(
        style: const TextStyle(fontSize: 20),
        widget.summary,
        trimMode: TrimMode.Line,
        trimLines: 2,
        trimCollapsedText: '...',
        trimExpandedText: '',
        colorClickableText: Colors.black,
      ),
    );
  }
}

class _ArticleDate extends StatelessWidget{
  const _ArticleDate({super.key, required this.updatedAt, required this.publishedAt});

  final String publishedAt;
  final String updatedAt;

  @override
  Widget build(BuildContext context) {
    double width = ScreenSize.getWidth(context);
    double height = ScreenSize.getHeight(context);
    return Container(
      width: width,
      height: height/22,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 10),
      child: Text(Utils.getDaysAgo(updatedAt), style: const TextStyle(fontSize: 16),),
    );
  }
}