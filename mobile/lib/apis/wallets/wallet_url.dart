import 'package:http/http.dart' as http;
import 'package:mobile/env/provider.dart';

class WalletAPI {
  Future<http.Response> getListWallet() {
    return http.get('${webConfig.apiKey}/wallet' as Uri);
  }

  Future<http.Response> getListWalletById(String id) {
    return http.get('${webConfig.apiKey}/wallet/$id' as Uri);
  }

  Future<http.Response> createWallet(Object data) {
    return http.post(
      '${webConfig.apiKey}/wallet' as Uri,
      body: data,
      // headers: Map(),
      // encoding: Error().toString() 
    );
  }
}

final walletAPI = WalletAPI();
