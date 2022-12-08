import 'dart:convert';

import 'package:backend/src/Interfaces/Auth/authResources.dart';
import 'package:backend/src/Interfaces/Estoque/repository/estoqueRepo.dart';
import 'package:backend/src/Interfaces/Estoque/viewModels/modelEstoque.dart';
import 'package:backend/src/Interfaces/Produtos/viewModels/queryParams.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

class IEstoqueController extends Resource {
  final _repository = IEstoqueRepo();

  Future<Response> _buscarEstoque(ModularArguments arg, Request req) async {
    Params params = Params(
      int.parse(arg.queryParams['pageSize'].toString()),
      int.parse(arg.queryParams['offset'].toString()),
      arg.queryParams["nome"] ?? '',
    );
    final result = _repository.buscarProdutos(params);
    if (result.isEmpty == false) {
      final map = {'Produtos': result};
      return Response(200, body: jsonEncode(map));
    }
    final map = {
      'Error': ["error ao buscar produtos"]
    };
    return Response(404, body: jsonEncode(map));
  }

  Future<Response> atualizarQuantidade(
      ModularArguments arg, Request req) async {
    ModelEstoque estoque = ModelEstoque(
      id: int.parse(arg.params['id']),
      adicionarQuantidade: arg.data["adicionarQuantidade"],
      removerQuantidade: arg.data["removerQuantidade"] ?? '',
    );
    // print(estoque.removerQuantidade!.isEmpty);
    final result = _repository.atualizarQuantidade(estoque);
    if (result != 1) {
      final map = {"Error": "Deu erro"};
      return Response(500, body: jsonEncode(map));
    }
    final map = {"Sucesso": "Deu certo"};
    return Response(200, body: jsonEncode(map));
  }

  @override
  // TODO: implement routes
  List<Route> get routes => [
        Route.get('/estoque', _buscarEstoque),
        Route.put('/estoque/:id', atualizarQuantidade),
      ];
}
