import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:result_dart/result_dart.dart';

import 'package:flutter_tests/app/features/todos/datasources/todo_data_source.dart';
import 'package:flutter_tests/app/features/todos/entities/todo_entity.dart';
import 'package:flutter_tests/app/features/todos/pages/todo_page.dart';
import 'package:flutter_tests/app/features/todos/todo_module.dart';

class TodoDataSourceMock extends Mock implements ITodoDataSource {}

void main() {
  late TodoDataSourceMock dataSource;

  setUp(() {
    dataSource = TodoDataSourceMock();

    initModule(TodoModule(), replaceBinds: [
      Bind.instance<ITodoDataSource>(dataSource),
    ]);
  });

  tearDown(() {
    Modular.destroy();
  });

  group('Todo', () {
    testWidgets("Should be find one todo with text: 'TODO_TEST'",
        (WidgetTester tester) async {
      when(() => dataSource.loadTodos()).thenAnswer(
        (_) async => Result.success([
          TodoEntity(id: 1, userId: 1, title: 'TODO_TEST', completed: false)
        ]),
      );

      await tester.pumpWidget(const MaterialApp(home: TodosPage()));
      await tester.pumpAndSettle();

      expect(find.text('TODO_TEST'), findsOneWidget);
    });

    testWidgets("Should be not find todos", (WidgetTester tester) async {
      when(() => dataSource.loadTodos()).thenAnswer(
        (_) async => Result.success([]),
      );

      await tester.pumpWidget(const MaterialApp(home: TodosPage()));
      await tester.pumpAndSettle();

      expect(find.text('todo test'), findsNothing);
    });
  });
}
