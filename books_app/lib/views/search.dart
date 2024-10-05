import 'package:books_app/api.dart';
import 'package:books_app/books.dart';
import 'package:books_app/main.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
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
                            title: Text(
                              filteredBooks[index].title,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(filteredBooks[index].author,
                                style: const TextStyle(color: Colors.white)),
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
