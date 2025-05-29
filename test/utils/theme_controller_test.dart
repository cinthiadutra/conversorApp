import 'package:conversor_app/utils/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  group('ThemeController', () {
    late ThemeController themeController;

    setUp(() {
      themeController = ThemeController();
      Get.put(themeController); // Necessário para que Get.changeThemeMode funcione
    });

    tearDown(() {
      Get.delete<ThemeController>();
    });

    test('alternar o tema muda isDarkMode corretamente', () {
      expect(themeController.isDarkMode.value, false);

      themeController.toggleTheme();
      expect(themeController.isDarkMode.value, true);

      themeController.toggleTheme();
      expect(themeController.isDarkMode.value, false);
    });
  });
}
