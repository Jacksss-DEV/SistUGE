// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TableProdutoStore on _TableProdutoStoreBase, Store {
  Computed<bool>? _$isValidNameComputed;

  @override
  bool get isValidName =>
      (_$isValidNameComputed ??= Computed<bool>(() => super.isValidName,
              name: '_TableProdutoStoreBase.isValidName'))
          .value;

  late final _$nomeAtom =
      Atom(name: '_TableProdutoStoreBase.nome', context: context);

  @override
  String get nome {
    _$nomeAtom.reportRead();
    return super.nome;
  }

  @override
  set nome(String value) {
    _$nomeAtom.reportWrite(value, super.nome, () {
      super.nome = value;
    });
  }

  late final _$createProductAsyncAction =
      AsyncAction('_TableProdutoStoreBase.createProduct', context: context);

  @override
  Future<bool> createProduct(
      dynamic nome,
      dynamic quantidade,
      dynamic localidade,
      dynamic dataUltCompra,
      dynamic ultPreco,
      dynamic entrada,
      dynamic saida) {
    return _$createProductAsyncAction.run(() => super.createProduct(
        nome, quantidade, localidade, dataUltCompra, ultPreco, entrada, saida));
  }

  @override
  String toString() {
    return '''
nome: ${nome},
isValidName: ${isValidName}
    ''';
  }
}
