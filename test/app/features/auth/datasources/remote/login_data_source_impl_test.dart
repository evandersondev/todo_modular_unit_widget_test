import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';
import 'package:result_dart/result_dart.dart';

import 'package:flutter_tests/app/core/failures/failure_exception.dart';
import 'package:flutter_tests/app/features/auth/auth_module.dart';
import 'package:flutter_tests/app/features/auth/datasources/login_data_source.dart';
import 'package:flutter_tests/app/features/auth/dtos/login_dto.dart';

void main() {
  late ILoginDataSource sut;

  setUp(() {
    initModule(AuthModule());

    sut = Modular.get<ILoginDataSource>();
  });

  tearDown(() {
    Modular.destroy();
  });

  final loginDtoMock = LoginDto(
    email: 'test@mail.com',
    password: '123',
  );

  group('LoginDataSource |', () {
    test('Should be login when success', () async {
      await sut(loginDtoMock);

      expect(sut.toSuccess(), isInstanceOf<Success>());
    });

    test('Should be failure when dto not accept', () async {
      final result = await sut(LoginDto(email: '', password: '123'));

      result.fold((_) {}, (failure) {
        expect(failure, isInstanceOf<FailureException>());
      });
    });
  });
}
