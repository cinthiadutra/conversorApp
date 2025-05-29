import 'package:mysql1/mysql1.dart';

import '../models/conversion_model.dart';
import '../models/user_model.dart';

class DatabaseService {
  Future<MySqlConnection> _getConnection() async {
    final settings = ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root', // ou outro usuário
      password: 'sua_senha',
      db: 'conversor_db',
    );
    return MySqlConnection.connect(settings);
  }

  /// Verifica se o usuário existe no banco de dados
  Future<User?> getUser(String username, String password) async {
    final conn = await _getConnection();
    final results = await conn.query(
      'SELECT id, username, password FROM users WHERE username = ? AND password = ?',
      [username, password],
    );
    await conn.close();

    if (results.isNotEmpty) {
      final row = results.first;
      return User(
        id: row[0] as int,
        username: row[1] as String,
        password: row[2] as String,
      );
    }
    return null;
  }

  /// Salva uma conversão no banco
  Future<void> saveConversion(String from, String to, double amount, double result, double rate) async {
    final conn = await _getConnection();
    await conn.query(
      'INSERT INTO conversions (from_currency, to_currency, amount, result, rate, date) VALUES (?, ?, ?, ?, ?, NOW())',
      [from, to, amount, result, rate],
    );
    await conn.close();
  }

  /// Recupera o histórico de conversões
  Future<List<ConversionModel>> getConversionHistory() async {
    final conn = await _getConnection();
    final results = await conn.query(
      'SELECT from_currency, to_currency, amount, result, rate, date FROM conversions ORDER BY date DESC',
    );
    await conn.close();

    return results.map((row) {
      return ConversionModel(
        fromCurrency: row[0] as String,
        toCurrency: row[1] as String,
        amount: row[2] as double,
        result: row[3] as double,
        rate: row[4] as double,
        date: row[5] as DateTime,
      );
    }).toList();
  }
}
