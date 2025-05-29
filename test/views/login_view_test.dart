import 'package:conversor_app/controller/login_controller.dart';
import 'package:conversor_app/utils/theme_controller.dart';
import 'package:conversor_app/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  setUpAll(() {
    Get.put(ThemeController());
    Get.put(LoginController());
  });

  testWidgets('Renderiza LoginView corretamente e interage com formulário', (
    tester,
  ) async {
    await tester.pumpWidget(const GetMaterialApp(home: LoginView()));

    expect(find.text('Login'), findsWidgets);
    expect(find.text('Usuário'), findsOneWidget);
    expect(find.text('Senha'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsWidgets);

    await tester.enterText(find.byType(TextFormField).at(0), 'cinthiadutra');
    await tester.enterText(find.byType(TextFormField).at(1), '1234');

    await tester.tap(find.text('Login').first);
    await tester.pump(); // Aguarda a UI responder

    // Apenas simula o envio - resultado depende da lógica real
  });
}
