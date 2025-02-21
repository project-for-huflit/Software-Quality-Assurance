import 'package:http/http.dart' as http;
import 'package:mobile/env/provider.dart';

class IncomeAPI {
  Future<http.Response> getListIncome() {
    return http.get('${webConfig.apiKey}/income' as Uri);
  }

  Future<http.Response> getListWalletById(String id) {
    return http.get('${webConfig.apiKey}/income/$id' as Uri);
  }

  Future<http.Response> createIncome(Object data) {
    return http.post(
      '${webConfig.apiKey}/income' as Uri,
      body: data,
      // headers: Map(),
      // encoding: Error().toString() 
    );
  }
}

final incomeAPI = IncomeAPI();