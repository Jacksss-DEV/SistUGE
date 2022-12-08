abstract class EstoqueInterface {
  Future<bool> alterarQuantidade(
      int id, String? adicionarQuantidade, String? removerQuantidade);
}
