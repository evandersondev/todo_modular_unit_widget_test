import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutter_tests/app/features/todos/controllers/todo_controller.dart';
import 'package:flutter_tests/app/features/todos/states/todo_state.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  final todoController = Modular.get<TodoController>();

  @override
  void initState() {
    super.initState();

    todoController.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('T O D O S'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: todoController,
        builder: (context, value, child) {
          if (value is LoadingTodoState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (value is ErrorTodoState) {
            return AlertDialog(
              content: Text(value.message),
            );
          }

          if (value is SuccessTodoState) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: value.todo.length,
                itemBuilder: (context, index) {
                  final todo = value.todo[index];

                  return ListTile(
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        decoration: todo.completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    leading: Checkbox(
                      value: todo.completed,
                      onChanged: (value) {},
                    ),
                  );
                },
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
