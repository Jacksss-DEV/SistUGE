import 'package:dart_learning/app/views/modules/estoque/views/estoque_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EstoquePageModule extends Module {

  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, __) => EstoquePage(),
        ),
      ];

}