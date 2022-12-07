// import 'package:flutter/material.dart';

// class ModalCadastroProduto extends StatelessWidget {
//   ModalCadastroProduto({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       child: Padding(
//         padding: EdgeInsets.all(8.0),
//         child: Icon(Icons.person_add),
//       ),
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all(Color(0xff47afc9)),
//       ),
//       onPressed: () {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               scrollable: true,
//               content: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Container(
//                   width: MediaQuery.of(context).size.width * 0.3,
//                   child: Form(
//                     child: Column(
//                       children: [
//                         Text(
//                           "Novo Produto",
//                           style: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.w400),
//                         ),
//                         SizedBox(
//                           height: 30,
//                         ),
//                         TextFormField(
//                           decoration: InputDecoration(
//                             labelText: 'Nome ',
//                             icon: Icon(Icons.account_box),
//                           ),
//                         ),
//                         TextFormField(
//                           decoration: InputDecoration(
//                             labelText: 'Email',
//                             icon: Icon(Icons.email),
//                           ),
//                         ),
//                         TextFormField(
//                           obscureText: true,
//                           decoration: InputDecoration(
//                             labelText: 'Senha',
//                             icon: Icon(Icons.password),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               actions: [
//                 ElevatedButton(
//                     child: Text("Cadastrar"),
//                     style: ButtonStyle(
//                       backgroundColor:
//                           MaterialStateProperty.all(Color(0xff47afc9)),
//                     ),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     }),
//                 ElevatedButton(
//                   child: Text('Cancelar'),
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all(
//                         Color.fromARGB(255, 235, 26, 26)),
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }
