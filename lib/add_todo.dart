import 'package:flutter/material.dart';
import 'package:flutter_application_7hive_first/todo.dart';
import 'package:hive/hive.dart';

class AddTodo extends StatelessWidget {
  AddTodo({super.key});
  TextEditingController textEditingController = TextEditingController();

  Box todobox = Hive.box<Todo>('todo');

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
                onPressed: () => addnote(context),
                child: const Text(
                  'Add Todo',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  addnote(BuildContext context) {
    if (textEditingController.text != '') {
      Todo newtodo = Todo(title: textEditingController.text, isComplete: false);
      todobox.add(newtodo);
      Navigator.pop(context);
    }
  }
}
