import 'package:flutter/foundation.dart';
import 'package:meu_app/modules/login/login_model.dart';
import 'package:meu_app/modules/login/login_state.dart';

class LoginViewModel extends ChangeNotifier {
  LoginState _state = const LoginState();

  LoginState get state => _state;

  void _update(LoginState newState) {
    _state = newState;
    notifyListeners();
  }

  void setLoading(bool value) {
    _update(
      _state.copyWith(
        isLoading: value,
        errorMessage: null,
      ),
    );
  }

  void setError(String? message) {
    _update(
      _state.copyWith(
        isLoading: false,
        errorMessage: message,
      ),
    );
  }

  Future<bool> login(LoginModel model) async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 2));
    if (model.email == 'teste@teste.com' && model.password == '123456') {
      setLoading(false);
      return true;
    } else {
      setError('email ou senha inválidos');
      return false;
    }
  }
}
