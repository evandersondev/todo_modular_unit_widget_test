import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutter_tests/app/core/guards/auth_guard.dart';
import 'package:flutter_tests/app/features/todos/controllers/todo_controller.dart';
import 'package:flutter_tests/app/features/todos/datasources/remote/todo_data_source_impl.dart';
import 'package:flutter_tests/app/features/todos/datasources/todo_data_source.dart';
import 'package:flutter_tests/app/features/todos/pages/todo_page.dart';

class TodoModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory<Dio>((i) => Dio()),
    Bind.lazySingleton<ITodoDataSource>((i) => TodoDataSourceImpl(i())),
    Bind.factory<TodoController>((i) => TodoController(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => const TodosPage(),
      guards: [AuthGuard()],
    ),
  ];
}
