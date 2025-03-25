import 'dart:convert';
import 'package:http/http.dart' as http;

class OCRService {
  static Future<String?> sendImageToOCR(String type, String imageBase64) async {
    final url = Uri.parse('http://localhost:3000/ocr/process');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "type": type,
          "imageBase64": imageBase64
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("Response from OCR: ${responseData}");
        return responseData['text']; // Trả về kết quả OCR
      } else {
        print("Error from OCR: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Lỗi gửi ảnh đến OCR: $e");
      return null;
    }
  }
}

