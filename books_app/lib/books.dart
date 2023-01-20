class Book {
  final String title;
  final String author;
  final String description;
  final DateTime datePublished;
  final String ISBN;

  Book(
      {required this.title,
      required this.author,
      required this.description,
      required this.datePublished,
      required this.ISBN});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        title: json['title'],
        author: json['author'],
        description: json['description'],
        datePublished: json['datePublished'],
        ISBN: json['ISBN']);
  }
}
