// ignore_for_file: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:uuid/uuid.dart';

//Ana state olan içersinde todo ların olduğu bir liste
//Liste dışardan aldığı parametre ile başlatılabilir
//İçerisnde TodoModel olan liste verme işlemi
//[List<TodoModel>? initialTodos] Kullanıcı listeyti girmek zorunda değil boşda olabilir.
//initialTodos boş ise boş bir dizi döndürmeli
//super(initialTodos ?? [])
class TodoListManager extends StateNotifier<List<TodoModel>> {
  TodoListManager([List<TodoModel>? initialTodos]) : super(initialTodos ?? []);

  //Yeni bir todo ekleme
  void addTodo(String description) {
    var todoAdd = TodoModel(id: const Uuid().v4(), description: description);
    state = [...state, todoAdd];
  }

  //Todo completed yapma işlemi
  void toggle(String id) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
            id: todo.id,
            description: todo.description,
            completed: !todo.completed,
          )
        else
          todo,
    ];
  }

  //Todo Düzenleme işlemi
  void todoEdit({required String id, required String newDescription}) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
            id: todo.id,
            description: newDescription,
            completed: todo.completed,
          )
        else
          todo,
    ];
  }

  //Todo kaldırma işlemi
  void removeTodo(TodoModel removeTodoss) {
    state = state.where((element) => element.id != removeTodoss.id).toList();
  }

  //Tamamlanmamış Todo Sayısı
  int onCompletedTodoCount() {
    return state.where((element) => !element.completed).length;
  }
}
