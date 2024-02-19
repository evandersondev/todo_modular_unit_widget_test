import 'package:flutter_tests/app/features/todos/entities/todo_entity.dart';

abstract class TodoState {}

class InitialTodoState extends TodoState {}

class SuccessTodoState extends TodoState {
  final List<TodoEntity> todo;

  SuccessTodoState(this.todo);
}

class ErrorTodoState extends TodoState {
  final String message;

  ErrorTodoState(this.message);
}

class LoadingTodoState extends TodoState {}
