import 'package:flutter/material.dart';
import 'package:meu_app/modules/home/home_view.dart';

class AppCoordinator {
  static void navigateToHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const HomeView(),
      ),
    );
  }
}
