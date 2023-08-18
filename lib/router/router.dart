import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/features/Todo_list/screens/bottomNavigation/bottomNav.dart';
import 'package:notes_app/features/splash_screen/splash_screen.dart';

import '../features/Todo_list/models/todo_models.dart';
import '../features/Todo_list/screens/Addsreen/addscreen.dart';

class MyAppConfig {
  GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) {
          return const BottomNav();
        },
      ),
      GoRoute(
        name: 'add',
        path: '/add/:id',
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
        name: 'addscreen',
        path: '/addscreen',
        builder: (context, state) {
          return const AddScreen();
        },
      ),
    ],
  );
}
