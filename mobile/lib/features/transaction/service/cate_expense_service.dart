import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CateExpenseService{
  Future<List<Map<String, dynamic>>> fetchCategories() async {
    final response = await http.get(Uri.parse('${dotenv.env['API_URL']!}/cate-expense'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final List<dynamic> data = jsonResponse["data"];
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}