// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_one/Models/books.model.dart';
import 'package:flutter_one/Models/booksFavorites.model.dart';
import 'package:provider/provider.dart';
import '../Services/books.service.dart';

class BooksCatalogScreen extends StatefulWidget {
  const BooksCatalogScreen({Key? key}) : super(key: key);

  @override
  State<BooksCatalogScreen> createState() => _BooksCatalogScreenState();
}

class _BooksCatalogScreenState extends State<BooksCatalogScreen> {
  int index = 0;
  var topics = ['fish', 'war', 'putin', 'trump'];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   setState(() {
      //     if (index == 3)
      //       index = 0;
      //     else
      //       index++;
      //   });
      // },
      child: BooksCatalog(query: topics[index]),
    );
  }
}

class BooksCatalog extends StatelessWidget {
  final query;

  const BooksCatalog({Key? key, required this.query}) : super(key: key);

  //final Future<List<BookModel>> _books = BooksService.fetchBook();
  // BooksCatalogScreen({
  //   Key? key,
  //   required this.query,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('books'), actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () => Navigator.pushNamed(context, '/favorites'),
          )
        ]), //headerWidget(key: key, title: 'books'),
        body: DefaultTextStyle(
            style: Theme.of(context).textTheme.headline2!,
            textAlign: TextAlign.center,
            child: FutureBuilder<List<BookModel>>(
                future: BooksService.fetchBook(
                    query), // _books, // a previously-obtained Future<String> or null
                builder: (BuildContext context,
                    AsyncSnapshot<List<BookModel>> snapshot) {
                  //List<Widget> children;
                  if (snapshot.hasData) {
                    <Widget>[
                      const Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                        size: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('Result: ${snapshot.data}'),
                      )
                    ];
                  } else if (snapshot.hasError) {
                    <Widget>[
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('Error: ${snapshot.error}'),
                      )
                    ];
                  } else {
                    <Widget>[
                      const SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Awaiting result...'),
                      )
                    ];
                  }
                  return snapshot.data != null
                      ? ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return _bookItem(snapshot.data![index]);

                            //return _bookItem(snapshot.data![index]);
                            //ProjectModel project = snapshot.data![index];
                            // return Column(children: const <Widget>[
                            //   // Widget to display the list of project
                            //   Icon(
                            //     Icons.error_outline,
                            //     color: Colors.red,
                            //     size: 60,
                            //   )
                            // ]);
                          })
                      : Image.asset(
                          'assets/images/no-image.jpg',
                          fit: BoxFit.cover,
                          scale: 4,
                        );
                })));
  }
}

class _bookItem extends StatelessWidget {
  final BookModel _book;
  const _bookItem(this._book);

  @override
  Widget build(BuildContext context) {
    //return Column(
    //crossAxisAlignment: CrossAxisAlignment.center,
    //mainAxisSize: MainAxisSize.min,
    //children: <Widget>[
    return Card(
        elevation: 18.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.all(8.0),
        child: Row(children: [
          _book.thumbnailUrl != ''
              ? Image.network(
                  _book.thumbnailUrl,
                  fit: BoxFit.cover,
                  height: 100.0,
                  width: 65.0,
                )
              : Image.asset(
                  'assets/images/no-image.jpg',
                  fit: BoxFit.cover,
                  scale: 4,
                ),
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8, left: 8),
                  child: Text(
                    _book.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8, left: 8),
                  child: Text(
                    _book.author,
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Container(
            padding: const EdgeInsets.only(bottom: 0, right: 8),
            child: Column(
              children: [
                _favButton(item: _book)
                // const Text(
                //   '4.7k',
                // )
              ],
            ),
          ),
        ]));
  }

  // String randomNumber() {
  //   var random = Random();
  //   double min = 0;
  //   double max = 5;

  //   double result = 5 - (random.nextInt(5) * random.nextDouble());
  //   return result.toStringAsFixed(1);
  // }
}

class _favButton extends StatelessWidget {
  final BookModel item;

  const _favButton({required this.item});

  @override
  Widget build(BuildContext context) {
    // The context.select() method will let you listen to changes to
    // a *part* of a model. You define a function that "selects" (i.e. returns)
    // the part you're interested in, and the provider package will not rebuild
    // this widget unless that particular part of the model changes.
    //
    // This can lead to significant performance improvements.
    var isOnTheList = context.select<FavoriteBooksModel, bool>(
        // Here, we are only interested whether [item] is inside the cart.
        (favorites) => favorites.isOnTheList(item.id));

    return TextButton(
      onPressed: isOnTheList
          ? () {
              // If the item is not in cart, we let the user add it.
              // We are using context.read() here because the callback
              // is executed whenever the user taps the button. In other
              // words, it is executed outside the build method.
              var favorites = context.read<FavoriteBooksModel>();
              favorites.removeItem(item.id);
            }
          : () {
              // If the item is not in cart, we let the user add it.
              // We are using context.read() here because the callback
              // is executed whenever the user taps the button. In other
              // words, it is executed outside the build method.
              var favorites = context.read<FavoriteBooksModel>();
              favorites.addItem(item);
            },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      child: isOnTheList
          ? Icon(
              Icons.favorite,
              color: Colors.red[500],
            )
          : Icon(
              Icons.favorite,
              color: Colors.grey[500],
            ),
    );
  }
}
