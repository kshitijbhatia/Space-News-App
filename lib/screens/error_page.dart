import 'package:flutter/material.dart';
import 'package:news_app/screens/home_page.dart';
import 'package:news_app/utils/constants.dart';

class ErrorPage extends StatefulWidget{
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {

  @override
  Widget build(BuildContext context) {

    double width = ScreenSize.getWidth(context);
    double height = ScreenSize.getHeight(context);

    return WillPopScope(
      onWillPop: (){
        return Future.value(false);
      },
      child: Container(
        width: width,
        height: height,
        child: const Column(
          children: [
            Expanded(
                flex: 1,
                child: _ErrorPageHeader()
            ),
            Expanded(
                flex: 12,
                child: _ErrorMessage()
            )
          ],
        ),
      ),
    );
  }
}


class _ErrorPageHeader extends StatelessWidget{
    const _ErrorPageHeader({super.key});

    @override
  Widget build(BuildContext context) {

      double width = ScreenSize.getWidth(context);

      return Container(
        width: width,
      color: AppTheme.primaryColor,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 10),
      child: const Text('Space News', style: TextStyle(color: Colors.white, fontSize: 26),),
    );
  }
}

class _ErrorMessage extends StatelessWidget{
  const _ErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {

    double width = ScreenSize.getWidth(context);
    double height = ScreenSize.getHeight(context);

    return Center(
      child: Container(
        width: width/1.2,
        height: height/3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Something went wrong. Please try again', style: TextStyle(fontSize: 40,color: AppTheme.primaryColor, fontWeight: FontWeight.w300),),
            30.h,
            TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(AppTheme.primaryColor),
                  padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 10, horizontal: 30))
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage(),));
                },
                child: const Text('Retry', textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 18),)
            )
          ],
        ),
      )
    );
  }
}