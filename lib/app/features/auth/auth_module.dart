import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutter_tests/app/features/auth/controllers/login_controller.dart';
import 'package:flutter_tests/app/features/auth/datasources/login_data_source.dart';
import 'package:flutter_tests/app/features/auth/datasources/remote/login_data_source_impl.dart';
import 'package:flutter_tests/app/features/auth/pages/login_page.dart';
import 'package:flutter_tests/app/features/auth/pages/register_page.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<ILoginDataSource>((i) => LoginDataSourceImpl()),
    Bind.factory((i) => LoginControler(i()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/login', child: (_, args) => const LoginPage()),
    ChildRoute('/register', child: (_, args) => const RegisterPage()),
    // RedirectRoute('/', to: '/login'),
  ];
}
