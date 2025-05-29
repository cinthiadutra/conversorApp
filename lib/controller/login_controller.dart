// lib/controllers/login_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/database_service.dart';
import '../models/user_model.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  final DatabaseService _databaseService = DatabaseService();

  Future<void> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar('Erro', 'Preencha todos os campos');
      return;
    }

    isLoading.value = true;

    try {
      final User? user = await _databaseService.getUser(username, password);
      if (user != null) {
        Get.offAllNamed('/home');
      } else {
        Get.snackbar('Erro', 'Usuário ou senha inválidos');
      }
    } catch (e) {
      Get.snackbar('Erro', 'Ocorreu um erro ao fazer login');
    } finally {
      isLoading.value = false;
    }
  }
}
