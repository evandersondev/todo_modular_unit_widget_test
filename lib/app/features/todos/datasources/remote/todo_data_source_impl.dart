import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import 'package:flutter_tests/app/features/todos/datasources/todo_data_source.dart';
import 'package:flutter_tests/app/features/todos/entities/todo_entity.dart';

class TodoDataSourceImpl implements ITodoDataSource {
  TodoDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<Result<List<TodoEntity>, Exception>> loadTodos() async {
    final result = await dio.get('https://jsonplaceholder.typicode.com/todos/');

    try {
      final list = result.data as List;

      final todos = list.map((todo) => TodoEntity.fromMap(todo)).toList();

      return Result.success(todos);
    } catch (e) {
      return Result.failure(Exception(e.toString()));
    }
  }
}
