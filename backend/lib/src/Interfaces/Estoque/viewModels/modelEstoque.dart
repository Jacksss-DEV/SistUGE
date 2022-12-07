class ModelEstoque {
  final int? id;
  final String localidade;
  final String? dt_entrada;
  final String? dt_saida;
  final String quantidade;
  final int? id_produto;

  ModelEstoque(
      {this.id,
      required this.localidade,
      this.dt_entrada,
      this.dt_saida,
      required this.quantidade, 
      this.id_produto});

  factory ModelEstoque.fromRequest(Map data) {
    return ModelEstoque(
        localidade: data["localidade"], quantidade: data["quantidade"]);
  }
}
