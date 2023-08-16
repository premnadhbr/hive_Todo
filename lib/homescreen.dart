import 'package:flutter/material.dart';
import 'package:flutter_application_7hive_first/add_todo.dart';
import 'package:flutter_application_7hive_first/dialogbox.dart';
import 'package:flutter_application_7hive_first/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController tx = TextEditingController();
  Box todobox = Hive.box<Todo>('todo');

  void updateTodoAt(int index, Todo updatedTodo) {
    todobox.putAt(index, updatedTodo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HIVE TODO '),
      ),
      body: ValueListenableBuilder(
        valueListenable: todobox.listenable(),
        builder: (context, Box box, child) {
          if (box.isEmpty) {
            return const Center(
              child: Text('No Data Available '),
            );
          } else {
            return ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: box.length,
              itemBuilder: (context, index) {
                Todo todo = box.getAt(index);
                return ListTile(
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: todo.isComplete ? Colors.green : Colors.black,
                      decoration: todo.isComplete
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  leading: Checkbox(
                    value: todo.isComplete,
                    onChanged: (value) {
                      Todo newtodo =
                          Todo(title: todo.title, isComplete: value!);
                      box.putAt(index, newtodo);
                    },
                  ),
                  trailing: Container(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return DialogBox(
                                  controller: tx,
                                  onsave: () {
                                    String updatedTitle = tx.text;
                                    Todo updatedTodo = Todo(
                                      title: updatedTitle,
                                      isComplete: todo.isComplete,
                                    );
                                    updateTodoAt(index, updatedTodo);
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text("Todo updated successfully !"),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            box.deleteAt(index);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Todo deleted successfully !")));
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  tileColor: Colors.yellow,
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return AddTodo();
            },
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
