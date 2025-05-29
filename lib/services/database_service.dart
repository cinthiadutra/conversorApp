import 'package:mysql1/mysql1.dart';
import '../models/conversion_model.dart';
import '../models/user_model.dart';

class DatabaseService {
  Future<MySqlConnection> _getConnection() async {
    final settings = ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: 'sua_senha',
      db: 'conversor_db',
    );
    return await MySqlConnection.connect(settings);
  }

  /// Verifica se o usuário existe no banco de dados
  Future<User?> getUser(String username, String password) async {
    MySqlConnection? conn;

    try {
      conn = await _getConnection();
      final results = await conn.query(
        'SELECT id, username, password FROM users WHERE username = ? AND password = ?',
        [username, password],
      );

      if (results.isNotEmpty) {
        final row = results.first;
        return User(
          id: row[0] as int,
          username: row[1] as String,
          password: row[2] as String,
        );
      }
    } catch (e) {
      print('Erro ao buscar usuário: $e');
    } finally {
      await conn?.close();
    }

    return null;
  }

  /// Salva uma conversão no banco
  Future<void> saveConversion(
    String from,
    String to,
    double amount,
    double result,
    double rate,
  ) async {
    MySqlConnection? conn;

    try {
      conn = await _getConnection();
      await conn.query(
        'INSERT INTO conversions (from_currency, to_currency, amount, result, rate, date) VALUES (?, ?, ?, ?, ?, NOW())',
        [from, to, amount, result, rate],
      );
    } catch (e) {
      print('Erro ao salvar conversão: $e');
      rethrow;
    } finally {
      await conn?.close();
    }
  }

  /// Recupera o histórico de conversões
  Future<List<ConversionModel>> getConversionHistory() async {
    MySqlConnection? conn;

    try {
      conn = await _getConnection();
      final results = await conn.query(
        'SELECT from_currency, to_currency, amount, result, rate, date FROM conversions ORDER BY date DESC',
      );

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
    } catch (e) {
      print('Erro ao buscar histórico: $e');
      return [];
    } finally {
      await conn?.close();
    }
  }

  /// Cria novo usuário
  Future<void> createUser(String username, String password) async {
    MySqlConnection? conn;

    try {
      conn = await _getConnection();
      await conn.query('INSERT INTO users (username, password) VALUES (?, ?)', [
        username,
        password,
      ]);
    } catch (e) {
      print('Erro ao criar usuário: $e');
      rethrow;
    } finally {
      await conn?.close();
    }
  }
}
