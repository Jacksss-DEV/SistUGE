import 'package:mobx/mobx.dart';
import 'package:validators2/validators.dart';
part 'form_store.g.dart';

class FormStore = _FormStoreBase with _$FormStore;

abstract class _FormStoreBase with Store {
  final FormErrorState error = FormErrorState();
  late List<ReactionDisposer> _disposers;

  @observable
  String email = '';

  @observable
  String password = '';

  @action
  void setEmail(String value) {
    email = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  void setupValidations() {
    _disposers = [
      reaction((_) => email, validateEmail),
      reaction((_) => password, validatePassword),
    ];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  bool validateAll() {
    if (validateEmail(email) && validatePassword(password)) {
      return true;
    } else {
      return false;
    }
  }

  @action
  bool validateEmail(String value) {
    if (isNull(value) || value.isEmpty) {
      error.email = 'E-mail obrigatório';
      return false;
    }
    error.email = null;
    return true;
  }

  @action
  bool validatePassword(String value) {
    if (isNull(value) || value.isEmpty) {
      error.password = 'Senha é obrigatória';
      return false;
    } else if (value.length < 6) {
      error.password = 'A senha deve conter mais de 6 caracteres';
      return false;
    }
    error.password = null;
    return true;
  }

  @computed
  bool get isEmailValid => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\[a-zA-Z]+")
      .hasMatch(email);

  @computed
  bool get isPasswordValid => password.length > 5 && password.length <= 16;

  @computed
  bool get isFormValid => isEmailValid && isPasswordValid;
}

class FormErrorState = _FormErrorState with _$FormErrorState;

abstract class _FormErrorState with Store {
  @observable
  String? email = '';

  @observable
  String? password = '';

  @computed
  bool get hasErrors => email != null || password != null;
}
