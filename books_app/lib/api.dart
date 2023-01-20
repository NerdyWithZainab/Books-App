import 'dart:convert';
import 'package:http/http.dart' as http;
import 'books.dart';

class BooksApi {
  Future<List<Book>?> fetchBooks() async {
    final response = await http.get(
        Uri.parse('https://www.googleapis.com/books/v1/volumes?q=flutter'));

    if (response.statusCode == 200) {
      // If the call to the API was successful, parse the JSON
      List<dynamic> jsonResponse = jsonDecode(response.body)['items'];
      return jsonResponse.map((book) => Book.fromJson(book)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}
