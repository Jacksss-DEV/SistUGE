import 'dart:convert';

import 'package:backend/src/Interfaces/Auth/repository/authRepo.dart';
import 'package:backend/src/Interfaces/Auth/viewModels/modelLogin.dart';
import 'package:backend/src/Services/BCrypt/configBCrypt.dart';
import 'package:backend/src/Services/Jwt/configJWT.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';
import 'package:sqlite3/common.dart';

final _repository = AuthRepo();
ConfigBCrypt _bcrypt = ConfigBCrypt();

class AuthController extends Resource {
  @override
  List<Route> get routes => [
        Route.post('/auth/login', login),
      ];

  Response login(ModularArguments req) {
    LoginModel login = LoginModel.fromRequest(data: req.data);
    ResultSet result = _repository.login(login);
    if (result.isEmpty == false) {
      final hashed = result.map((senha) => senha['senha']).first;
      Map accessClaims =
          configJwt().acessTokenClaims(result.map((e) => e).first);
      Map refreshClaims =
          configJwt().refreshTokenClaims(result.map((e) => e).first);
      if (_bcrypt.verifyBCrypt(password: login.senha, hashed: hashed)) {
        final accessToken =
            configJwt().generateToken(accessClaims, "accessToken");
        final refreshToken =
            configJwt().generateToken(refreshClaims, "refreshToken");
        final map = {
          "accessToken": [accessToken],
          "refreshToken": [refreshToken],
        };
        return Response(200, body: jsonEncode(map));
      }
    }
    final map = {
      "Error": ["email ou senha invalida!"]
    };
    return Response(401, body: jsonEncode(map));
  }
}
