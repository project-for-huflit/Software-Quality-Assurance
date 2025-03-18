import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/apis/categoryExpense/constant/category_expense_url.dart';
import 'package:mobile/apis/categoryExpense/model/category_expense_model.dart';
import 'package:mobile/apis/categoryIncome/constant/category_income_url.dart';
import 'package:mobile/apis/categoryIncome/model/category_income_model.dart';
import 'package:mobile/apis/wallets/constants/wallet_url.dart';
import 'package:mobile/apis/wallets/models/wallet_model.dart';

class CateExpenseServices{
  Future<List<CategoryExpenseModel>> listCateExpense() {
    return http
        .get(categoryExpenseUrls.API_CATEGORY_EXPENSE_LIST)
        .then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if(statusCode != 200){
        // ignore: avoid_print
        // print(response.reasonPhrase);
        throw Exception("Error load api");
      }

      const JsonDecoder decoder = JsonDecoder();

      final List<dynamic> cateExpenseList = decoder.convert(jsonBody);
      // ignore: avoid_print
      // print(walletList);
      return cateExpenseList.map((cateExpenseRaw) => CategoryExpenseModel.formJson(cateExpenseRaw)).toList();
    });
  }

  Future<CategoryExpenseModel?> createCateIncome(CategoryExpenseModel category) async {
    return await http
        .post(
      categoryExpenseUrls.API_CREATE_CATEGORY_EXPENSE,
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

  deleteCateExpense(id) async {
    return await http
        .post(categoryExpenseUrls.API_DELETE_CATE_EXPENSE(id))
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
      final String responseCreateCateExpense = useContainer['results'];
      return responseCreateCateExpense;
    }
    );
  }
}