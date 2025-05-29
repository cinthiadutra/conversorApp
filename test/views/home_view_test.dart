import 'package:conversor_app/utils/theme_controller.dart';
import 'package:conversor_app/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  setUpAll(() {
    Get.put(ThemeController());
  });

  testWidgets('Renderiza HomeView corretamente', (tester) async {
    await tester.pumpWidget(GetMaterialApp(home: HomeView()));

    expect(find.text('Histórico'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsWidgets);
  });
}
