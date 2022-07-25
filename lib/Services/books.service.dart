import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../Models/books.model.dart';

class BooksService {
  //'https://www.googleapis.com/books/v1/volumes?q=harry+potter+inauthor:rowling';

  static Future<List<BookModel>> fetchBook(query) async {
    var url = 'https://www.googleapis.com/books/v1/volumes?q=$query';
    final response = await http.get(Uri.parse(url));
    List<BookModel> booksLst = BookListModel.fromJson(response.body).books;
    debugPrint(booksLst.length.toString());
    return booksLst;
  }
}
