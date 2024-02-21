import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import 'package:flutter_tests/app/core/services/app_client.dart';
import 'package:flutter_tests/app/core/services/app_response.dart';

class AppDioClientImpl implements IAppClient {
  final dio = Dio();

  @override
  Future<Result<AppResponse, Failure>> get(
    String url, {
    Map<String, dynamic>? params,
  }) async {
    try {
      final result = await dio.get(url, queryParameters: params);

      return Result.success(AppResponse(
        data: result.data,
        code: result.statusCode ?? 200,
      ));
    } on DioException catch (e) {
      return Result.failure(Failure(e.toString()));
    } catch (e) {
      return Result.failure(const Failure('Ops! Api error.'));
    }
  }
}
