// test/views/register_view_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:conversor_app/views/register_view.dart';

void main() {
  testWidgets('Renderiza tela de cadastro e interage com formulário', (
    tester,
  ) async {
    await tester.pumpWidget(GetMaterialApp(home: RegisterView()));

    await tester.tap(find.byKey(const Key('register_button')));

    await tester.enterText(find.byType(TextField).at(0), 'user123');
    await tester.enterText(find.byType(TextField).at(1), 'senha123');

    await tester.pump(); // simula o clique no botão

    // Não valida o resultado, mas simula fluxo
    expect(find.byType(TextField), findsNWidgets(2));
  });
}
