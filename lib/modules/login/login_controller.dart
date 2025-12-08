import 'package:flutter/material.dart';
import 'package:meu_app/coordinator/app_coordinator.dart';
import 'package:meu_app/modules/login/login_model.dart';
import 'package:meu_app/modules/login/login_viewmodel.dart';

class LoginController {
  final LoginViewModel viewModel;

  LoginController(this.viewModel);

  Future<void> onLoginPressed(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    final model = LoginModel(email: email, password: password);
    final success = await viewModel.login(model);
    if (success && context.mounted) {
      AppCoordinator.navigateToHome(context);
    }
  }
}
