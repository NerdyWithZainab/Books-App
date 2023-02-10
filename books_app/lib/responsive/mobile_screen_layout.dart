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
                hintStyle: TextStyle(color: Colors.black),
                border: (OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ))),
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
                  return Text(
                      "An error occured while fetching the books :${snapshot.error}");
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
              Center(child: Text("Reading Now"));
              break;
            case 1:
              Center(child: Text(("Library")));
              break;
            case 2:
              Center(child: Text("Search"));
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
          ),
        ],
      ),
      body: const DisplayBooks(),
    );
  }
}
