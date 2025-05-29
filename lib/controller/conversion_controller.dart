// lib/controllers/conversion_controller.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/database_service.dart';
import '../models/conversion_model.dart';

class ConversionController extends GetxController {
  final ApiService _apiService = ApiService();
  final DatabaseService _databaseService = DatabaseService();

  final fromCurrency = 'BRL'.obs;
  final toCurrency = 'USD'.obs;
  final amountController = TextEditingController();
  final result = ''.obs;
  final history = <ConversionModel>[].obs;

  final currencies = ['BRL', 'USD', 'CAD'];

  @override
  void onInit() {
    super.onInit();
    fetchHistory();
  }

  Future<void> convertCurrency() async {
    final amountText = amountController.text;
    if (amountText.isEmpty) {
      Get.snackbar('Erro', 'Por favor, insira um valor para converter.');
      return;
    }

    final amount = double.tryParse(amountText.replaceAll(',', '.'));
    if (amount == null) {
      Get.snackbar('Erro', 'Valor inválido.');
      return;
    }

    try {
      final conversionResult = await _apiService.convertCurrency(
        fromCurrency.value,
        toCurrency.value,
        amount,
      );

      final rate = conversionResult / amount;

      result.value =
          '$amount ${fromCurrency.value} = ${conversionResult.toStringAsFixed(2)} ${toCurrency.value}';

      await _databaseService.saveConversion(
        fromCurrency.value,
        toCurrency.value,
        amount,
        conversionResult,
        rate,
      );

      fetchHistory();
    } catch (e) {
      Get.snackbar('Erro', 'Falha na conversão de moeda: $e');
    }
  }

  Future<void> fetchHistory() async {
    final conversions = await _databaseService.getConversionHistory();
    history.assignAll(conversions);
  }
}
