import 'package:flutter_dotenv/flutter_dotenv.dart';

class FirebaseOptionsWeb {
  final String apiKey = dotenv.env['WEB_apiKey'] ?? '';
  final String appId = dotenv.env['WEB_appId'] ?? '';
  final String messagingSenderId = dotenv.env['WEB_messagingSenderId'] ?? '';
  final String projectId = dotenv.env['WEB_projectId'] ?? '';
  final String authDomain = dotenv.env['WEB_authDomain'] ?? '';
  final String storageBucket = dotenv.env['WEB_storageBucket'] ?? '';
  final String measurementId = dotenv.env['WEB_measurementId'] ?? '';
}

class FirebaseOptionsAndroid {
  final String apiKey = dotenv.env['ANDROID_apiKey'] ?? '';
  final String appId = dotenv.env['ANDROID_appId'] ?? '';
  final String messagingSenderId = dotenv.env['ANDROID_messagingSenderId'] ?? '';
  final String projectId = dotenv.env['ANDROID_projectId'] ?? '';
  final String storageBucket = dotenv.env['ANDROID_storageBucket'] ?? '';
}

class FirebaseOptionsWindow {
  final String apiKey = dotenv.env['WINDOWS_apiKey'] ?? '';
  final String appId = dotenv.env['WINDOWS_appId'] ?? '';
  final String messagingSenderId = dotenv.env['WINDOWS_messagingSenderId'] ?? '';
  final String projectId = dotenv.env['WINDOWS_projectId'] ?? '';
  final String authDomain = dotenv.env['WINDOWS_authDomain'] ?? '';
  final String storageBucket = dotenv.env['WINDOWS_storageBucket'] ?? '';
  final String measurementId = dotenv.env['WINDOWS_measurementId'] ?? '';
}

class FirebaseOptionsIos {
  final String apiKey = dotenv.env['IOS_apiKey'] ?? '';
  final String appId = dotenv.env['IOS_appId'] ?? '';
  final String messagingSenderId = dotenv.env['IOS_messagingSenderId'] ?? '';
  final String projectId = dotenv.env['IOS_projectId'] ?? '';
  final String storageBucket = dotenv.env['IOS_storageBucket'] ?? '';
  final String iosBundleId = dotenv.env['IOS_iosBundleId'] ?? '';
}

class FirebaseOptionsMacos {
  final String apiKey = dotenv.env['MAXOS_apiKey'] ?? '';
  final String appId = dotenv.env['MAXOS_appId'] ?? '';
  final String messagingSenderId = dotenv.env['MAXOS_messagingSenderId'] ?? '';
  final String projectId = dotenv.env['MAXOS_projectId'] ?? '';
  final String storageBucket = dotenv.env['MAXOS_storageBucket'] ?? '';
  final String iosBundleId = dotenv.env['MAXOS_iosBundleId'] ?? '';
}

class UrlApi {
  final String urlApi = dotenv.env['FLUTTER_URL_API'] ?? '';
}

final webConfig = FirebaseOptionsWeb();
final androidConfig = FirebaseOptionsAndroid();
final windowsConfig = FirebaseOptionsWindow();
final iosConfig = FirebaseOptionsIos();
final macosConfig = FirebaseOptionsMacos();

final urlApiConfig = UrlApi();