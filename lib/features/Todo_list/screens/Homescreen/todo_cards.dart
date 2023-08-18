import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../widgets/constants.dart';
import '../../models/todo_models.dart';
import '../../provider/todo_provider.dart';

class TodoCards extends StatelessWidget {
  const TodoCards({
    super.key,
    required this.myIndex,
    required this.tasks,
    required this.todo,
    required this.todoProvider,
  });

  final int myIndex;
  final List<Todo> tasks;
  final Todo todo;
  final TodoProvider todoProvider;
  getRandomColors() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: getRandomColors(),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        onTap: () {
          /* Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddScreen(
                index: myIndex,
                todo: tasks[myIndex],
              ),
            ),
          );
          */
          context.go('/add/$myIndex', extra: tasks[myIndex]);
        },
        title: RichText(
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
              text: '${tasks[myIndex].title}\n',
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: tasks[myIndex].description,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                )
              ]),
        ),
        leading: Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: Colors.black,
          ),
          child: Checkbox(
            activeColor: Colors.black,
            value: todo.isCompleted,
            onChanged: (_) => todoProvider.toggleTodoStatus(myIndex),
          ),
        ),
      ),
    );
  }
}
