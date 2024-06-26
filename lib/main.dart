import 'package:flutter/material.dart';
import 'package:news_app/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
