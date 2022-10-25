// ignore_for_file: depend_on_referenced_packages, camel_case_types, must_be_immutable
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
              const newComplatedTodo(),
              /*
              Expanded(
                child: Text(
                  ref
                      .watch(providerTodo.notifier)
                      .onCompletedTodoCount()
                      .toString(),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ), 
              */
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

  Tooltip newToltip(String listTileWidget, message) {
    return Tooltip(
      message: message,
      child: TextButton(
        onPressed: () {},
        child: Text(listTileWidget),
      ),
    );
  }
}

class newComplatedTodo extends ConsumerWidget {
  const newComplatedTodo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /* int complatedTodos =
        ref.watch(providerTodo.notifier).onCompletedTodoCount(); */
    int complatedTodos =
        ref.watch(providerTodo).where((element) => !element.completed).length;
    return Expanded(
      child: Text(
        complatedTodos == 0
            ? "Yeni Görev ekle"
            : "$complatedTodos görev tamamlanmadı",
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.red,
        ),
      ),
    );
  }
}

class listTileWidget extends ConsumerStatefulWidget {
  TodoModel item;
  listTileWidget({super.key, required this.item});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _listTileWidgetState();
}

class _listTileWidgetState extends ConsumerState<listTileWidget> {
  late FocusNode textFocusNode;
  late TextEditingController textController;
  bool hasFocus = false;

  @override
  void initState() {
    super.initState();
    textFocusNode = FocusNode();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    textFocusNode.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (isFocused) {
        if (!isFocused) {
          setState(
            () {
              hasFocus = false;
            },
          );
          ref.read(providerTodo.notifier).todoEdit(
              id: widget.item.id, newDescription: textController.text);
        }
      },
      child: ListTile(
        onTap: () {
          setState(() {
            hasFocus = true;
            textController.text = widget.item.description;
            textFocusNode.requestFocus();
          });
        },
        title: hasFocus
            ? TextField(
                controller: textController,
                focusNode: textFocusNode,
              )
            : Text(widget.item.description),
        leading: Checkbox(
          value: widget.item.completed,
          onChanged: (value) {
            ref.read(providerTodo.notifier).toggle(widget.item.id);
          },
        ),
      ),
    );
  }
}
