import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/todo_models.dart';
import '../provider/todo_provider.dart';

class AddScreen extends StatefulWidget {
  final Todo? todo;
  final int? index;
  const AddScreen({super.key, this.todo, this.index});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    if (widget.todo != null) {
      titleController = TextEditingController(text: widget.todo!.title);
      contentController = TextEditingController(text: widget.todo!.description);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int? myindex = widget.index;
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    TextStyle? style = Theme.of(context).textTheme.titleLarge;

    //
    void saveButton(BuildContext context) {
      if (widget.todo == null && widget.index == null) {
        final title = titleController.text;
        final description = contentController.text;
        if (title.isNotEmpty && description.isNotEmpty) {
          final todo = Todo(
            title: title,
            description: description,
            isCompleted: false,
          );
          todoProvider.addTodo(todo);
          Navigator.pop(context);
          final snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: const Text('Todo added'),
            action: SnackBarAction(
              label: 'Undo',
              textColor: Colors.white,
              onPressed: () {},
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (title.isEmpty || description.isEmpty) {
          final snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: const Text('Please fill out'),
            action: SnackBarAction(
              label: 'Undo',
              textColor: Colors.white,
              onPressed: () {},
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        final title = titleController.text;
        final description = contentController.text;
        if (title.isNotEmpty && description.isNotEmpty) {
          final todo = Todo(title: title, description: description);
          todoProvider.updateTodo(myindex!, todo);

          final snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: const Text('Todo updated'),
            action: SnackBarAction(
              label: 'Undo',
              textColor: Colors.white,
              onPressed: () {},
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pop(context);
        }
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: const EdgeInsets.all(0),
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: style!.color,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    saveButton(context);
                  },
                  padding: const EdgeInsets.all(0),
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.save,
                      //  color: style.color,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: ListView(
              children: [
                TextFormField(
                  controller: titleController,
                  cursorColor: style.color,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 30),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 30),
                  ),
                ),
                TextFormField(
                  controller: contentController,
                  cursorColor: style.color,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type something here...',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 17),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
