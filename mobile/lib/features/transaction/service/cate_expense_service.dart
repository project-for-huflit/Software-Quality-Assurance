import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CateExpenseService{
  static Future<List<Map<String, dynamic>>> _fetchCategories() async {
    final response = await http.get(Uri.parse('${dotenv.env['API_URL']!}/cate-expense'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}