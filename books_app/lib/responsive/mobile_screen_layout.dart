import 'package:books_app/api.dart';
import 'package:flutter/material.dart';
import '../books.dart';
import '../main.dart';

class DisplayBooks extends StatefulWidget {
  const DisplayBooks({super.key});

  @override
  State<DisplayBooks> createState() => _DisplayBooksState();
}

class _DisplayBooksState extends State<DisplayBooks> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final booksApi = BooksApi();
  // Declare a List of Book objects to hold the filteredBooks data
  List<Book> filteredBooks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          TextField(
            onChanged: (value) async {
              if (value.isEmpty) {
                setState(() {
                  this.filteredBooks = [];
                });
                return;
              }
              // Call the fetchBooks method to retrieve a list of books based on the search query
              final books = await booksApi.fetchBooks(value);
              Set<String> uniqueIds = <String>{};
              final searchTerms = value.toLowerCase().split(" ");
              final filteredBooks = books.where((book) {
                final bookTitle = book.title.toLowerCase();
                final isDuplicate = uniqueIds.contains(book.googleBooksId);
                if (!isDuplicate &&
                    searchTerms.every((term) => bookTitle.contains(term))) {
                  uniqueIds.add(book.googleBooksId);
                  return true;
                }
                return false;
              }).toList();
              // Refresh the UI with the filteredBooks data
              setState(() {
                this.filteredBooks = filteredBooks;
              });
            },
            style: const TextStyle(color: Colors.black),
            controller: _controller,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  _controller.clear();
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
              fillColor: Colors.white,
              filled: true,
              hintText: "Search books...",
              hintStyle: const TextStyle(color: Colors.black),
              border: (const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              )),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Book>>(
              future: _controller.text.isEmpty
                  ? Future.value([])
                  : booksAPI.fetchBooks(_controller.text),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: filteredBooks.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            title: Text(filteredBooks[index].title),
                            subtitle: Text(filteredBooks[index].author),
                            leading: filteredBooks[index].imageUrl.isNotEmpty
                                ? Image.network(filteredBooks[index].imageUrl,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.broken_image))
                                : const Icon(Icons.book));
                      });
                } else if (snapshot.hasError) {
                  return Text(
                      "An error occurred while fetching the books :${snapshot.error}");
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}

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
              const Center(child: Text("Search"));
              break;
            case 3:
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const DisplayBooks())));
          }
        },
        items: const <BottomNavigationBarItem>[
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
          ),
        ],
      ),
      body: const DisplayBooks(),
    );
  }
}
