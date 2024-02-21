import 'package:result_dart/result_dart.dart';

import 'package:flutter_tests/app/core/services/app_response.dart';

abstract class IAppClient {
  Future<Result<AppResponse, Failure>> get(
    String url, {
    Map<String, dynamic>? params,
  });
}
