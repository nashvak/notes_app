import 'package:flutter/material.dart';

class FirstAppbar extends StatelessWidget {
  const FirstAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'N O T E S',
          style: Theme.of(context).textTheme.titleLarge,
          // style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        /*Switch.adaptive(
          value: todoProvider.isDarkMode,
          onChanged: (value) {
            final provider = Provider.of<TodoProvider>(context, listen: false);
            provider.toggleTheme(value);
          },
        ),*/
        Icon(
          Icons.dark_mode,
          color: Colors.black,
        )
      ],
    );
  }
}
