import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://api.exchangeratesapi.io/v1/';
  final String _apiKey = '131f0799099c19c6317e343c6ac33764';

  Future<double> convertCurrency(String from, String to, double amount) async {
    final response = await _dio.get(
      '${_baseUrl}convert',
      queryParameters: {
        'access_key': _apiKey,
        'from': from,
        'to': to,
        'amount': amount,
      },
    );

    if (response.statusCode == 200 && response.data['success']) {
      return response.data['result'];
    } else {
      throw Exception('Falha na conversão de moeda');
    }
  }
}
