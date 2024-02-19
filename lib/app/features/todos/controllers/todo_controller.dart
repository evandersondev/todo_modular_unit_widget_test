import 'package:flutter/material.dart';

import 'package:flutter_tests/app/features/todos/datasources/todo_data_source.dart';
import 'package:flutter_tests/app/features/todos/states/todo_state.dart';

class TodoController extends ValueNotifier<TodoState> {
  TodoController(this.datasource) : super(InitialTodoState());

  final ITodoDataSource datasource;

  Future<void> load() async {
    value = LoadingTodoState();

    final products = await datasource.loadTodos();

    products.onSuccess((success) {
      value = SuccessTodoState(success);
    });

    products.onFailure((failure) {
      value = ErrorTodoState(failure.toString());
    });
  }
}
