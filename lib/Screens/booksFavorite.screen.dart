import 'package:flutter/material.dart';
import 'package:flutter_one/Models/books.model.dart';
import 'package:flutter_one/Models/booksFavorites.model.dart';
import 'package:provider/provider.dart';

class FavoriteBooksScreen extends StatelessWidget {
  const FavoriteBooksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BookModel> favorites = context.watch<FavoriteBooksModel>().getList();

    return Scaffold(
      // No appbar provided to the Scaffold, only a body with a
      // CustomScrollView.
      body: Column(children: [
        AppBar(key: key, title: Text(favorites.length.toString())),
        ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                //leading: CircleAvatar(backgroundImage: AssetImage(images[index]),),
                title: Text(favorites[index].title),
                //subtitle: Text(favorites[index].description),
              ),
            );
          },
          itemCount: favorites.length,
          shrinkWrap: true,
          padding: const EdgeInsets.all(5),
          scrollDirection: Axis.vertical,
        )
      ]),
      // body: CustomScrollView(
      //   slivers: [
      //     AppBar(key: key, title: const Text('favorites')),
      //     const SliverToBoxAdapter(child: SizedBox(height: 12)),
      //     SliverList(
      //       // Use a delegate to build items as they're scrolled on screen.
      //       delegate: SliverChildBuilderDelegate(
      //           // The builder function returns a ListTile with a title that
      //           // displays the index of the current item.
      //           (context, index) =>
      //               ListTile(title: Text(favorites[index].title)),
      //           // Builds 1000 ListTiles
      //           childCount: favorites.length),
      //     ),
      //   ],
      // ),
    );
  }
}
