import 'package:books_app/api.dart';
import 'package:books_app/responsive/mobile_screen_layout.dart';
import 'package:books_app/responsive/responsive_layout_screen.dart';
import 'package:books_app/responsive/web_screen_layout.dart';
import 'package:flutter/material.dart';

final booksAPI = BooksApi();
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Scaffold(
          body: ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout())),
      debugShowCheckedModeBanner: false,
      title: 'BooksApp',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
    );
  }
}
