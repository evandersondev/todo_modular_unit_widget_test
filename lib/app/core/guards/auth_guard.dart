import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/login');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    if (token != null) {
      final decodedToken = JwtDecoder.decode(token);

      if (decodedToken['email'] != 'test@mail.com') {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }
}
