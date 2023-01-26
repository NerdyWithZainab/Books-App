class Book {
  final String title;
  final String author;
  final String description;
  final String datePublished;
  final String isbn;
  final String imageUrl;

  Book(
      {required this.title,
      required this.author,
      required this.description,
      required this.datePublished,
      required this.isbn,
      required this.imageUrl});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        title: json['volumeInfo']['title'] ?? '',
        author: json['volumeInfo']['authors']?.first ?? '',
        description: json['volumeInfo']['description'] ?? '',
        datePublished: json['volumeInfo']['publishedDate'] ?? '',
        isbn: json['volumeInfo']['ISBN'] ?? '',
        imageUrl: json['volumeInfo']['imageLinks']['thumbnail'] ?? '');
  }
}
