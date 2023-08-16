import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../Todo_list/models/todo_models.dart';

class ArchiveProvider extends ChangeNotifier {
  Box<Todo> archiveBox = Hive.box<Todo>('archive');
  List<Todo> get archiveTodos => archiveBox.values.toList();
  void addToarchive(Todo todo) {
    archiveBox.add(todo);
    notifyListeners();
  }

  void toggleTodoStatus(int index) {
    final todo = archiveBox.getAt(index);
    todo!.isCompleted = !todo.isCompleted;
    todo.save();
    notifyListeners();
  }

  void removeFromArchive(int index) {
    archiveBox.deleteAt(index);
    notifyListeners();
  }

  void updateArchive(int index, Todo todo) {
    archiveBox.putAt(index, todo);
    notifyListeners();
  }
}
