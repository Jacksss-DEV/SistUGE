
import 'package:dart_learning/app/views/modules/estoque/views/estoque_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../produtos/views/data_table/produtos_table.dart';
import 'widgets/sidemenu/views/side_menu_page.dart';

class HomePageModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/home',
          child: (_, __) => MenuPage(),
          children: [
            ChildRoute(
              '/produtos',
              child: (_, __) => HomeProduto(),
              transition: TransitionType.noTransition,
            ),
            ChildRoute(
              '/estoque',
              child: (_, __) => EstoquePage(),
              transition: TransitionType.noTransition,
            ),
          ],
        ),
      ];
}
