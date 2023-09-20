import 'package:flutter/material.dart';

import '../Addsreen/addscreen.dart';

//import 'addscreen.dart';

class FloatingActionBtn extends StatelessWidget {
  const FloatingActionBtn({
    super.key,
    required this.icons,
  });

  final TextStyle? icons;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddScreen()));
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        child: Icon(
          Icons.add,
          size: 30,
          color: icons!.color,
        ),
      ),
    );
  }
}

//

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.cursor,
    required this.style,
  });

  final TextStyle? cursor;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextField(
      //controller: search,
      cursorColor: cursor!.color,
      /*onChanged: (val) {
        provider.onSearchTextChanged(val);
      },*/
      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        hintText: "Search notes...",
        hintStyle: Theme.of(context).textTheme.titleSmall,
        prefixIcon: Icon(
          Icons.search,
          color: style!.color,
        ),
        fillColor: Theme.of(context).colorScheme.primary,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}
