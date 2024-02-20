import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:result_dart/result_dart.dart';

import 'package:flutter_tests/app/features/auth/auth_module.dart';
import 'package:flutter_tests/app/features/auth/datasources/login_data_source.dart';
import 'package:flutter_tests/app/features/auth/dtos/login_dto.dart';
import 'package:flutter_tests/app/features/auth/pages/login_page.dart';

class LoginDataSourseMock extends Mock implements ILoginDataSource {}

void main() {
  late ILoginDataSource dataSource;

  setUpAll(() {
    dataSource = LoginDataSourseMock();

    initModule(AuthModule(), replaceBinds: [
      Bind.instance<ILoginDataSource>(dataSource),
    ]);
  });

  tearDownAll(() {
    Modular.destroy();
  });

  final loginDtoMock = LoginDto(
    email: 'test@mail.com',
    password: '123',
  );

  group('Login Page', () {
    testWidgets('Should can do login', (tester) async {
      when(() => dataSource(loginDtoMock)).thenAnswer(
        (_) async => Result.success(0),
      );

      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      final emailInput = find.byKey(const Key('email-input-login'));
      final passwordInput = find.byKey(const Key('email-input-login'));
      final buttonLogin = find.byKey(const Key('button-login'));

      await tester.enterText(emailInput, loginDtoMock.email);
      await tester.pumpAndSettle();
      await tester.enterText(passwordInput, loginDtoMock.password);
      await tester.pumpAndSettle();

      await tester.tap(buttonLogin);
      await tester.pump();

      expect(find.byType(AppBar), findsOneWidget);
    });
  });
}
