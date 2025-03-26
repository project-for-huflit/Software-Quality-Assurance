import 'dart:convert';
import 'package:http/http.dart' as http;

class OCRService {
  static Future<String?> sendImageToOCR(String type, String imageBase64) async {
    final url = Uri.parse('http://10.0.2.2:3000/ocr/process');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "type": type,
          "imageBase64": imageBase64
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print("Response: ${responseData}");
        return responseData['data'];// Trả về kết quả OCR
      } else {
        print("❌ Lỗi từ OCR API (${response.statusCode}): ${responseData['message']}");
        return null;
      }
    } catch (e) {
      print("Lỗi gửi ảnh đến OCR: $e");
      return null;
    }
  }
}

