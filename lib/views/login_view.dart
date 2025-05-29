// lib/views/login_view.dart
import 'package:conversor_app/controller/login_controller.dart';
import 'package:conversor_app/utils/theme_controller.dart';
import 'package:conversor_app/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    final ThemeController themeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              themeController.isDarkMode.value
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              themeController.toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset('assets/images/logo.png', height: 100),
            TextField(
              controller: controller.usernameController,
              decoration: const InputDecoration(labelText: 'Usuário'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: controller.passwordController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Obx(
              () =>
                  controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                        onPressed: () => controller.login(),
                        child: const Text('Entrar'),
                      ),
            ),
            // lib/views/login_view.dart
            TextButton(
              onPressed: () {
                Get.to(() => RegisterView());
              },
              child: Text('Criar nova conta'),
            ),
          ],
        ),
      ),
    );
  }
}
