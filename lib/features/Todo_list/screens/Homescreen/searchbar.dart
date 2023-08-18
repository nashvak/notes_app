import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({
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
