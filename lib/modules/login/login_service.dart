class LoginService {
  Future<bool> login(String email, String senha) async {
    await Future.delayed(const Duration(seconds: 1));
    return email == "teste@teste.com" && senha == "123";
  }
}
