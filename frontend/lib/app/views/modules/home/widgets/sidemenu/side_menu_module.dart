
import 'package:flutter_modular/flutter_modular.dart';

import '../../../produtos/views/data_table/produtos_table.dart';
import 'views/side_menu_page.dart';

class MenuPageModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/home',
      child: (_, __) => MenuPage(),
      children: [
        ChildRoute(
          '/produtos',
          child: (_, __) => HomeProduto(),
          transition: TransitionType.noTransition,
        ),
      ],
    ),
  ];
}
