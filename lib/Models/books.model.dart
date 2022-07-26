import 'dart:convert';

class BookModel {
  final String id;
  final String title;
  final String author;
  final String thumbnailUrl;
  final String description;

  const BookModel(
      {required this.id,
      required this.title,
      required this.author,
      required this.thumbnailUrl,
      required this.description});

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
        id: json['id'],
        title: json['userId'],
        author: json['author'],
        thumbnailUrl: json['title'],
        description: json['description']);
  }

  // static List<BookModel> getList(String jsonStr) {
  //   final jsonMap = json.decode(jsonStr);
  //   final jsonList = (jsonMap['items'] as List);

  //   return jsonList
  //       .map((jsonBook) => BookModel(
  //           title: jsonBook['volumeInfo']['title'],
  //           author: jsonBook['volumeInfo']['authors'] != null
  //               ? (jsonBook['volumeInfo']['authors'] as List).join(', ')
  //               : '',
  //           thumbnailUrl: jsonBook['volumeInfo']['imageLinks'] != null
  //               ? jsonBook['volumeInfo']['imageLinks']['smallThumbnail']
  //               : ''))
  //       .toList();
  // }

  Map toJson() =>
      {'title': title, 'author': author, 'thumbnailUrl': thumbnailUrl};
}

class BookListModel {
  final List<BookModel> books;

  BookListModel({required this.books});

  factory BookListModel.fromJson(String jsonStr) {
    final jsonMap = json.decode(jsonStr);
    final jsonList = (jsonMap['items'] as List);

    List<BookModel> books = jsonList
        .map((jsonBook) => BookModel(
            id: jsonBook['id'],
            title: jsonBook['volumeInfo']['title'],
            author: jsonBook['volumeInfo']['authors'] != null
                ? (jsonBook['volumeInfo']['authors'] as List).join(', ')
                : '',
            thumbnailUrl: jsonBook['volumeInfo']['imageLinks'] != null
                ? jsonBook['volumeInfo']['imageLinks']['smallThumbnail']
                : '',
            description: jsonBook['volumeInfo']['description'] ?? ''))
        .toList();

    return BookListModel(books: books);
  }
}
