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

final unCompletedTodoCount = Provider<int>(
  (ref) {
    final allTodo = ref.watch(providerTodo);
    final count = allTodo.where((element) => !element.completed).length;
    return count;
  },
);

enum TodoListFilter { all, active, completed }

final todoListFilter =
    StateProvider<TodoListFilter>(((ref) => TodoListFilter.all));

final filteredTodoList = Provider<List<TodoModel>>(
  (ref) {
    final filter = ref.watch(todoListFilter);
    final todoList = ref.watch(providerTodo);

    switch (filter) {
      case TodoListFilter.all:
        return todoList;

      case TodoListFilter.active:
        return todoList.where((element) => element.completed).toList();

      case TodoListFilter.completed:
        return todoList.where((element) => !element.completed).toList();
    }
  },
);
