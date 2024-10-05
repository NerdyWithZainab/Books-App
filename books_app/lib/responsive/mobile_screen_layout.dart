import 'package:books_app/api.dart';
import 'package:books_app/views/reading_now.dart';
import 'package:books_app/views/search.dart';
import 'package:flutter/material.dart';
import '../books.dart';
import '../main.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          switch (index) {
            case 0:
              const Center(
                  child: Text(
                "Reading Now",
              ));
              break;
            case 1:
              const Center(child: Text(("Library")));
              break;
            case 2:
              const Center(
                child: Text("Bookstore"),
              );
              break;

            case 3:
              const Center(child: Text("Search"));
              break;
            case 4:
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const ReadingNow())));
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.book,
              color: Colors.white,
            ),
            label: "Reading Now",
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.library_books_sharp,
              color: Colors.white,
            ),
            label: "Library",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.store_sharp,
              color: Colors.white,
            ),
            label: "Book Store",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            label: "Search",
            backgroundColor: Colors.white,
          ),
        ],
      ),
      body: const Search(),
    );
  }
}
