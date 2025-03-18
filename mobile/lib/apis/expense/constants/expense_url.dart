// ignore_for_file: non_constant_identifier_names
import 'package:mobile/env/provider.dart';

class ExpenseUrls{
  final String baseUrl;
  ExpenseUrls(this.baseUrl);

  // final Uri API_WALLET_LIST = Uri.parse('${baseConfig.nestUrl}/wallet');
  // final Uri API_CREATE_WALLET = Uri.parse('${baseConfig.nestUrl}/wallet');
  Uri get API_EXPENSE_LIST => Uri.parse('$baseUrl/invoice');
  Uri get API_CREATE_EXPENSE => Uri.parse('$baseUrl/invoice');
  Uri API_DELETE_EXPENSE(String id) => Uri.parse('${baseConfig.nestUrl}/invoice/$id');
// Uri deleteUrl = walletUrls.API_DELETE_WALLET('123');
}

final expenseUrls = ExpenseUrls(baseConfig.nestUrl);