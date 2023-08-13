import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Themes/theme_provider.dart';

class FirstAppbar extends StatelessWidget {
  const FirstAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'N O T E S',
          style: Theme.of(context).textTheme.titleLarge,
          // style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        Switch.adaptive(
          value: themeProvider.isDarkTheme,
          activeColor: Color(0xFFCCE5FF),
          onChanged: (val) {
            themeProvider.toggleTheme();
          },
        ),
      ],
    );
  }
}






































 /*Switch.adaptive(
          value: todoProvider.isDarkMode,
          onChanged: (value) {
            final provider = Provider.of<TodoProvider>(context, listen: false);
            provider.toggleTheme(value);
          },
        ),*/