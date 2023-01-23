import 'package:flutter/cupertino.dart';

class Book {
  final String title;
  final String author;
  final String description;
  final DateTime datePublished;
  final String ISBN;
  final Image imageUrl;

  Book(
      {required this.title,
      required this.author,
      required this.description,
      required this.datePublished,
      required this.ISBN,
      required this.imageUrl});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        title: json['volumeInfo']['title'],
        author: json['volumeInfo']['author'][0],
        description: json['volumeInfo']['description'],
        datePublished: json['volumeInfo']['datePublished'],
        ISBN: json['volumeInfo']['ISBN'],
        imageUrl: json['volumeInfo']['imageLinks']['thumbnail']);
  }
}
