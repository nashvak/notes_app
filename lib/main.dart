import 'dart:io';

import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';

import 'package:notes_app/features/Themes/theme_provider.dart';
import 'package:notes_app/features/Todo_list/provider/todo_provider.dart';

import 'package:notes_app/features/splash_screen/splash_screen.dart';

import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'features/Archive_section/provider/archive_provider.dart';
import 'features/Themes/theme.dart';
import 'features/Todo_list/models/todo_models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.initFlutter();

  Hive.registerAdapter<Todo>(TodoAdapter());
  await Hive.openBox<Todo>('todos');
  await Hive.openBox<Todo>('archive');
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
        ChangeNotifierProvider(create: (context) => ArchiveProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            theme: themeProvider.isDarkTheme ? darkTheme : lightTheme,
            title: 'Notes app',
            debugShowCheckedModeBanner: false,
            // routes: {
            //   '/': (context) => const SplashScreen(),
            //   'bottom': (context) => const BottomNav(),
            //   'add': (context) => const AddScreen(),
            //   'archive': (context) => const ArchiveScreen(),
            //   'home': (context) => const HomeScreen(),
            // },
            // initialRoute: '/',
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
