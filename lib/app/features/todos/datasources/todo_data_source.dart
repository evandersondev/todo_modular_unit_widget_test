import 'package:result_dart/result_dart.dart';

import 'package:flutter_tests/app/features/todos/entities/todo_entity.dart';

abstract class ITodoDataSource {
  Future<Result<List<TodoEntity>, Exception>> loadTodos();
}
