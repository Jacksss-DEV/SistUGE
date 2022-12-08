import 'package:flutter/material.dart';

import '../views/data_table/produtos_table.dart';

class ProdutoModel {
  int? id;
  String? nome;
  String? quantidade;
  String? localidade;
  String? dt_ult_compra;
  String? ult_preco;
  String? remover;
  String? adicionar;
  String? dt_entrada;
  String? dt_saida;

  ProdutoModel({
    this.id,
    this.nome,
    this.quantidade,
    this.localidade,
    this.dt_ult_compra,
    this.ult_preco,
    this.remover,
    this.adicionar,
    this.dt_entrada,
    this.dt_saida,
  });

  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return ProdutoModel(
      id: json["id"],
      nome: json['nome'],
      quantidade: json['quantidade'],
      localidade: json['localidade'],
      dt_ult_compra: json['dt_ult_compra'],
      ult_preco: json['ult_preco'],
      remover: json['remover'],
      adicionar: json['adicionar'],
      dt_entrada: json['dt_entrada'],
      dt_saida: json['dt_saida'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'quantidade': quantidade,
      'localidade': localidade,
      'dt_ult_compra': dt_ult_compra,
      'ult_preco': ult_preco,
      'remover': remover,
      'adicionar': adicionar,
      'dt_entrada': dt_entrada,
      'dt_saida': dt_saida,
    };
  }

  DataRow getRow(
    SelectedCallBack callback,
    List<String> selectedIds,
  ) {
    return DataRow(cells: [
      DataCell(Text(nome.toString())),
      DataCell(Text(quantidade.toString())),
      DataCell(Text(localidade.toString())),
      DataCell(Text(dt_ult_compra.toString())),
      DataCell(Text(ult_preco.toString())),
      DataCell(Text(remover.toString())),
      DataCell(Text(adicionar.toString())),
      DataCell(Text(dt_entrada.toString())),
      DataCell(Text(dt_saida.toString())),
    ]);
  }
}
