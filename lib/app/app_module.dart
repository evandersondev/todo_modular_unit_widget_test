import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutter_tests/app/features/auth/auth_module.dart';
import 'package:flutter_tests/app/features/todos/todo_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: AuthModule()),
    ModuleRoute('/todos', module: TodoModule()),
  ];
}
