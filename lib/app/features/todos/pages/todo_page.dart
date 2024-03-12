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
        elevation: 0,
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
            final totalChecked = value.todo.where((e) => e.completed == true).toList().length;

            return Column(
              children: [
                Container(
                  color: Colors.purple.shade800,
                  child: ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      title: Text('$totalChecked/${value.todo.length} todos encontrados', style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white,
                      ),),
                  ),
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: value.todo.length,
                    padding: const EdgeInsets.all(12.0),
                    itemBuilder: (context, index) {
                      final todo = value.todo[index];

                      return Column(
                        children: [
                          CheckboxListTile (
                            value: todo.completed,
                            onChanged: (value) {
                              todoController.check(todo);
                            },
                            title: Text(
                              todo.title,
                              style: TextStyle(
                                decoration: todo.completed
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                          ),
                          const Divider()
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const Center(
            child: Text('No data yet.'),
          );
        },
      ),
    );
  }
}
