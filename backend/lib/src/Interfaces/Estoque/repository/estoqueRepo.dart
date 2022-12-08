import 'package:backend/src/Interfaces/Estoque/viewModels/modelEstoque.dart';
import 'package:backend/src/Interfaces/Produtos/viewModels/queryParams.dart';
import 'package:backend/src/Services/Database/sqlite.dart';
import 'package:sqlite3/common.dart';
import 'package:sqlite3/sqlite3.dart';

class IEstoqueRepo {
  final _db = ConfigDB().Sqlite();

  ResultSet buscarProdutos(Params params) {
    ResultSet query = _db.select(
      '''
        SELECT 
          estoque.id,
          produtos.nome,
          estoque.quantidade, 
          estoque.localidade, 
          estoque.dt_entrada,
          estoque.dt_saida, 
          COUNT(*) OVER() AS count 
        FROM produtos, estoque
        WHERE
          CASE
            WHEN nome = '' THEN true
            ELSE nome LIKE '%' || ? || '%'
          END AND produtos.id = estoque.id_produto
        LIMIT ? OFFSET ?;''',
      [params.nome, params.limite, params.offset],
    );
    return query;
  }

  int atualizarQuantidade(ModelEstoque estoque) {
    ResultSet select =
        _db.select('SELECT quantidade FROM estoque WHERE id_produto =?;', [estoque.id]);
    if (estoque.removerQuantidade!.isEmpty == true) {
      DateTime data_At = DateTime.now();
      String dt_saida = "${data_At.day}/${data_At.month}/${data_At.year}";
      final valueDB = int.parse(select.first['quantidade']);
      final valueReq = int.parse(estoque.adicionarQuantidade!);
      final valueTotal = (valueDB + valueReq);
      PreparedStatement adicionarQuantidadeDB =
          _db.prepare('UPDATE estoque SET dt_saida=?, quantidade=? WHERE id_produto=?');
      adicionarQuantidadeDB.execute([dt_saida, valueTotal, estoque.id]);
      final result = _db.getUpdatedRows();
      adicionarQuantidadeDB.dispose();
      return result;
    } else {
      DateTime data_At = DateTime.now();
      String dt_saida = "${data_At.day}/${data_At.month}/${data_At.year}";
      final valueDB = int.parse(select.first['quantidade']);
      final valueReq = int.parse(estoque.removerQuantidade!);
      final valueTotal = (valueDB - valueReq);
      PreparedStatement removerQuantidadeDB =
          _db.prepare('UPDATE estoque SET dt_saida=?, quantidade=? WHERE id_produto=?');
      removerQuantidadeDB.execute([dt_saida, valueTotal, estoque.id]);
      final result = _db.getUpdatedRows();
      removerQuantidadeDB.dispose();
      return result;
    }
  }
}
