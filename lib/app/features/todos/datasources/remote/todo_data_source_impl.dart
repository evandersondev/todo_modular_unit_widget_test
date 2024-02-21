import 'package:result_dart/result_dart.dart';

import 'package:flutter_tests/app/core/constants/app_url.dart';
import 'package:flutter_tests/app/core/services/app_client.dart';
import 'package:flutter_tests/app/features/todos/datasources/todo_data_source.dart';
import 'package:flutter_tests/app/features/todos/entities/todo_entity.dart';

class TodoDataSourceImpl implements ITodoDataSource {
  TodoDataSourceImpl(this.client);

  final IAppClient client;

  @override
  Future<Result<List<TodoEntity>, Exception>> loadTodos() async {
    final result = await client.get(AppUrl.todoBaseUrl);

    return result.fold((success) {
      final list = success.data as List;

      final todos = list.map((todo) => TodoEntity.fromMap(todo)).toList();

      return Result.success(todos);
    }, (failure) {
      return Result.failure(Exception(failure));
    });
  }
}
