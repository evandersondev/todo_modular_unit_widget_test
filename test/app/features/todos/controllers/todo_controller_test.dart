import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:result_dart/result_dart.dart';

import 'package:flutter_tests/app/features/todos/controllers/todo_controller.dart';
import 'package:flutter_tests/app/features/todos/datasources/todo_data_source.dart';
import 'package:flutter_tests/app/features/todos/states/todo_state.dart';
import 'package:flutter_tests/app/features/todos/todo_module.dart';

class TodoDataSourceMock extends Mock implements ITodoDataSource {}

void main() {
  late TodoDataSourceMock dataSource;
  late TodoController controller;

  setUp(() {
    dataSource = TodoDataSourceMock();

    initModule(TodoModule(), replaceBinds: [
      Bind.instance<ITodoDataSource>(dataSource),
    ]);

    controller = Modular.get<TodoController>();
  });

  tearDown(() {
    Modular.destroy();
  });

  group("TodoController |", () {
    test('Should be instance of SuccessTodoState', () async {
      when(() => dataSource.loadTodos()).thenAnswer(
        (_) async => Result.success([]),
      );

      await controller.load();

      expect(controller.value, isA<SuccessTodoState>());
    });

    test('Should be instance of ErrorTodoState', () async {
      when(() => dataSource.loadTodos()).thenAnswer(
        (_) async => Result.failure(Exception('Ops!')),
      );

      await controller.load();

      expect(controller.value, isA<ErrorTodoState>());
    });
  });
}
