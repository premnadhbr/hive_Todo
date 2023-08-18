import 'package:flutter/material.dart';
import 'package:flutter_application_7hive_first/todo.dart';
import 'package:hive/hive.dart';

class updateuser extends StatefulWidget {
  final String username;
  updateuser({super.key, required this.username});

  @override
  State<updateuser> createState() => _updateuserState();
}

class _updateuserState extends State<updateuser> {
  TextEditingController textEditingController = TextEditingController();

  Box todobox = Hive.box<Todo>('todo');

  @override
  void initState() {
    textEditingController = TextEditingController(text: widget.username);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: textEditingController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => updateuser(context),
                child: const Text(
                  'Update Todo',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void updateuser(BuildContext context) {
    String updatedTitle = textEditingController.text;

    if (updatedTitle.isNotEmpty) {
      for (int index = 0; index < todobox.length; index++) {
        Todo oldTodo = todobox.getAt(index);
        if (oldTodo.title == widget.username) {
          Todo updatedTodo = Todo(
            title: updatedTitle,
            isComplete: oldTodo.isComplete,
          );
          todobox.putAt(index, updatedTodo);
          break;
        }
      }

      Navigator.pop(context);
    }
  }
}
