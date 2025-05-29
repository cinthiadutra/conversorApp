import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://api.exchangeratesapi.io/v1/latest';
  final String _apiKey = '131f0799099c19c6317e343c6ac33764';
  // api_service.dart

  Future<double> getExchangeRate(String from, String to) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {'access_key': _apiKey, 'symbols': '$from,$to'},
      );

      if (response.statusCode == 200 && response.data['success']) {
        final rates = response.data['rates'];
        final rateFrom = rates[from];
        final rateTo = rates[to];
        return rateTo / rateFrom;
      } else {
        throw Exception('Falha ao obter taxas de câmbio');
      }
    } catch (e) {
      throw Exception('Erro ao conectar à API: $e');
    }
  }
}
