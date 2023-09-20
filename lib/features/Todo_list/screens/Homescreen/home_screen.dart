import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:hive_flutter/adapters.dart';

import 'package:notes_app/features/Todo_list/screens/Addsreen/addscreen.dart';

import 'package:notes_app/features/Todo_list/screens/Homescreen/appbar.dart';
import 'package:notes_app/features/Todo_list/screens/Homescreen/floating_action.dart';
import 'package:notes_app/features/Todo_list/screens/Homescreen/searchbar.dart';
import 'package:notes_app/features/Todo_list/screens/Homescreen/todo_cards.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/constants.dart';
import '../../../Archive_section/provider/archive_provider.dart';
import '../../models/todo_models.dart';
import '../../provider/todo_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void snackbar(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: const Color.fromARGB(255, 34, 34, 34),
      duration: const Duration(seconds: 1),
      action: SnackBarAction(
        label: 'Cancel',
        textColor: Colors.white,
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    //print('build');
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    final archive = Provider.of<ArchiveProvider>(context, listen: false);
    TextStyle? style = Theme.of(context).textTheme.titleSmall;
    TextStyle? cursor = Theme.of(context).textTheme.titleMedium;
    TextStyle? icons = Theme.of(context).textTheme.titleLarge;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
        child: Column(
          children: [
            const FirstAppbar(),
            height20,
            Searchbar(cursor: cursor, style: style),
            Expanded(
                child: ValueListenableBuilder<Box<Todo>>(
              valueListenable: todoProvider.todoBox.listenable(),
              builder: (context, box, child) {
                final tasks = todoProvider.todos;
                if (box.isEmpty) {
                  return Center(
                    child: Text(
                      "No todo",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      int myIndex = index;
                      final todo = tasks[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Slidable(
                          key: UniqueKey(),
                          startActionPane: ActionPane(
                              dismissible: DismissiblePane(
                                // key: UniqueKey(),
                                onDismissed: () {
                                  todoProvider.removeTodo(myIndex);
                                  archive.addToarchive(tasks[myIndex]);
                                  snackbar('Moved to archive ');
                                },
                              ),
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    todoProvider.removeTodo(myIndex);
                                    archive.addToarchive(tasks[myIndex]);
                                    snackbar('Moved to archive ');
                                  },
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                  backgroundColor: Colors.orange.shade300,
                                  foregroundColor: Colors.white,

                                  icon: Icons.archive,
                                  //label: 'Delete',
                                ),
                              ]),
                          endActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            children: [
                              SlidableAction(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                onPressed: (context) {
                                  todoProvider.removeTodo(myIndex);
                                  snackbar('Todo deleted');
                                },
                                backgroundColor: const Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                //label: 'Delete',
                              ),
                              SlidableAction(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                onPressed: (context) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddScreen(
                                        index: myIndex,
                                        todo: tasks[myIndex],
                                      ),
                                    ),
                                  );
                                },
                                backgroundColor: const Color(0xFF21B7CA),
                                foregroundColor: Colors.white,

                                icon: Icons.edit,
                                //label: 'Edit',
                              ),
                            ],
                          ),
                          child: TodoCards(
                              myIndex: myIndex,
                              tasks: tasks,
                              todo: todo,
                              todoProvider: todoProvider),
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
      floatingActionButton: FloatingActionBtn(icons: icons),
    );
  }
}
