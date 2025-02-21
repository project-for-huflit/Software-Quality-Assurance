import 'package:http/http.dart' as http;
import 'package:mobile/env/provider.dart';

class InvoiceAPI {
  Future<http.Response> getListInvoice() {
    return http.get('${webConfig.apiKey}/invoice' as Uri);
  }

  Future<http.Response> getListWalletById(String id) {
    return http.get('${webConfig.apiKey}/invoice/$id' as Uri);
  }

  Future<http.Response> createInvoice(Object data) {
    return http.post(
      '${webConfig.apiKey}/invoice' as Uri,
      body: data,
      // headers: Map(),
      // encoding: Error().toString() 
    );
  }
}

final invoiceAPI = InvoiceAPI();