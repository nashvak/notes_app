import 'dart:io';

import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/features/Themes/theme_provider.dart';
import 'package:notes_app/features/Todo_list/provider/todo_provider.dart';
import 'package:notes_app/features/Todo_list/screens/home_screen.dart';
import 'package:notes_app/router/router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'features/Themes/theme.dart';
import 'features/Todo_list/models/todo_models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.initFlutter();

  Hive.registerAdapter<Todo>(TodoAdapter());
  await Hive.openBox<Todo>('todos');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TodoProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp.router(
            theme: themeProvider.isDarkTheme ? darkTheme : lightTheme,
            title: 'Flutter Demo',
            routerConfig: MyAppConfig().router,
          );
        },
      ),
    );
  }
}
