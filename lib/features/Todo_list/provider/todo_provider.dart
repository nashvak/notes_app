import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/todo_models.dart';

class TodoProvider extends ChangeNotifier {
  Box<Todo> todoBox = Hive.box<Todo>('todos');

  List<Todo> get todos => todoBox.values.toList();

  void addTodo(Todo todo) async {
    await todoBox.add(todo);
    notifyListeners();
  }

  void toggleTodoStatus(int index) {
    final todo = todoBox.getAt(index);
    todo!.isCompleted = !todo.isCompleted;
    todo.save();
    notifyListeners();
  }

  void removeTodo(int index) {
    todoBox.deleteAt(index);
    notifyListeners();
  }

  void updateTodo(int index, Todo todo) {
    todoBox.putAt(index, todo); //use save method
    notifyListeners();
  }
}
