import 'package:books_app/api.dart';
import 'package:flutter/material.dart';
import 'books.dart';

final booksAPI = BooksApi();
void main() => runApp(const MyApp());

class DisplayBooks extends StatefulWidget {
  const DisplayBooks({super.key});

  @override
  State<DisplayBooks> createState() => _DisplayBooksState();
}

class _DisplayBooksState extends State<DisplayBooks> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: booksAPI.fetchBooks('Flutter'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].title),
                  subtitle: Text(snapshot.data![index].author),
                  leading: Image.network(snapshot.data![index].imageUrl),
                );
              });
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Scaffold(body: DisplayBooks()),
      debugShowCheckedModeBanner: false,
      title: 'BooksApp',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
    );
  }
}
