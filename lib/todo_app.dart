// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'models/todo_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/all_providers.dart';

//ConsumerWidget
class TodoApp extends ConsumerWidget {
  TodoApp({super.key});

  final newTodoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allTodos = ref.watch(providerTodo);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              "Todo app",
              style: TextStyle(fontSize: 55, color: Colors.blue),
            ),
          ),
          TextField(
            controller: newTodoController,
            decoration: const InputDecoration(labelText: "Neler Yapacaksın?"),
            onSubmitted: (newTodoText) {
              ref.read(providerTodo.notifier).addTodo(newTodoText);
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text("4 Todos"),
              ),
              newToltip("All", "All todos"),
              newToltip("Active", "Only Uncompleted todo"),
              newToltip("Completed", "Only completed todo"),
            ],
          ),
          for (var i = 0; i < allTodos.length; i++)
            //Dismissible Widgeti sağa ve soğa kaydırarak silme işlemi
            Dismissible(
              background: Container(color: Colors.red),
              key: ValueKey(allTodos[i].id),
              onDismissed: (_) {
                ref.read(providerTodo.notifier).removeTodo(allTodos[i]);
              },
              child: listTileWidget(item: allTodos[i]),
            ),
        ],
      ),
    );
  }

  Tooltip newToltip(String name, message) {
    return Tooltip(
      message: message,
      child: TextButton(
        onPressed: () {},
        child: Text(name),
      ),
    );
  }
}

class listTileWidget extends StatelessWidget {
  TodoModel item;
  listTileWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.description),
      leading: Checkbox(
        value: true,
        onChanged: (value) {},
      ),
    );
  }
}
