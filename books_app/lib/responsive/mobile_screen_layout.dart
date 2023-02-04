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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            if (index == 3) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const DisplayBooks())));
            }
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.book), label: "Reading Now"),
            BottomNavigationBarItem(
                icon: Icon(Icons.library_books_sharp), label: "Library"),
            BottomNavigationBarItem(
                icon: Icon(Icons.store_sharp), label: "Book Store"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          ]),
      body: Column(
        children: <Widget>[
          TextField(
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
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)))),
          ),
          Expanded(
            child: FutureBuilder<List<Book>>(
              future: _controller.text.isEmpty
                  ? Future.value([])
                  : booksAPI.fetchBooks(_controller.text),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data![index].title),
                          subtitle: Text(snapshot.data![index].author),
                          leading:
                              Image.network(snapshot.data![index].imageUrl),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
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
    return const DisplayBooks();
  }
}
