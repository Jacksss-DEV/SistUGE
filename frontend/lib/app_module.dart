import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/views/modules/estoque/estoque_module.dart';
import 'app/views/modules/home/home_page_module.dart';
import 'app/views/modules/home/widgets/sidemenu/side_menu_module.dart';
import 'app/views/modules/login/login_page_module.dart';
import 'app/views/modules/produtos/produtos_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    // ChildRoute('/home', child: ((context, args) => MenuPage())),
    ModuleRoute(Modular.initialRoute, module: LoginPageModule()),
    ModuleRoute('/', module: HomePageModule()),
    ModuleRoute('/home', module: MenuPageModule()),
    ModuleRoute('/produtos', module: ProdutosModule()),
    ModuleRoute('/login', module: LoginPageModule()),
    ModuleRoute('/estoque', module: EstoquePageModule()),
    WildcardRoute(
      child: (_, __) => const Scaffold(
        body: Center(
          child: Text(
            "A página não existe",
          ),
        ),
      ),
    ),
  ];
}
