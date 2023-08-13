import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/features/Todo_list/screens/addscreen.dart';
import 'package:notes_app/features/Todo_list/screens/appbar.dart';
import 'package:provider/provider.dart';

import '../../../widgets/constants.dart';
import '../models/todo_models.dart';
import '../provider/todo_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  getRandomColors() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
        child: Column(
          children: [
            FirstAppbar(),
            height20,
            TextField(
              /*controller: search,
      //cursorColor: cursor!.color,
      onChanged: (val) {
        provider.onSearchTextChanged(val);
      },*/
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 16),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                hintText: "Search notes...",
                hintStyle: Theme.of(context).textTheme.titleSmall,
                prefixIcon: Icon(
                  Icons.search,
                  //color: style!.color,
                ),
                fillColor: Theme.of(context).colorScheme.primary,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
              ),
            ),
            Expanded(
                child: ValueListenableBuilder<Box<Todo>>(
              valueListenable: todoProvider.todoBox.listenable(),
              builder: (context, box, child) {
                final tasks = todoProvider.todos;
                if (box.isEmpty) {
                  return Center(
                    child: Text(
                      "No todo",
                      // style: Theme.of(context).textTheme.titleMedium,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      int myIndex = index;
                      final todo = tasks[index];
                      return Slidable(
                        key: const ValueKey(0),
                        startActionPane: ActionPane(
                            dismissible: DismissiblePane(
                              onDismissed: () {},
                            ),
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) => {},
                                /* borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),*/
                                backgroundColor: Colors.orange.shade300,
                                foregroundColor: Colors.white,
                                icon: Icons.favorite_border,
                                //label: 'Delete',
                              ),
                            ]),
                        endActionPane: ActionPane(
                          motion: const DrawerMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                todoProvider.removeTodo(myIndex);
                                final snackBar = SnackBar(
                                  backgroundColor: Colors.red,
                                  content: const Text('Todo deleted'),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    textColor: Colors.white,
                                    onPressed: () {},
                                  ),
                                );

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              //label: 'Delete',
                            ),
                            SlidableAction(
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
                              backgroundColor: Color(0xFF21B7CA),
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              //label: 'Edit',
                            ),
                          ],
                        ),
                        child: Card(
                          color: getRandomColors(),
                          elevation: 3,
                          child: ListTile(
                            onTap: () {
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
                            title: RichText(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                  text: '${tasks[index].title}\n',
                                  //style: Theme.of(context).textTheme.bodyMedium,
                                  children: [
                                    TextSpan(
                                      text: tasks[index].description,
                                      /* style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                          ),*/
                                    )
                                  ]),
                            ),
                            trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                ),
                                onPressed: () {
                                  todoProvider.removeTodo(myIndex);
                                  final snackBar = SnackBar(
                                    backgroundColor: Colors.red,
                                    content: const Text('Todo deleted'),
                                    action: SnackBarAction(
                                      label: 'Undo',
                                      textColor: Colors.white,
                                      onPressed: () {},
                                    ),
                                  );

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }),
                            leading: Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.black,
                              ),
                              child: Checkbox(
                                activeColor: Colors.black,
                                value: todo.isCompleted,
                                onChanged: (_) =>
                                    todoProvider.toggleTodoStatus(myIndex),
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
      floatingActionButton: SizedBox(
        height: 50,
        width: 50,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddScreen()));
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          child: Icon(
            Icons.add,
            size: 30,
            //color: style!.color,
          ),
        ),
      ),
    );
  }
}
