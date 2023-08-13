import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/features/Todo_list/screens/home_screen.dart';

import '../features/Todo_list/models/todo_models.dart';
import '../features/Todo_list/screens/addscreen.dart';

class MyAppConfig {
  GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'addscreen',
        path: '/addscreen/:id',
        pageBuilder: (context, state) {
          Todo? todo = state.extra as Todo?;

          final idStr = state.pathParameters['id'];
          final id = idStr != null ? int.tryParse(idStr) : null;

          return MaterialPage(
              child: AddScreen(
            todo: todo,
            index: id,
          ));
        },
      ),
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: '/add',
        builder: (context, state) {
          return const AddScreen();
        },
      ),
    ],
  );
}
