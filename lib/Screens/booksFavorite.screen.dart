import 'package:flutter/material.dart';
import 'package:flutter_one/Models/books.model.dart';
import 'package:flutter_one/Models/booksFavorites.model.dart';
import 'package:provider/provider.dart';

class FavoriteBooksScreen extends StatelessWidget {
  const FavoriteBooksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FavoriteBooksModel favorites = context.watch<FavoriteBooksModel>();

    return Scaffold(
      // No appbar provided to the Scaffold, only a body with a
      // CustomScrollView.
      body: Column(children: [
        AppBar(key: key, title: Text(favorites.length().toString())),
        ListView.builder(
          itemBuilder: (context, index) {
            return Card(
                child: Column(
              children: [
                ListTile(
                  //leading: CircleAvatar(backgroundImage: AssetImage(images[index]),),
                  title: Text(favorites.getItemByIndex(index).title),
                  //subtitle: Text(favorites[index].description),
                ),
                IconButton(
                    onPressed: () => favorites.removeItemByIndex(index),
                    icon: const Icon(Icons.delete))
              ],
            ));
          },
          itemCount: favorites.length(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(5),
          scrollDirection: Axis.vertical,
        )
      ]),
    );
  }
}
