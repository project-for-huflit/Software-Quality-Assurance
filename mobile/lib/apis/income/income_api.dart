import 'dart:convert';

import 'package:mobile/apis/income/constants/income_url.dart';
import 'package:mobile/apis/income/models/income_model.dart';
import 'package:http/http.dart' as http;

class IncomeServices{
  Future<List<IncomeModel>> listIncome() {
    return http
        .get(incomeUrls.API_INCOME_LIST)
        .then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if(statusCode != 200){
        // ignore: avoid_print
        // print(response.reasonPhrase);
        throw Exception("Error load api");
      }

      const JsonDecoder decoder = JsonDecoder();

      final List<dynamic> incomeList = decoder.convert(jsonBody);
      // ignore: avoid_print
      // print(walletList);
      return incomeList.map((incomeRaw) => IncomeModel.formJson(incomeRaw)).toList();
    });
  }

  Future<IncomeModel?> createIncome(IncomeModel income) async {
    return await http
        .post(
      incomeUrls.API_CREATE_INCOME,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(income.toJson()),
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

      final dynamic responseCreateIncome = decoder.convert(jsonBody);
      // ignore: avoid_print
      print(responseCreateIncome);
      return responseCreateIncome;
    }
    ).catchError((e) {
      // ignore: avoid_print
      print("❌ Exception: $e");
      return null;
    });
  }

  deleteExpense(id) async {
    return await http
        .post(incomeUrls.API_DELETE_INCOME(id))
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
      final String responseCreateIncome = useContainer['results'];
      return responseCreateIncome;
    }
    );
  }
}