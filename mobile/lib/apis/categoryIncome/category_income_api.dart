import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/apis/categoryIncome/constant/category_income_url.dart';
import 'package:mobile/apis/categoryIncome/model/category_income_model.dart';
import 'package:mobile/apis/wallets/constants/wallet_url.dart';
import 'package:mobile/apis/wallets/models/wallet_model.dart';

class CateIncomeServices{
  Future<List<CategoryIncomeModel>> listCateIncome() {
    return http
        .get(categoryIncomeUrls.API_CATEGORY_INCOME_LIST)
        .then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if(statusCode != 200){
        // ignore: avoid_print
        // print(response.reasonPhrase);
        throw Exception("Error load api");
      }

      const JsonDecoder decoder = JsonDecoder();

      final List<dynamic> cateIncomeList = decoder.convert(jsonBody);
      // ignore: avoid_print
      // print(walletList);
      return cateIncomeList.map((cateIncomeRaw) => CategoryIncomeModel.formJson(cateIncomeRaw)).toList();
    });
  }

  Future<WalletModel?> createCateIncome(CategoryIncomeModel category) async {
    return await http
        .post(
      categoryIncomeUrls.API_CREATE_CATEGORY_INCOME,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(category.toJson()),
    )
        .then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if(statusCode != 200){
        // ignore: avoid_print
        print("⚠️ Error: $statusCode - $jsonBody");
        throw Exception("Error load api");
      }

      const JsonDecoder decoder = JsonDecoder();

      final dynamic responseCreateCateIncome = decoder.convert(jsonBody);
      // ignore: avoid_print
      print(responseCreateCateIncome);
      return responseCreateCateIncome;
    }
    ).catchError((e) {
      // ignore: avoid_print
      print("❌ Exception: $e");
      return null;
    });
  }

  deleteCateIncome(id) async {
    return await http
        .post(categoryIncomeUrls.API_DELETE_CATE_INCOME(id))
        .then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if(statusCode != 200){
        // ignore: avoid_print
        print(response.reasonPhrase);
        throw Exception("Error load api");
      }

      const JsonDecoder decoder = JsonDecoder();
      final useContainer = decoder.convert(jsonBody);
      final String responseCreateCateIncome = useContainer['results'];
      return responseCreateCateIncome;
    }
    );
  }
}