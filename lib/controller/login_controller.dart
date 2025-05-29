import 'dart:developer';

import 'package:conversor_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/database_service.dart';
import '../models/user_model.dart';

class LoginController extends GetxController {
  final DatabaseService _databaseService = DatabaseService();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final RxBool isLoading = false.obs;
  final Rx<User?> currentUser = Rx<User?>(null);

  /// Faz login do usuário
  Future<void> login() async {
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      final user = await _databaseService.getUser(
        usernameController.text.trim(),
        passwordController.text.trim(),
      );

      if (user != null) {
        currentUser.value = user;
        Get.offAllNamed('/home'); // ou sua rota principal
      } else {
        Get.snackbar(
          'Erro',
          'Usuário ou senha inválidos',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 4),
        );
      }
    } catch (e) {
      log('Erro no login: $e');
      Get.snackbar(
        'Erro',
        'Falha ao fazer login',
        backgroundColor: Colors.red,
        duration: Duration(seconds: 4),
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Cria um novo usuário
  Future<void> register() async {
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      await _databaseService.createUser(
        usernameController.text.trim(),
        passwordController.text.trim(),
      );
      Get.snackbar('Sucesso', 'Usuário registrado com sucesso');
      Get.toNamed(AppRoutes.login);
      Get.back(); // volta para a tela de login
    } catch (e) {
      log('Erro ao criar usuário: $e');
      Get.snackbar('Erro', 'Não foi possível criar o usuário');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
