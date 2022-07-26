import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget implements PreferredSizeWidget {
  const SearchBox({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('My Personal Journal');

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: const TextField(
          decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromARGB(255, 238, 234, 234),
        border: OutlineInputBorder(),
        hintText: 'Enter a search term',
      )),
    );
  }
}
