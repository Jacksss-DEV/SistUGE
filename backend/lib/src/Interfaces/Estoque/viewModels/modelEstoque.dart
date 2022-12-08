class ModelEstoque {
  final int? id;
  final String? localidade;
  final String? dt_entrada;
  final String? dt_saida;
  final String? quantidade;
  final int? id_produto;
  final String? adicionarQuantidade;
  final String? removerQuantidade;

  ModelEstoque({
    this.id,
    this.localidade,
    this.dt_entrada,
    this.dt_saida,
    this.quantidade,
    this.id_produto,
    this.adicionarQuantidade,
    this.removerQuantidade,
  });

  factory ModelEstoque.fromRequest(Map data) {
    return ModelEstoque(
        localidade: data["localidade"], quantidade: data["quantidade"]);
  }
}
