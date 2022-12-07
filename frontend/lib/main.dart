import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/views/api/sheets/product_sheets.dart';
import 'app_module.dart';
import 'app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserSheetsApi.init();

  runApp(
    ModularApp(
      module: AppModule(),
      child: AppWidget(),
    ),
  );
}
