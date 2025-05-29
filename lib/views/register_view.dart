import 'package:conversor_app/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/logo.png', height: 100),

              Text(
                "Faça seu cadastro",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: controller.usernameController,
                decoration: InputDecoration(labelText: 'Usuário'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Senha'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => controller.register(),
                child: Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
