import '../models/produto_model.dart';

abstract class ProdutoInterface {
  Future<bool> cadastrarProduto(
      String name, String quantidade, String localidade, String dataUltCompra, String ultPreco, String dt_entrada, String dt_saida);

  Future<bool> editarProduto(
      int id, String name, String quantidade, String localidade, String dataUltCompra, String ultPreco, String atualizar, String dt_entrada, String dt_saida);
  Future<List<ProdutoModel>> listarProdutos();
  Future<List<ProdutoModel>> getAllProdutos();
}
