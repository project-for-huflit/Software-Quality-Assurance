// ignore_for_file: non_constant_identifier_names
import 'package:mobile/env/provider.dart';

class IncomeUrls{
  final String baseUrl;
  IncomeUrls(this.baseUrl);

  // final Uri API_WALLET_LIST = Uri.parse('${baseConfig.nestUrl}/wallet');
  // final Uri API_CREATE_WALLET = Uri.parse('${baseConfig.nestUrl}/wallet');
  Uri get API_INCOME_LIST => Uri.parse('$baseUrl/income');
  Uri get API_CREATE_INCOME => Uri.parse('$baseUrl/income');
  Uri API_DELETE_INCOME(String id) => Uri.parse('${baseConfig.nestUrl}/income/$id');
// Uri deleteUrl = walletUrls.API_DELETE_WALLET('123');
}

final incomeUrls = IncomeUrls(baseConfig.nestUrl);