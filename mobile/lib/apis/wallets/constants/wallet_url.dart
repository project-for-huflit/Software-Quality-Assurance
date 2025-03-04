// ignore_for_file: non_constant_identifier_names
import 'package:mobile/env/provider.dart';

class WalletUrls{
  final String baseUrl;
  WalletUrls(this.baseUrl);

  // final Uri API_WALLET_LIST = Uri.parse('${baseConfig.nestUrl}/wallet');
  // final Uri API_CREATE_WALLET = Uri.parse('${baseConfig.nestUrl}/wallet');
  Uri get API_WALLET_LIST => Uri.parse('$baseUrl/wallet');
  Uri get API_CREATE_WALLET => Uri.parse('$baseUrl/wallet');
  Uri API_DELETE_WALLET(String id) => Uri.parse('${baseConfig.nestUrl}/wallet/$id');
// Uri deleteUrl = walletUrls.API_DELETE_WALLET('123');
}

final walletUrls = WalletUrls(baseConfig.nestUrl);