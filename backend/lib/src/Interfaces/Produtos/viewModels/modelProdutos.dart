class ModelProdutos {
  final int? id;
  final String nome;
  final String dt_ult_compra;
  final String ult_preco;

  ModelProdutos(
      {this.id,
      required this.nome,
      required this.dt_ult_compra,
      required this.ult_preco});

  factory ModelProdutos.fromRequest(Map data) {
    return ModelProdutos(
        nome: data["nome"],
        dt_ult_compra: data["dt_ult_compra"],
        ult_preco: data["ult_preco"]);
  }
}
