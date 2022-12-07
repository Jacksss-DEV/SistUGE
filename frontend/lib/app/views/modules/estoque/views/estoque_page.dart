// ignore_for_file: unused_local_variable

import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../produtos/models/produto_model.dart';
import '../../produtos/repositories/produto_repository.dart';
import '../../produtos/stores/product_store.dart';

class EstoquePage extends StatefulWidget {
  const EstoquePage({super.key});

  @override
  State<EstoquePage> createState() => _EstoquePageState();
}

class _EstoquePageState extends State<EstoquePage> {
  var rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
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
