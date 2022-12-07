import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';


class MenuPage extends StatefulWidget {
   MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Drawer(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Container(
              decoration:  BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 26, 35, 126),
                    Color.fromARGB(255, 48, 63, 159),
                    Color.fromARGB(255, 57, 73, 171),
                    Color.fromARGB(255, 92, 107, 192),
                  ],
                  tileMode: TileMode.clamp,
                ),
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.playlist_add_check_circle_outlined,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        Text(
                          'Estoque Brisanet',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            //letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                   Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Lista de menus',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          fontSize: 12),
                    ),
                  ),
                  ListTile(
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    leading:  Icon(Icons.featured_play_list_outlined),
                    title:  Text('Produtos'),
                    onTap: () {
                      Modular.to.navigate('/home/produtos');
                    },
                  ),
                  ListTile(
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    leading:  Icon(Icons.storage),
                    title:  Text('Estoque'),
                    onTap: () {
                      Modular.to.navigate('/home/estoque');
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: RouterOutlet()),
        ],
      ),
    );
  }
}
