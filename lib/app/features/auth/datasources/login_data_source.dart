import 'package:result_dart/result_dart.dart';

import 'package:flutter_tests/app/core/failures/failure_exception.dart';
import 'package:flutter_tests/app/features/auth/dtos/login_dto.dart';

abstract class ILoginDataSource {
  Future<Result<void, FailureException>> call(LoginDto dto);
}
