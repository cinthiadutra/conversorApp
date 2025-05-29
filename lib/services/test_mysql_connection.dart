import 'package:mysql1/mysql1.dart';

void main() async {
  final settings = ConnectionSettings(
    host: '192.168.15.54', // <-- substitua pelo IP do seu Mac
    port: 3306,
    user: 'root',
    password: '',
    db: 'falepaco',
  );

  try {
    final conn = await MySqlConnection.connect(settings);
    print('✅ Conexão com o MySQL estabelecida com sucesso!');

    var results = await conn.query('SHOW DATABASES');
    print('📚 Bancos disponíveis:');
    for (var row in results) {
      print(' - ${row[0]}');
    }

    await conn.close();
  } catch (e) {
    print('❌ Erro ao conectar no MySQL: $e');
  }
}
