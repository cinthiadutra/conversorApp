// lib/views/home_view.dart
import 'package:conversor_app/controller/conversion_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/conversion_model.dart';

class HomeView extends StatelessWidget {
  final ConversionController controller = Get.put(ConversionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversor de Moedas'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown para moeda de origem
            Obx(() => DropdownButton<String>(
                  value: controller.fromCurrency.value,
                  onChanged: (value) => controller.fromCurrency.value = value!,
                  items: controller.currencies
                      .map((currency) => DropdownMenuItem(
                            value: currency,
                            child: Text(currency),
                          ))
                      .toList(),
                )),
            SizedBox(height: 10),
            // Dropdown para moeda de destino
            Obx(() => DropdownButton<String>(
                  value: controller.toCurrency.value,
                  onChanged: (value) => controller.toCurrency.value = value!,
                  items: controller.currencies
                      .map((currency) => DropdownMenuItem(
                            value: currency,
                            child: Text(currency),
                          ))
                      .toList(),
                )),
            SizedBox(height: 10),
            // Campo para inserir o valor
            TextField(
              controller: controller.amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Valor',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            // Botão para realizar a conversão
            ElevatedButton(
              onPressed: controller.convertCurrency,
              child: Text('Converter'),
            ),
            SizedBox(height: 20),
            // Exibição do resultado
            Obx(() => Text(
                  controller.result.value,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 20),
            // Tabela com o histórico de conversões
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: controller.history.length,
                    itemBuilder: (context, index) {
                      final ConversionModel conversion =
                          controller.history[index];
                      return ListTile(
                        title: Text(
                            '${conversion.amount} ${conversion.fromCurrency} → ${conversion.toCurrency}'),
                        subtitle: Text(
                            'Resultado: ${conversion.result} | Taxa: ${conversion.rate.toStringAsFixed(4)} | Data: ${conversion.date.toLocal().toString().split('.')[0]}'),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
