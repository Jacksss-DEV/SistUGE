import 'package:dart_learning/app/views/modules/home/widgets/sidemenu/views/side_menu_page.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'views/login_page.dart';

class LoginPageModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => LoginPage(), children: [
          ChildRoute('/home', child: (context, __) => MenuPage()),
        ]),
      ];
}
