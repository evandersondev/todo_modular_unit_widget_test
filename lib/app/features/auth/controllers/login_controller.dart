import 'package:flutter/material.dart';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter_tests/app/features/auth/datasources/login_data_source.dart';
import 'package:flutter_tests/app/features/auth/dtos/login_dto.dart';
import 'package:flutter_tests/app/features/auth/states/login_state.dart';

class LoginControler extends ValueNotifier<LoginState> {
  LoginControler(this._datasoure) : super(InitialLoginState());

  final ILoginDataSource _datasoure;

  Future<void> login(LoginDto dto) async {
    value = LoadingLoginState();

    final result = await _datasoure(dto);

    result.onSuccess((_) async {
      value = SuccessLoginState();

      const storage = FlutterSecureStorage();
      final jwt = JWT({'id': 123, 'email': dto.email});

      final token = jwt.sign(SecretKey('pag.ai'));
      await storage.write(key: 'token', value: token);
    });

    result.onFailure((failure) {
      value = ErrorLoginState(failure.message);
    });
  }
}
