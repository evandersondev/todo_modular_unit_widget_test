import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:result_dart/result_dart.dart';

import 'package:flutter_tests/app/core/services/app_client.dart';
import 'package:flutter_tests/app/core/services/app_response.dart';
import 'package:flutter_tests/app/features/todos/datasources/todo_data_source.dart';
import 'package:flutter_tests/app/features/todos/entities/todo_entity.dart';
import 'package:flutter_tests/app/features/todos/todo_module.dart';

import '../../todo_success_mock.dart';

class ClientMock extends Mock implements IAppClient {}

void main() {
  late IAppClient clientMock;
  late ITodoDataSource sut;

  setUp(() {
    clientMock = ClientMock();

    initModule(TodoModule(), replaceBinds: [
      Bind.instance<IAppClient>(clientMock),
    ]);

    sut = Modular.get<ITodoDataSource>();
  });

  tearDown(() {
    Modular.destroy();
  });

  group("TodoDataSource |", () {
    test('Should to load todos with success', () async {
      when(() => clientMock.get(any())).thenAnswer(
        (_) async => Result.success(AppResponse(
          data: jsonDecode(todoSuccessMock),
          code: 200,
        )),
      );

      (await sut.loadTodos()).fold(
        (success) {
          expect(success, isInstanceOf<List<TodoEntity>>());
        },
        (failure) => failure,
      );
    });

    test('Should to show message error with failure', () async {
      when(() => clientMock.get(any())).thenAnswer(
        (_) async => Result.failure(
          const Failure('Ops!'),
        ),
      );

      (await sut.loadTodos()).fold(
        (success) => success,
        (failure) {
          expect(failure, isInstanceOf<Exception>());
        },
      );
    });
  });
}
