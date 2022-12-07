import 'package:backend/src/Interfaces/Estoque/viewModels/modelEstoque.dart';
import 'package:backend/src/Interfaces/Produtos/viewModels/modelProdutos.dart';
import 'package:backend/src/Interfaces/Produtos/viewModels/queryParams.dart';
import 'package:backend/src/Services/Database/sqlite.dart';
import 'package:sqlite3/sqlite3.dart';

class IProdutosRepo {
  final _db = ConfigDB().Sqlite();

  int criarProdutos(ModelProdutos produtos, ModelEstoque estoque) {
    PreparedStatement queryProdutos = _db.prepare(
        'INSERT INTO produtos(nome,dt_ult_compra,ult_preco) VALUES(?,?,?);');
    queryProdutos
        .execute([produtos.nome, produtos.dt_ult_compra, produtos.ult_preco]);
    final lastID = _db.lastInsertRowId;
    DateTime data_At = DateTime.now();
    String dt_entrada = "${data_At.day}/${data_At.month}/${data_At.year}";
    PreparedStatement queryEstoque = _db.prepare(
        'INSERT INTO estoque(localidade, dt_entrada, quantidade, id_produto) VALUES(?,?,?,?);');
    queryEstoque.execute([
      estoque.localidade,
      dt_entrada,
      estoque.quantidade,
      lastID,
    ]);
    queryProdutos.dispose();
    queryEstoque.dispose();
    return lastID;
  }

  ResultSet buscarProdutos(Params params) {
    // ResultSet query = _db.select(
    //     'SELECT * FROM produtos ORDER BY id LIMIT ? OFFSET ?;',
    //     [params.limite, params.offset]);
    // return query;
    ResultSet query = _db.select(
      '''
        SELECT 
          produtos.id,
          produtos.nome,
          produtos.dt_ult_compra, 
          produtos.ult_preco, 
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

  int atualizarProduto(ModelProdutos produtos, ModelEstoque estoque) {
    // ResultSet selectProdutos = _db.select(
    //     'SELECT quantidade FROM estoque WHERE id_produto=?;', [produtos.id]);
    PreparedStatement queryProdutos = _db.prepare(
        'UPDATE produtos SET nome=?, dt_ult_compra=?, ult_preco=? WHERE id=?');
    queryProdutos.execute([
      produtos.nome,
      produtos.dt_ult_compra,
      produtos.ult_preco,
      produtos.id,
    ]);
    final result = _db.getUpdatedRows();
    DateTime data_At = DateTime.now();
    String dt_saida = "${data_At.day}/${data_At.month}/${data_At.year}";
    PreparedStatement queryEstoque = _db.prepare(
        'UPDATE estoque SET dt_saida=?, localidade=?, quantidade=? WHERE id_produto=?');
    queryEstoque.execute(
        [dt_saida, estoque.localidade, estoque.quantidade, produtos.id]);
    queryProdutos.dispose();
    queryEstoque.dispose();
    return result;
  }

  int deleteProduto(int id) {
    PreparedStatement delete = _db.prepare('DELETE FROM produtos WHERE id=?');
    delete.execute([id]);
    final query = _db.getUpdatedRows();
    if (query != 0) {
      PreparedStatement deleteEstoque =
          _db.prepare('DELETE FROM estoque WHERE id_produto=?');
      deleteEstoque.execute([id]);
    }
    return query;
  }
}
