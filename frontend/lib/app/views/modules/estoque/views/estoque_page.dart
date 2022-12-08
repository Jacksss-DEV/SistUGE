// ignore_for_file: unused_local_variable

import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../produtos/models/produto_model.dart';
import '../../produtos/repositories/produto_repository.dart';
import '../../produtos/stores/product_store.dart';
import '../repositories/estoque_repository.dart';

class EstoquePage extends StatefulWidget {
  const EstoquePage({super.key});

  @override
  State<EstoquePage> createState() => _EstoquePageState();
}

class _EstoquePageState extends State<EstoquePage> {
  var rowsPerPage = 15;
  var sortIndex = 0;
  var sortAsc = true;
  final source = ExampleSource();
  final searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  TextEditingController controllerEsNome = TextEditingController();
  TextEditingController controllerEsQuantidade = TextEditingController();
  TextEditingController controllerEsLocalidade = TextEditingController();
  TextEditingController controllerEsUltCompra = TextEditingController();
  TextEditingController controllerEsUltPreco = TextEditingController();
  TextEditingController controllerEsDtEntrada = TextEditingController();
  TextEditingController controllerEsDtSaida = TextEditingController();

  TableProdutoStore tableController = TableProdutoStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                'Tabela de estoque',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          labelText: 'Buscar pelo nome do produto',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff47afc9)),
                          ),
                        ),
                        onSubmitted: (value) {
                          source.filterServerSide(searchController.text);
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        source.filterServerSide(searchController.text),
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
              AdvancedPaginatedDataTable(
                addEmptyRows: true,
                source: source,
                sortAscending: sortAsc,
                sortColumnIndex: sortIndex,
                loadingWidget: loadDadosTable,
                errorWidget: loadErrosTable,
                showFirstLastButtons: true,
                rowsPerPage: rowsPerPage,
                availableRowsPerPage: [5, 10, 15],
                onRowsPerPageChanged: (newRowsPerPage) {
                  if (newRowsPerPage != null) {
                    setState(
                      () {
                        rowsPerPage = newRowsPerPage;
                      },
                    );
                  }
                },
                columns: [
                  DataColumn(
                    label: Text('Nome do produto'),
                  ),
                  DataColumn(
                    label: Text('Quantidade'),
                  ),
                  DataColumn(
                    label: Text('Localidade'),
                  ),
                  DataColumn(
                    label: Text('Entrada'),
                  ),
                  DataColumn(
                    label: Text('Saída'),
                  ),
                  DataColumn(
                    label: Text('Atualizar'),
                  ),
                ],
                getFooterRowText:
                    (startRow, pageSize, totalFilter, totalRowsWithoutFilter) {
                  final localizations = MaterialLocalizations.of(context);
                  var amountText = localizations.pageRowsInfoTitle(
                    startRow,
                    pageSize,
                    totalFilter ?? totalRowsWithoutFilter,
                    false,
                  );

                  if (totalFilter != null) {
                    amountText += ' Filtrado de ($totalRowsWithoutFilter)';
                  }
                  return amountText;
                },
              ),
              SizedBox(height: 10),
              // ElevatedButton(
              //     onPressed: () async {
              //       final produtos = {
              //         ProductFields.id: 1,
              //         ProductFields.name: 'Jackson',
              //         ProductFields.dt_ult_compra: '22112022',
              //         ProductFields.ult_preco: '5153.12',
              //       };
              //       await UserSheetsApi.insert([produtos]);
              //     },
              //     child: Text('Exportar dados'),),
            ],
          ),
        ),
      ),
    );
  }

  void setSort(int i, bool asc) => setState(() {
        sortIndex = i;
        sortAsc = asc;
      });

  Widget loadDadosTable() {
    return Center(
      heightFactor: 10,
      child: CircularProgressIndicator(
          backgroundColor: Colors.grey, color: Color(0xff47afc9)),
    );
  }

  Widget loadErrosTable() {
    return Center(heightFactor: 10, child: Text("Carregando dados..."));
  }
}

typedef SelectedCallBack = Function(String id, bool newSelectState);

class ExampleSource extends AdvancedDataTableSource<ProdutoModel> {
  List<String> selectedIds = [];
  String lastSearchTerm = '';

  final _formKey = GlobalKey<FormState>();

