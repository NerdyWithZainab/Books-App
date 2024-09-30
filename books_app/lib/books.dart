class Book {
  final String title;
  final String author;
  final String description;
  final String datePublished;
  final String isbn;
  final String imageUrl;
  final String googleBooksId;

  Book(
      {required this.title,
      required this.author,
      required this.description,
      required this.datePublished,
      required this.isbn,
      required this.imageUrl,
      required this.googleBooksId});

  factory Book.fromJson(Map<String, dynamic> json) {
    var industryIdentifiers = json['volumeInfo']['industryIdentifiers'];
    var isbn13 = industryIdentifiers?.firstWhere(
          (identifier) => identifier['type'] == 'ISBN_13',
          orElse: () => null,
        )?['identifier'] ??
        '';
    return Book(
        title: json['volumeInfo']['title'] ?? '',
        author: json['volumeInfo']['authors'] != null
            ? json['volumeInfo']['authors'][0]
            : '',
        description: json['volumeInfo']['description'] ?? '',
        datePublished: json['volumeInfo']['publishedDate'] ?? '',
        isbn: isbn13 ?? ' ',
        imageUrl: json['volumeInfo']['imageLinks']?['thumbnail'] ?? '',
        googleBooksId: json['id']);
  }
}
