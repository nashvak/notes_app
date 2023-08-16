import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/features/Todo_list/provider/todo_provider.dart';

import 'package:provider/provider.dart';

import '../Todo_list/models/todo_models.dart';
import 'archive_provider.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final archive = Provider.of<ArchiveProvider>(context);
    final todoProvider = Provider.of<TodoProvider>(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'A R C H I V E',
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
            Expanded(
                child: ValueListenableBuilder<Box<Todo>>(
              valueListenable: archive.archiveBox.listenable(),
              builder: (context, box, child) {
                final tasks = archive.archiveTodos;
                if (box.isEmpty) {
                  return Center(
                    child: Text(
                      "No Archives",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final todo = tasks[index];
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Slidable(
                          key: UniqueKey(),
                          endActionPane: ActionPane(
                              dismissible: DismissiblePane(
                                onDismissed: () {
                                  archive.removeFromArchive(index);
                                  todoProvider.addTodo(tasks[index]);
                                },
                              ),
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    archive.removeFromArchive(index);
                                    todoProvider.addTodo(tasks[index]);
                                  },
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                  backgroundColor: Colors.orange.shade300,
                                  foregroundColor: Colors.white,

                                  icon: Icons.unarchive,
                                  //label: 'Delete',
                                ),
                              ]),
                          child: Card(
                            color: const Color(0xFFCCE5FF),
                            elevation: 3,
                            child: ListTile(
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
                                context.go('/add/$index', extra: tasks[index]);
                              },
                              title: RichText(
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                    text: '${tasks[index].title}\n',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                      TextSpan(
                                        text: tasks[index].description,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                            ),
                                      )
                                    ]),
                              ),
                              trailing: IconButton(
                                  onPressed: () =>
                                      archive.removeFromArchive(index),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.grey,
                                  )),
                              leading: Theme(
                                data: Theme.of(context).copyWith(
                                  unselectedWidgetColor: Colors.black,
                                ),
                                child: Checkbox(
                                  activeColor: Colors.black,
                                  value: todo.isCompleted,
                                  onChanged: (_) =>
                                      archive.toggleTodoStatus(index),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
