import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'books.dart';
import 'main.dart';

class DisplayBooks extends StatefulWidget {
  const DisplayBooks({super.key});

  @override
  State<DisplayBooks> createState() => _DisplayBooksState();
}

class _DisplayBooksState extends State<DisplayBooks> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: booksAPI.fetchBooks("arabic"),
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
