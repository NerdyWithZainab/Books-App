import 'package:books_app/views/reading_now.dart';
import 'package:books_app/views/search.dart';
import 'package:books_app/views/bookstore.dart';
import 'package:books_app/views/library.dart';
import 'package:flutter/material.dart';

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

  final List _pages = [
    const ReadingNow(),
    const Library(),
    const Bookstore(),
    const Search()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.black,
          primaryColor: Colors.white,
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _navigateBottomBar,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: "Reading Now",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books_sharp),
              label: "Library",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store_sharp),
              label: "Book Store",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
            )
          ],
        ),
      ),
    );
  }
}
