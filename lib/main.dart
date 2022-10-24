// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:todo_app/todo_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//ProviderScope
void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO APP',
      home: TodoApp(),
    );
  }
}
