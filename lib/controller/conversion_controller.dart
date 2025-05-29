// conversion_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';
import '../services/database_service.dart';
import '../models/conversion_model.dart';

class ConversionController extends GetxController {
  final ApiService _apiService = ApiService();
  final DatabaseService _databaseService = DatabaseService();

  final TextEditingController amountController = TextEditingController();
  final RxString fromCurrency = 'BRL'.obs;
  final RxString toCurrency = 'USD'.obs;
  final RxString result = ''.obs;
  final RxList<ConversionModel> history = <ConversionModel>[].obs;

  final List<String> currencies = ['BRL', 'USD', 'CAD'];

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  Future<void> convertCurrency() async {
    final amountText = amountController.text;
    if (amountText.isEmpty) {
      result.value = 'Por favor, insira um valor.';
      return;
    }

    final amount = double.tryParse(amountText.replaceAll(',', '.'));
    if (amount == null) {
      result.value = 'Valor inválido.';
      return;
    }

    try {
      final rate = await _apiService.getExchangeRate(fromCurrency.value, toCurrency.value);
      final convertedAmount = amount * rate;
      result.value = '${convertedAmount.toStringAsFixed(2)} ${toCurrency.value}';

      await _databaseService.saveConversion(
        fromCurrency.value,
        toCurrency.value,
        amount,
        convertedAmount,
        rate,
      );

      loadHistory();
    } catch (e) {
      result.value = 'Erro na conversão: $e';
    }
  }

  Future<void> loadHistory() async {
    final conversions = await _databaseService.getConversionHistory();
    history.assignAll(conversions);
  }
}
