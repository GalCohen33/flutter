import 'package:flutter/foundation.dart';
import 'books.model.dart';

class FavoriteBooksModel extends ChangeNotifier {
  late final List<BookModel> _favoriteBooks = [];

  void addItem(BookModel book) {
    _favoriteBooks.add(book);
    notifyListeners();
  }

  List<BookModel> getList() {
    return _favoriteBooks;
  }

  void removeItem(String id) {
    _favoriteBooks.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  bool isOnTheList(String id) {
    return _favoriteBooks.indexWhere((element) => element.id == id) > -1;
  }

  int length() {
    return _favoriteBooks.length;
  }
}
