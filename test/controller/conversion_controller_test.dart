// test/controllers/conversion_controller_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:conversor_app/controller/conversion_controller.dart';
import 'package:conversor_app/services/api_service.dart';
import 'package:conversor_app/services/database_service.dart';
import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}

class MockDatabaseService extends Mock implements DatabaseService {}

void main() {
  late ConversionController controller;
  late MockApiService mockApi;
  late MockDatabaseService mockDb;

  setUp(() {
    mockApi = MockApiService();
    mockDb = MockDatabaseService();

    controller = ConversionController();
    controller.amountController.text = '10.0';
  });

  test('Conversão válida atualiza resultado corretamente', () async {
    when(() => mockApi.getExchangeRate(any(), any())).thenAnswer((_) async => 5.0);
    when(() => mockDb.saveConversion(any(), any(), any(), any(), any())).thenAnswer((_) async {});
    when(() => mockDb.getConversionHistory()).thenAnswer((_) async => []);

    await controller.convertCurrency();

    expect(controller.result.value, contains('USD'));
  });
}
