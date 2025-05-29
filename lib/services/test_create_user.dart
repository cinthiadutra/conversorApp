import 'package:mysql1/mysql1.dart';

Future<void> main() async {
  try {
    final settings = ConnectionSettings(
      host: '192.168.15.54',
      port: 3306,
      user: 'root',
      password: 'cd1704',
      db: 'falepaco',
      timeout: Duration(seconds: 70),
    );

    final conn = await MySqlConnection.connect(settings);

    final username = 'teste_user';
    final password = '1234';

    final result = await conn.query(
      'INSERT INTO users (username, password) VALUES (?, ?)',
      [username, password],
    );

    print('✅ Usuário criado com sucesso: ID ${result.insertId}');
    await conn.close();
  } catch (e) {
    print('❌ Erro ao criar usuário: $e');
  }
}
