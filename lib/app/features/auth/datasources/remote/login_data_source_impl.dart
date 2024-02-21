import 'package:result_dart/result_dart.dart';

import 'package:flutter_tests/app/core/failures/failure_exception.dart';
import 'package:flutter_tests/app/features/auth/datasources/login_data_source.dart';
import 'package:flutter_tests/app/features/auth/dtos/login_dto.dart';

class LoginDataSourceImpl implements ILoginDataSource {
  @override
  Future<Result<void, FailureException>> call(LoginDto dto) async {
    await Future.delayed(const Duration(seconds: 2));

    if (dto.email != 'test@mail.com' && dto.password != '123') {
      return Result.success(0);
    }

    return Result.failure(FailureException('Ops, Login error!'));
  }
}
