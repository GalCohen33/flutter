import 'dart:ui';

import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget implements PreferredSizeWidget {
  Function(String query) callback;

  SearchBox(this.callback, {Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(40);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  //Icon customIcon = const Icon(Icons.search);
  //Widget customSearchBar = const Text('My Personal Journal');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
          height: 36,
          child: TextField(
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(255, 238, 234, 234),
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
              contentPadding: EdgeInsets.only(left: 16),
            ),
            onChanged: (value) => {widget.callback(value)},
          )),
    );
  }
}
