import 'package:flutter/material.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/widgets/snackbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget{
  const WebViewPage({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {

    double width = ScreenSize.getWidth(context);
    double height = ScreenSize.getHeight(context);

    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: SafeArea(
          child: Scaffold(
            body: Container(
              width: width,
              height: height,
              child: Column(
                children: [
                  const Expanded(
                    flex: 1,
                    child: _WebViewPageHeader()
                  ),
                  Expanded(
                    flex: 12,
                      child: _WebViewComponent(url: url,)
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}

class _WebViewPageHeader extends StatelessWidget{
  const _WebViewPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    double width = ScreenSize.getWidth(context);
    return Container(
      color: AppTheme.primaryColor,
      width: width,
      child: Row(
        children: [
          IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white,size: 29,)
          ),
          20.w,
          const Text('Description', style: TextStyle(fontSize: 26, color: Colors.white),)
        ],
      ),
    );
  }
}

class _WebViewComponent extends StatefulWidget{
  const _WebViewComponent({super.key, required this.url});

  final String url;

  @override
  State<_WebViewComponent> createState() => _WebViewComponentState();
}

class _WebViewComponentState extends State<_WebViewComponent> {
  var loadingPercentage = 0;

  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('SnackBar', onMessageReceived: (p0) {
        ScaffoldMessenger.of(context).showSnackBar(getCustomSnackBar(p0.message));
      },)
      ..loadRequest(Uri.parse(widget.url)
      );
  }

  @override
  Widget build(BuildContext context) {
    double width = ScreenSize.getWidth(context);
    return Container(
      width: width,
      child: WebViewWidget(controller: controller,)
    );
  }
}