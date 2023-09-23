import 'package:flutter/material.dart';
import 'package:flutter_application_7hive_first/homescreen.dart';
import 'package:flutter_application_7hive_first/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  //register the adapter
  Hive.registerAdapter(TodoAdapter());
  // this box only contain todo data
  await Hive.openBox<Todo>('todo');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
