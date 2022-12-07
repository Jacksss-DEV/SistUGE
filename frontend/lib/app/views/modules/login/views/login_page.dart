// ignore_for_file: body_might_complete_normally_nullable, unused_local_variable

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../stores/form_store.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Dio _dio = Dio();

  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isVisible = true;

  FormStore formStore = FormStore();

  @override
  void initState() {
    super.initState();
    formStore.setupValidations();
  }

  @override
  void dispose() {
    formStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://static.vecteezy.com/system/resources/previews/002/151/440/original/global-business-network-and-technology-on-blue-background-vector.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 150, top: 150),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Página de login',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.grey),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'Entre na sua conta',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: Colors.grey[300]),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Card(
                          color: Colors.grey.withOpacity(.4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Observer(
                              builder: (_) {
                                return TextFormField(
                                  validator: (email) {
                                    if (email == null || email.isEmpty) {
                                      return 'Digite o seu e-mail';
                                    }
                                    return null;
                                  },
                                  controller: _emailController,
                                  onChanged: (email) {
                                    formStore.setEmail(email);
                                  },
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      // errorText: formStore.error.email,
                                      labelText: 'E-mail',
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          Icons.email,
                                          color: Colors.grey[300],
                                        ),
                                        onPressed: () {},
                                      ),
                                      labelStyle:
                                          TextStyle(color: Colors.grey[300]),
                                      border: InputBorder.none),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.grey.withOpacity(.4),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Observer(
                              builder: (_) {
                                return TextFormField(
                                  validator: (senha) {
                                    if (senha == null || senha.isEmpty) {
                                      return 'Digite sua senha';
                                    } else if (senha.length < 6) {
                                      return 'A senha deve conter mais de 6 caracteres';
                                    }
                                    return null;
                                  },
                                  controller: _senhaController,
                                  onChanged: (password) {
                                    formStore.setPassword(password);
                                  },
                                  style: TextStyle(color: Colors.white),
                                  obscureText: isVisible,
                                  decoration: InputDecoration(
                                      // errorText: formStore.error.password,
                                      labelText: 'Senha',
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          isVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.grey[300],
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isVisible = !isVisible;
                                          });
                                        },
                                      ),
                                      labelStyle:
                                          TextStyle(color: Colors.grey[300]),
                                      border: InputBorder.none),
                                );
                              },
                            )),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 50,
                              width: 170,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.grey[600]!,
                                      Colors.grey[800]!
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Text(
                                  'Administrador',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Observer(builder: (_) {
                            return InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  logar();
                                } else {
                                  return null;
                                }
                              },
                              child: Container(
                                height: 50,
                                width: 170,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 5, 108, 204),
                                        Color.fromARGB(255, 40, 94, 212)
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Center(
                                  child: Text(
                                    'Entrar',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(flex: 2, child: Card())
            ],
          ),
        ),
      ),
    );
  }

  logar() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    var response = await _dio.post(
      'http://localhost:3333/auth/login',
      data: {
        'email': _emailController.text,
        'senha': _senhaController.text,
      },
    );
    if (response.statusCode == 200) {
      Modular.to.navigate('/home');
      String token = response.data['accessToken'].first;
      await _sharedPreferences.setString('token', '$token');
      var log = await _sharedPreferences.get('token');
    }
  }
}
