class LoginModel {
  String email;
  String senha;

  LoginModel(this.email, this.senha);

  factory LoginModel.fromRequest({required Map data}) {
    return LoginModel(data["email"], data["senha"]);
  }
}