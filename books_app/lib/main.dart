// ignore_for_file: prefer_const_constructors

import 'package:books_app/api.dart';
import 'package:books_app/responsive/mobile_screen_layout.dart';
import 'package:books_app/responsive/responsive_layout_screen.dart';
import 'package:books_app/responsive/web_screen_layout.dart';
import 'package:books_app/views/bookstore.dart';
import 'package:books_app/views/library.dart';
import 'package:books_app/views/reading_now.dart';
import 'package:books_app/views/search.dart';
import 'package:flutter/material.dart';

final booksAPI = BooksApi();
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BooksScreen(),
    );
  }
}

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout()));
  }
}
