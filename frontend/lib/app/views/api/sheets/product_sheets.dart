// ignore_for_file: unused_local_variable

import 'package:gsheets/gsheets.dart';

import 'product_fields.dart';

class UserSheetsApi {
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "estoque-uge",
  "private_key_id": "ce3b43702aafa97c1914d33ee1ec1767a84a7951",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCcqksw/1ovVybt\n715i46X6Ml+2oT2iD9yXD+Ms/L7e10Sy+9MnHp0eBzbQamncbgFfgJn6fe4tdpKS\nU2XIY9hsYQpBxOwvprbQgZcpbh4QZzZTtnvHsSpKQVGbuvT8ilc45d3aB+Mp8Uqz\nVxEZv4nQkYvfu9aYFzu0V6k+BgB/MsC9Ew/Ug1FkLH9ra8or+G1SPp1MO4QRxPVf\n3cL2hQK4eTtjVWegsTRk24NdrnYAZ8oHVYIS6dBfUKnZAolo5hSEGeFSvPRw3OC6\nJur4119Ps8f6LXw0vjQUoW83mKezx1ybLAu5iDLTsBqkOSrjuMd07GS5BapSNKK6\n4BBMhNcHAgMBAAECggEAChHmIGGhdd6HuY6Dxh502jansVD+6a5UUv9p7kfWqvMy\nTsDiCycsGTSEgPP+FvWZL/7Ppuq2RwTSmgYzSiSk0h6QrraOKefw40kZIsgZtZs0\nwj++CBFqsvgs2zIyshLgVV9tGakdIGKKlyl3B20o2heo4nor6n2/0DE8RyjSmlpa\ngMXdiSbiFZI+AdXZOOSUf2MYNVMGuhvGLhh5n5TVYLIogF0TEqrpmGqBH5ztstEv\n+B+DDolXtdeANSzfQXaSZf71PT46lpdjGcvQZU3kGJ3jO7YDHguwwBzud2NA+HFK\nfYeeyRHopr5PSyfv35dla1CKsm4LS1kzrR9E4o+YZQKBgQDT98fFOBFV004fLK2+\npgLk8StW6r7V9JUHR9S05G1PmwLtYUnU95k4k1hsuQLBDUuXUYUmaBHLzqUcg4p6\nKn0pNz99oPlBOZEB7sUcQzAqkJrLjQB6IIAW50eY2Nq9qXB3gM7pABDjtd9+f0eI\n3+tSO7hzLIfz4PcXuGwSyZoZiwKBgQC9NZPVeRTGdFEMCpvy3aJQE449g1pXUvhO\nfES/6kJsrdpiJwUijYEaNu8EKVy3H1vWvnmYhu8Yk//uKZ4TicbpI4G9aUveb3sr\nUzYpbyvQxuCZZK7q6+6yr+CIWbb+sNZlzCyufMYdwsBKYNm/dPkfILbgBJdgAFuI\nQVMVAonP9QKBgQDLgPBC4HmENMKkG3kTuL6+nuxFHkrpj1AlFUmaAlUQQHqm/Oit\nlql8L7qNZ3LFdcZFGPcE0JWFXngW0BN7Bp/zmh9SteGYRXR6rop/f+IWe46iLlVu\n6xUO6C1NCaW4wZxAn2IHQRD2Df7sq7Y6KwD6imuj5/T+p9WS6HSZ9QQF0QKBgGo/\n5e5gefwfYUvDwWMWdolFEgEU++xBmVJpkim7IOXqktG/W7DViYPxCTNrDrd+kpH6\nkEnIrAc/RN623B/YpKxS1g5JTONx8taXebi2xwIMTB+XXGprZrVM8mdfCdXn891i\nVEz/oDkiHd0mmeBbjXGfa1JNAbxVNxFCracEr+LpAoGAeab3kVEElN74Q9sknWgk\n7BJPFVg+Fd3vrUKC7o9TpVRa6cpFNBjHnifLmL9uviXa04jYgOKI4Fs3K4brUKh9\n+hRYr68fZ4J1y7pMVuktSL/sazmE7TilQjuFfq9quMYm4J2O3PfY6Huk2WJXAX7E\n8k6BgiZ+5jtBSSwo1dRfhSg=\n-----END PRIVATE KEY-----\n",
  "client_email": "estoque-uge@estoque-uge.iam.gserviceaccount.com",
  "client_id": "105187291377782879632",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/estoque-uge%40estoque-uge.iam.gserviceaccount.com"
}
''';
  static final _spreadsheetId = '1OkBXp9WeceRtmJSbl8zoQuwvZMg03aMrDMfoCnNf_7o';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'Produtos');

      final primeiraLinha = ProductFields.getFields();
      _userSheet!.values.insertRow(1, primeiraLinha);
    } catch (e) {
    }
  }
  
  final todosDados = ProductFields.getFields();
  // _userSheet!.values.insertColumn(i);
  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>> linhaLista) async {
    if (_userSheet == null) return;

    _userSheet!.values.map.appendRows(linhaLista);
  }
}
