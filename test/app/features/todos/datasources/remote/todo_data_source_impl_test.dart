import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

import 'package:flutter_tests/app/features/todos/datasources/todo_data_source.dart';
import 'package:flutter_tests/app/features/todos/entities/todo_entity.dart';
import 'package:flutter_tests/app/features/todos/todo_module.dart';

import '../../todo_success_mock.dart';

class DioMock extends Mock implements Dio {}

void main() {
  late DioMock dioMock;
  late ITodoDataSource service;

  setUp(() {
    dioMock = DioMock();

    initModule(TodoModule(), replaceBinds: [
      Bind.instance<Dio>(dioMock),
    ]);

    service = Modular.get<ITodoDataSource>();
  });

  tearDown(() {
    Modular.destroy();
  });

  group("TodoDataSource |", () {
    test('Should to load todos with success', () async {
      when(() => dioMock.get(any())).thenAnswer(
        (_) async => Response(
          data: jsonDecode(todoSuccessMock),
          requestOptions: RequestOptions(),
          statusCode: 200,
        ),
      );

      (await service.loadTodos()).fold(
        (success) {
          expect(success, isInstanceOf<List<TodoEntity>>());
        },
        (failure) => failure,
      );
    });

    test('Should to show message error with failure', () async {
      when(() => dioMock.get(any())).thenAnswer(
        (_) async => Response(
            requestOptions: RequestOptions(),
            statusCode: 400,
            statusMessage: 'Ops!'),
      );

      (await service.loadTodos()).fold(
        (success) => success,
        (failure) {
          expect(failure, isInstanceOf<Exception>());
        },
      );
    });
  });
}
