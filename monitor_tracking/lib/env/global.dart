import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> loadEnv() async {
  try {
    dotenv.load(fileName: "../../.env"); 
  } catch (e) {
    throw Exception('Error loading .env file: $e'); 
  }
}