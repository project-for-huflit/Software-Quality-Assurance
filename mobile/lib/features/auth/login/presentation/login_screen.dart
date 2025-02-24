import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              // Within the LoginScreen widget
              onPressed: () {
                // Navigate to the feed screen
                Navigator.pushNamed(context, '/home');
              },
              child: const Text('Login!'),
            ),
            const SizedBox(height: 16), // Khoảng cách giữa nút và đoạn text
            const Text(
              'Welcome! Please log in to access your feed.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 24),
            RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: const TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(
                    text: 'Register',
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Điều hướng đến màn hình đăng ký
                        Navigator.pushNamed(context, '/register');
                      },
                  ),
                  const TextSpan(
                    text: ' now!',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
