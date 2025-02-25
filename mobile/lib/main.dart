import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile/features/wallet/screens/app.dart';
import '/features/auth/login/presentation/login_screen.dart';
import '/features/auth/register/presentation/register_screen.dart';
import '/features/launch/app.dart';

import 'features/home/presentation/home_screen.dart';
import 'features/setting/screens/app.dart';
import 'features/wallet/screens/createWallet/app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env"); 
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TrackingApp());
}

class TrackingApp extends StatelessWidget {
  const TrackingApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tracking OCR ticket',
      // theme: ThemeData(
      //   // This is the theme of your application.
      //   //
      //   // TRY THIS: Try running your application with "flutter run". You'll see
      //   // the application has a purple toolbar. Then, without quitting the app,
      //   // try changing the seedColor in the colorScheme below to Colors.green
      //   // and then invoke "hot reload" (save your changes or press the "hot
      //   // reload" button in a Flutter-supported IDE, or press "r" if you used
      //   // the command line to start the app).
      //   //
      //   // Notice that the counter didn't reset back to zero; the application
      //   // state is not lost during the reload. To reset the state, use hot
      //   // restart instead.
      //   //
      //   // This works for code too, not just values: Most code changes can be
      //   // tested with just a hot reload.
      //   colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 104, 35, 222)),
      //   useMaterial3: true,
      // ),

      theme: ThemeData.light(useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/wallet': (context) => const WalletScreen(),
        '/wallet/create': (context) => const CreateWalletScreen(),
        // '/wallet': (context) => const WalletScreen(),
        // '/feed': (context) => Feed (currentUser: data.user_0),
        '/setting': (context) => const SettingsScreen(),
        '/home': (context) => const HomeScreen(),
      },
      
    );
  }
}
