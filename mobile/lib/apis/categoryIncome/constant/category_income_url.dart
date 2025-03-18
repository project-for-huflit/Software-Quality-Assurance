// ignore_for_file: non_constant_identifier_names
import 'package:mobile/env/provider.dart';

class CategoryIncomeUrls{
  final String baseUrl;
  CategoryIncomeUrls(this.baseUrl);

  // final Uri API_WALLET_LIST = Uri.parse('${baseConfig.nestUrl}/wallet');
  // final Uri API_CREATE_WALLET = Uri.parse('${baseConfig.nestUrl}/wallet');
  Uri get API_CATEGORY_INCOME_LIST => Uri.parse('$baseUrl/cate-income');
  Uri get API_CREATE_CATEGORY_INCOME => Uri.parse('$baseUrl/cate-income');
  Uri API_DELETE_CATE_INCOME(String id) => Uri.parse('${baseConfig.nestUrl}/cate-income/$id');
// Uri deleteUrl = walletUrls.API_DELETE_WALLET('123');
}

final categoryIncomeUrls = CategoryIncomeUrls(baseConfig.nestUrl);