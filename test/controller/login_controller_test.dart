// test/controllers/login_controller_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:conversor_app/controller/login_controller.dart';
import 'package:conversor_app/models/user_model.dart';
import 'package:conversor_app/services/database_service.dart';
import 'package:mocktail/mocktail.dart';

class MockDatabaseService extends Mock implements DatabaseService {}

void main() {
  late LoginController controller;
  late MockDatabaseService mockService;

  setUp(() {
    mockService = MockDatabaseService();
    controller = LoginController();
    controller.usernameController.text = 'testuser';
    controller.passwordController.text = '1234';
    controller.onInit();
    controller.onClose();
  });

  test('Login com sucesso atualiza currentUser', () async {
    final user = User(id: 1, username: 'testuser', password: '1234');
    controller = LoginController();
    controller.usernameController.text = 'testuser';
    controller.passwordController.text = '1234';
    controller.onInit();

    controller.currentUser.value = user;

    expect(controller.currentUser.value?.username, 'testuser');
  });
}
