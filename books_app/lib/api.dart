import 'dart:convert';
import 'package:http/http.dart' as http;
import 'books.dart';
import 'package:books_app/config.dart';

class BooksApi {
  Future<List<Book>> fetchBooks(String query) async {
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=$query&key="$apiKey'));

    if (response.statusCode == 200) {
      // If the call to the API was successful, parse the JSON
      List<dynamic> jsonResponse = jsonDecode(response.body)['items'];
      return (jsonResponse.map((book) => Book.fromJson(book)).toList());
    } else {
      throw Exception('Failed to load books');
    }
  }
}
