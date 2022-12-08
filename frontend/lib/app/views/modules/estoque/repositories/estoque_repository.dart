import 'package:dart_learning/app/views/modules/estoque/interface/estoque_interface.dart';
import 'package:dart_learning/app/views/modules/estoque/models/estoque_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EstoqueRepository implements EstoqueInterface{

  final Dio _dio = Dio();

  @override
  Future<bool> alterarQuantidade(int id, String adicionarQuantidade, String removerQuantidade) async {
    bool success = false;
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    var tokenCreate = await _sharedPreferences.getString('token');
    var data = EstoqueModel(
        adicionarQuantidade: adicionarQuantidade,
        removerQuantidade: removerQuantidade,
        );

    final apiResponse = await _dio.put(
      'http://localhost:3333/estoque/${id}',
      data: data.toJson(),
      options: Options(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: {
          'authorization': 'Bearer $tokenCreate',
        },
      ),
    );

    if (apiResponse.statusCode == 200) {
      success = true;
    } else {
      success = false;
    }
    return success;
  }

}