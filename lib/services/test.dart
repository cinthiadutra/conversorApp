import 'package:mysql1/mysql1.dart';

void main() async {
  try {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: '192.168.15.54',
      port: 3306,
      user: 'root',
      password: 'cd1704',
      db: 'falepaco',
      useCompression: false,
    ));

    print('✅ Conexão bem-sucedida!');
    await conn.close();
  } catch (e) {
    print('❌ Falha na conexão: $e');
  }
}
