import 'package:books_app/api.dart';
import 'package:books_app/views/reading_now.dart';
import 'package:books_app/views/search.dart';
import 'package:books_app/views/bookstore.dart';
import 'package:books_app/views/library.dart';
import 'package:flutter/material.dart';
import '../books.dart';
import '../main.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _selectedIndex = 0;
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [ReadingNow(), Library(), Bookstore(), Search()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar:
          BottomNavigationBar(onTap: _navigateBottomBar, items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.book,
              color: Colors.white,
            ),
            label: "Reading Now",
            backgroundColor: Colors.black),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.library_books_sharp,
              color: Colors.white,
            ),
            label: "Library",
            backgroundColor: Colors.black),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.store_sharp,
              color: Colors.white,
            ),
            label: "Book Store",
            backgroundColor: Colors.black),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            label: "Search",
            backgroundColor: Colors.black)
      ]),
    );
  }
}
