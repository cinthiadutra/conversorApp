class ConversionModel {
  final int? id; // ID opcional, útil para banco de dados
  final String fromCurrency;
  final String toCurrency;
  final double amount;
  final double result;
  final double rate;
  final DateTime date;

  ConversionModel({
    this.id,
    required this.fromCurrency,
    required this.toCurrency,
    required this.amount,
    required this.result,
    required this.rate,
    required this.date,
  });

  // Método para converter um mapa (por exemplo, do banco de dados) em um objeto ConversionModel
  factory ConversionModel.fromMap(Map<String, dynamic> map) {
    return ConversionModel(
      id: map['id'],
      fromCurrency: map['from_currency'],
      toCurrency: map['to_currency'],
      amount: map['amount'],
      result: map['result'],
      rate: map['rate'],
      date: DateTime.parse(map['date']),
    );
  }

  // Método para converter o objeto ConversionModel em um mapa (por exemplo, para inserir no banco de dados)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'from_currency': fromCurrency,
      'to_currency': toCurrency,
      'amount': amount,
      'result': result,
      'rate': rate,
      'date': date.toIso8601String(),
    };
  }
}
