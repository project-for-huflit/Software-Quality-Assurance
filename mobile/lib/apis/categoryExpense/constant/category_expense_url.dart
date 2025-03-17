// ignore_for_file: non_constant_identifier_names
import 'package:mobile/env/provider.dart';

class CategoryExpenseUrls{
  final String baseUrl;
  CategoryExpenseUrls(this.baseUrl);

  // final Uri API_WALLET_LIST = Uri.parse('${baseConfig.nestUrl}/wallet');
  // final Uri API_CREATE_WALLET = Uri.parse('${baseConfig.nestUrl}/wallet');
  Uri get API_CATEGORY_EXPENSE_LIST => Uri.parse('$baseUrl/cate-expense');
  Uri get API_CREATE_CATEGORY_EXPENSE => Uri.parse('$baseUrl/cate-expense');
  Uri API_DELETE_CATE_EXPENSE(String id) => Uri.parse('${baseConfig.nestUrl}/cate-expense/$id');
// Uri deleteUrl = walletUrls.API_DELETE_WALLET('123');
}

final categoryExpenseUrls = CategoryExpenseUrls(baseConfig.nestUrl);