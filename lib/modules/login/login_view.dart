import 'package:flutter/material.dart';
import 'package:meu_app/DesignSystem/shared/styles.dart';
import 'package:meu_app/DesignSystem/Components/InputField/input_text.dart';
import 'package:meu_app/DesignSystem/Components/InputField/input_text_view_model.dart';
import 'package:meu_app/DesignSystem/Components/Buttons/ActionButton/action_button.dart';
import 'package:meu_app/DesignSystem/Components/Buttons/ActionButton/action_button_view_model.dart';
import 'package:meu_app/modules/login/login_viewmodel.dart';
import 'package:meu_app/modules/login/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final LoginViewModel viewModel;
  late final LoginController controller;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscurePassword = true;
 // a tela escuta o view model
  @override
  void initState() {
    super.initState();
    viewModel = LoginViewModel();
    controller = LoginController(viewModel);
    viewModel.addListener(() { setState(() {}); });
  }

  @override
  void dispose() {
    viewModel.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = viewModel.state;

    final emailInputVM = InputTextViewModel(
      controller: emailController,
      placeholder: 'E-mail',
      password: false,
    );

    final passwordInputVM = InputTextViewModel(
      controller: passwordController,
      placeholder: 'Senha',
      password: _obscurePassword,
      togglePasswordVisibility: () {
        setState(() {
          _obscurePassword = !_obscurePassword;
        });
      },
    );

    final loginButtonVM = ActionButtonViewModel(
      size: ActionButtonSize.large,
      style: ActionButtonStyle.primary,
      text: state.isLoading ? 'Entrando...' : 'Entrar',
      onPressed: state.isLoading
          ? () {}
          : () {
              controller.onLoginPressed(
                context,
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
              );
            },
    );

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 360,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Login', style: heading2Light),
                const SizedBox(height: 8),
                const Text(
                  'Entre com suas credenciais para continuar.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                StyledInputField.instantiate(viewModel: emailInputVM),
                const SizedBox(height: 16),
                StyledInputField.instantiate(viewModel: passwordInputVM),
                const SizedBox(height: 24),
                if (state.errorMessage != null) ...[
                  Text(state.errorMessage!, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 12),
                ],
                ActionButton.instantiate(viewModel: loginButtonVM),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
