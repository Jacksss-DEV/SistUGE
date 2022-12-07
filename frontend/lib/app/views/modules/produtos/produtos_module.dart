import 'package:flutter_modular/flutter_modular.dart';

import 'views/data_table/produtos_table.dart';


class ProdutosModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/home',
          child: (_, args) => HomeProduto(),
        ),
      ];
}