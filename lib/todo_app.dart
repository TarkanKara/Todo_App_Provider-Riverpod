import 'package:flutter/material.dart';

class TodoApp extends StatelessWidget {
  final newTodoController = TextEditingController();
  TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
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
            onSubmitted: (value) {},
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
          const listTileWidget(),
          const listTileWidget(),
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
  const listTileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Spora Git"),
      leading: Checkbox(
        value: true,
        onChanged: (value) {},
      ),
    );
  }
}
