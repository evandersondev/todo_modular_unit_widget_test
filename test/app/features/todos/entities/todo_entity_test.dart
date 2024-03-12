import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_tests/app/features/todos/entities/todo_entity.dart';

void main() {
  test('Should be instance of TodoEntity', () {
    final todoMap = {
      "userId": 1,
      "id": 1,
      "title": 'Lorem ipsum',
      "completed": false
    };

    final todoEntity = TodoEntity.fromMap(todoMap);

    expect(todoEntity, isInstanceOf<TodoEntity>());
    expect(todoEntity.title, equals('Lorem ipsum'));
  });
}
