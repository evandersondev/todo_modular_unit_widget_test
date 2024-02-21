import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:result_dart/result_dart.dart';

import 'package:flutter_tests/app/features/auth/auth_module.dart';
import 'package:flutter_tests/app/features/auth/controllers/login_controller.dart';
import 'package:flutter_tests/app/features/auth/datasources/login_data_source.dart';
import 'package:flutter_tests/app/features/auth/dtos/login_dto.dart';
import 'package:flutter_tests/app/features/auth/states/login_state.dart';

class LoginDataSourceMock extends Mock implements ILoginDataSource {}

void main() {
  late FlutterSecureStorage storage;
  late ILoginDataSource dataSourceMock;
  late LoginControler sut;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    storage = const FlutterSecureStorage();
    dataSourceMock = LoginDataSourceMock();

    initModule(AuthModule(), replaceBinds: [
      Bind.instance<ILoginDataSource>(dataSourceMock),
    ]);

    sut = Modular.get<LoginControler>();
  });

  tearDown(() {
    Modular.destroy();
  });

  final loginDtoMock = LoginDto(
    email: 'test@mail.com',
    password: '123',
  );

  group('LoginController |', () {
    test('Shoud be instanceOf SuccessLoginState', () async {
      when(() => dataSourceMock(loginDtoMock)).thenAnswer(
        (_) async => Result.success(0),
      );

      await sut.login(loginDtoMock).then((_) {
        expect(sut.value, isA<SuccessLoginState>());
      });
    });

    test('Shoud be save token in local storage', () async {
      when(() => dataSourceMock(loginDtoMock)).thenAnswer(
        (_) async => Result.success(0),
      );

      await sut.login(loginDtoMock).then((_) async {
        final token = storage.read(key: 'token');

        expect(() => token, isNotNull);
      });
    });
  });
}
