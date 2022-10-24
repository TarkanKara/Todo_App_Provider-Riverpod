// ignore_for_file: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:todo_app/providers/todo_list_manager.dart';
import '../models/todo_model.dart';

//Provider Oluşturma
final providerTodo = StateNotifierProvider<TodoListManager, List<TodoModel>>(
  (ref) {
    //Todo başlangıç verilerini burda belirtebiliriz
    return TodoListManager(
      [
        TodoModel(id: const Uuid().v4(), description: "Spora Git"),
        TodoModel(id: const Uuid().v4(), description: "Alışverişe Git"),
        TodoModel(id: const Uuid().v4(), description: "Okula Git"),
        TodoModel(id: const Uuid().v4(), description: "Yemeğini Ye"),
      ],
    );
  },
);
