// lib/controllers/login_controller.dart
import 'package:conversor_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/database_service.dart';
import '../models/user_model.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  final DatabaseService _databaseService = DatabaseService();
  final Rx<User?> currentUser = Rx<User?>(null);

 void login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    final user = await _databaseService.getUser(username, password);
    if (user != null) {
      currentUser.value = user;
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.snackbar("Erro", "Usuário ou senha inválidos");
    }
  }

 void register() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    await _databaseService.createUser(username, password);
    Get.snackbar("Sucesso", "Usuário registrado, faça login");
    Get.offAllNamed(AppRoutes.login);
  }
}