  @override
  DataRow getRow(int index) {
    final controllerENome = TextEditingController();
    final controllerEQuantidade = TextEditingController();
    final controllerELocalidade = TextEditingController();
    final controllerEDtUltCompra = TextEditingController();
    final controllerEUltPreco = TextEditingController();
    final controllerERemoverQuantidade = TextEditingController();
    final controllerEAdicionarQuantidade = TextEditingController();
    final controllerEEntrada = TextEditingController();
    final controllerESaida = TextEditingController();

    final source = ExampleSource();

    final TableProdutoStore controllerProduto = TableProdutoStore();
    final ProdutoRepository produtoRepository = ProdutoRepository();
    final ProdutoModel produtoModel = ProdutoModel(
      nome: 'nome',
      dt_ult_compra: 'dt_ult_compra',
      ult_preco: 'ult_preco',
      localidade: 'localidade',
      quantidade: 'quantidade',
      dt_entrada: 'dt_entrada',
      dt_saida: 'dt_saida',
    );

    lastDetails!.rows[index];

    return DataRow(
      cells: [
        DataCell(Text("${lastDetails!.rows[index].nome}")),
        DataCell(Text("${lastDetails!.rows[index].quantidade}")),
        DataCell(Text("${lastDetails!.rows[index].localidade}")),
        DataCell(Text("${lastDetails!.rows[index].dt_entrada}")),
        DataCell(Text("${lastDetails!.rows[index].dt_saida}")),
        DataCell(Row(
          children: [
            Builder(
              builder: (context) {
                return IconButton(
                  tooltip: "Atualizar quantidade",
                  onPressed: () {
                    controllerEQuantidade.text =
                        lastDetails!.rows[index].quantidade!;
                    CoolAlert.show(
                      width: 500,
                      type: CoolAlertType.confirm,
                      title: "Atenção",
                      text:
                          "Digite a quantidade para adicionar ou remover e clique no respectivo botão.",
                      cancelBtnText: "Cancelar",
                      confirmBtnText: "Salvar",
                      backgroundColor: Color(0xff235b69),
                      confirmBtnColor: Colors.green,
                      cancelBtnTextStyle: TextStyle(
                        color: Colors.red,
                      ),
                      onCancelBtnTap: () {
                        Modular.to.pop();
                      },
                      context: context,
                      widget: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              enabled: false,
                              controller: controllerEQuantidade,
                              decoration: InputDecoration(
                                labelText: 'Quantidade atual',
                                icon: Icon(Icons.gradient),
                                labelStyle: TextStyle(
                                    fontSize: 15, color: Color(0xff47afc9)),
                                errorStyle: TextStyle(
                                  color: Colors.red,
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff47afc9)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: controllerERemoverQuantidade,
                              decoration: InputDecoration(
                                labelText: 'Remover quantidade',
                                icon: Icon(Icons.remove),
                                labelStyle: TextStyle(
                                    fontSize: 15, color: Color(0xff47afc9)),
                                errorStyle: TextStyle(
                                  color: Colors.red,
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff47afc9)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: controllerEAdicionarQuantidade,
                              decoration: InputDecoration(
                                labelText: 'Adicionar quantidade',
                                icon: Icon(Icons.add),
                                labelStyle: TextStyle(
                                    fontSize: 15, color: Color(0xff47afc9)),
                                errorStyle: TextStyle(
                                  color: Colors.red,
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff47afc9)),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  tooltip: "Remover quantidade",
                                  onPressed: () async {
                                    bool update = await EstoqueRepository()
                                        .alterarQuantidade(
                                      lastDetails!.rows[index].id!,
                                      controllerEAdicionarQuantidade.text,
                                      controllerERemoverQuantidade.text,
                                    );
                                    if (update) {
                                      Modular.to.pop();
                                      CoolAlert.show(
                                          width: 500,
                                          context: context,
                                          type: CoolAlertType.success,
                                          backgroundColor: Color(0xff235b69),
                                          confirmBtnColor: Color(0xff235b69),
                                          title: "Sucesso",
                                          text:
                                              "Quantidade atualizado com sucesso");
                                      reloadPage();
                                    } else {
                                      Modular.to.pop();
                                      CoolAlert.show(
                                          width: 500,
                                          context: context,
                                          type: CoolAlertType.error,
                                          title: "Falha",
                                          text:
                                              "Ocorreu uma falha ao alterar quantidade");
                                    }
                                  },
                                  icon: Icon(Icons.remove, color: Colors.red),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                IconButton(
                                  tooltip: "Adicionar",
                                  onPressed: () async {
                                    bool update = await EstoqueRepository()
                                        .alterarQuantidade(
                                      lastDetails!.rows[index].id!,
                                      controllerEAdicionarQuantidade.text,
                                      controllerERemoverQuantidade.text,
                                    );
                                    if (update) {
                                      Modular.to.pop();
                                      CoolAlert.show(
                                          width: 500,
                                          context: context,
                                          type: CoolAlertType.success,
                                          backgroundColor: Color(0xff235b69),
                                          confirmBtnColor: Color(0xff235b69),
                                          title: "Sucesso",
                                          text:
                                              "Quantidade atualizado com sucesso");
                                      reloadPage();
                                    } else {
                                      Modular.to.pop();
                                      CoolAlert.show(
                                          width: 500,
                                          context: context,
                                          type: CoolAlertType.error,
                                          title: "Falha",
                                          text:
                                              "Ocorreu uma falha ao alterar quantidade");
                                    }
                                  },
                                  icon: Icon(Icons.add, color: Colors.green),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.autorenew_rounded,
                    color: Color.fromARGB(255, 202, 165, 1),
                  ),
                );
              },
            )
          ],
        )),
      ],
    );
  }

  void filterServerSide(String filterQuery) async {
    lastSearchTerm = filterQuery.toLowerCase().trim();
    setNextView();
  }

  void reloadPage() async {
    setNextView();
  }

  @override
  Future<RemoteDataSourceDetails<ProdutoModel>> getNextPage(
      NextPageRequest pageRequest) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    var tokenCreate = await _sharedPreferences.getString('token');
    final Dio _dio = Dio();

    final response = await _dio.get(
      'http://localhost:3333/produtos',
      queryParameters: {
        'offset': pageRequest.offset.toString(),
        'pageSize': pageRequest.pageSize.toString(),
        if (lastSearchTerm.isNotEmpty) 'nome': lastSearchTerm,
      },
      options: Options(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: {
          'authorization': 'Bearer $tokenCreate',
        },
      ),
    );
    if (response.statusCode == 200) {
      final data = response.data;
      return RemoteDataSourceDetails(
        int.parse(data['Produtos'].first["count"].toString()),
        (data['Produtos'] as List<dynamic>)
            .map((json) => ProdutoModel.fromJson(json))
            .toList(),
        filteredRows: lastSearchTerm.isNotEmpty
            ? (data['Produtos'] as List<dynamic>).length
            : null,
      );
    } else {
      throw Exception('ERROOOOORRRR');
    }
  }

  @override
  int get selectedRowCount => selectedIds.length;
}
