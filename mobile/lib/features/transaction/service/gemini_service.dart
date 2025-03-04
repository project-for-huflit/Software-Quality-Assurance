import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  Future<void> processText(String ocrText, String type) async {
    final apiKey = dotenv.env['API_KEY_GEMINI'];

    try {
      final response = await http.post(
        Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [
            {
            "parts":[
              {"text": 'Sắp xếp lại dữ liệu $type  từ dữ liệu OCR sau: $ocrText'}]
          }]
        }),
      );
      if (response.statusCode == 200){
        final data = jsonDecode(response.body);
        String generatedText = data['candidates'][0]['content']['parts'][0]['text'];
        print('check data $data');
      }else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error processing text: $e');
    }
  }
}
