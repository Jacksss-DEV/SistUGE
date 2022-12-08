class EstoqueModel {
  int? id;
  String? nome;
  String? quantidade;
  String? localidade;
  String? adicionarQuantidade;
  String? removerQuantidade;

  EstoqueModel({
    this.id,
    this.nome,
    this.quantidade,
    this.localidade,
    this.adicionarQuantidade,
    this.removerQuantidade,
  });

  factory EstoqueModel.fromJson(Map<String, dynamic> json) {
    return EstoqueModel(
      id: json["id"],
      nome: json['nome'],
      quantidade: json['quantidade'],
      localidade: json['localidade'],
      adicionarQuantidade: json['adicionarQuantidade'],
      removerQuantidade: json['removerQuantidade'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'quantidade': quantidade,
      'localidade': localidade,
      'adicionarQuantidade': adicionarQuantidade,
      'removerQuantidade': removerQuantidade,
    };
  }
}
