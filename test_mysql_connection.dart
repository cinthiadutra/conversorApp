import 'dart:developer';

import 'package:mysql1/mysql1.dart';

void main() async {
  final settings = ConnectionSettings(
    host: '127.0.0.1', // substitua pelo IP local do seu Mac
    port: 3306,
    user: 'root', // seu usuário MySQL
    password: '', // substitua se necessário
  );

  try {
    final conn = await MySqlConnection.connect(settings);
    log('✅ Conexão com o MySQL estabelecida com sucesso!');

    final results = await conn.query('SHOW DATABASES;');
    log('📚 Bancos disponíveis:');
    for (var row in results) {
      log(' - ${row[0]}');
    }

    await conn.close();
  } catch (e) {
    log('❌ Erro ao conectar no MySQL: $e');
  }
}
