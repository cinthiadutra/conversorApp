// test/services/database_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:conversor_app/services/database_service.dart';

void main() {
  final db = DatabaseService();

  test('Cria e recupera usuário do banco', () async {
    await db.createUser('test_user', '1234');

    final user = await db.getUser('test_user', '1234');
    expect(user?.username, 'test_user');
  });

  test('Salva e busca conversão', () async {
    await db.saveConversion('BRL', 'USD', 10.0, 2.0, 0.2);
    final history = await db.getConversionHistory();

    expect(history, isNotEmpty);
  });
}
