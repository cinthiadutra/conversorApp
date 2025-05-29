import 'dart:developer';
import 'package:mysql_client/mysql_client.dart';
import '../models/user_model.dart';
import '../models/conversion_model.dart';

class DatabaseService {
  Future<MySQLConnection> _getConnection() async {
    final conn = await MySQLConnection.createConnection(
      host: '192.168.15.54',
      port: 3306,
      userName: 'root',
      password: 'cd1704',
      databaseName: 'falepaco',
    );
    await conn.connect();
    return conn;
  }

  Future<User?> getUser(String username, String password) async {
    late final MySQLConnection conn;
    try {
      conn = await _getConnection();

      final result = await conn.execute(
        "SELECT id, username, password FROM users WHERE username = :username AND password = :password",
        {"username": username, "password": password},
      );

      if (result.numOfRows > 0) {
        final row = result.rows.first;
        return User(
          id: int.parse(row.colByName("id")!),
          username: row.colByName("username")!,
          password: row.colByName("password")!,
        );
      }
    } catch (e, stack) {
      log('Erro ao buscar usuário: $e');
      log('❌ Stack trace: $stack');
    } finally {
      await conn.close();
    }

    return null;
  }

  Future<void> createUser(String username, String password) async {
    late final MySQLConnection conn;
    try {
      conn = await _getConnection();

      await conn.execute(
        "INSERT INTO users (username, password) VALUES (:username, :password)",
        {"username": username, "password": password},
      );
    } catch (e, stack) {
      log('Erro ao criar usuário: $e');
      log('❌ Stack trace: $stack');
      rethrow;
    } finally {
      await conn.close();
    }
  }

  Future<void> saveConversion(
    String from,
    String to,
    double amount,
    double result,
    double rate,
  ) async {
    final conn = await _getConnection();
    try {
      await conn.execute(
        '''
        INSERT INTO conversions 
        (from_currency, to_currency, amount, result, rate, date) 
        VALUES (:from, :to, :amount, :result, :rate, NOW())
        ''',
        {
          "from": from,
          "to": to,
          "amount": amount.toString(),
          "result": result.toString(),
          "rate": rate.toString(),
        },
      );
    } catch (e) {
      log('Erro ao salvar conversão: $e');
    } finally {
      await conn.close();
    }
  }

  Future<List<ConversionModel>> getConversionHistory() async {
    final conn = await _getConnection();
    try {
      final result = await conn.execute(
        'SELECT from_currency, to_currency, amount, result, rate, date FROM conversions ORDER BY date DESC',
      );

      return result.rows.map((row) {
        return ConversionModel(
          fromCurrency: row.colByName("from_currency")!,
          toCurrency: row.colByName("to_currency")!,
          amount: double.parse(row.colByName("amount")!),
          result: double.parse(row.colByName("result")!),
          rate: double.parse(row.colByName("rate")!),
          date: DateTime.parse(row.colByName("date")!),
        );
      }).toList();
    } catch (e) {
      log('Erro ao buscar histórico: $e');
      return [];
    } finally {
      await conn.close();
    }
  }
}
