import 'dart:convert';

import 'package:mobile/apis/expense/constants/expense_url.dart';
import 'package:mobile/apis/expense/models/expense_model.dart';
import 'package:http/http.dart' as http;

class ExpenseServices{
  Future<List<ExpenseModel>> listExpense() {
    return http
        .get(expenseUrls.API_EXPENSE_LIST)
        .then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if(statusCode != 200){
        // ignore: avoid_print
        // print(response.reasonPhrase);
        throw Exception("Error load api");
      }

      const JsonDecoder decoder = JsonDecoder();

      final List<dynamic> expenseList = decoder.convert(jsonBody);
      // ignore: avoid_print
      // print(walletList);
      return expenseList.map((expenseRaw) => ExpenseModel.formJson(expenseRaw)).toList();
    });
  }

  Future<ExpenseModel?> createExpense(ExpenseModel expense) async {
    return await http
        .post(
      expenseUrls.API_CREATE_EXPENSE,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(expense.toJson()),
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

      final dynamic responseCreateExpense = decoder.convert(jsonBody);
      // ignore: avoid_print
      print(responseCreateExpense);
      return responseCreateExpense;
    }
    ).catchError((e) {
      // ignore: avoid_print
      print("❌ Exception: $e");
      return null;
    });
  }

  deleteExpense(id) async {
    return await http
        .post(expenseUrls.API_DELETE_EXPENSE(id))
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
      final String responseCreateExpense = useContainer['results'];
      return responseCreateExpense;
    }
    );
  }
}