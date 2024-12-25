import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              // Within the RegisterScreen widget
              onPressed: () {
                // Navigate to the feed screen
                Navigator.pushNamed(context, '/login');
              },
              child: const Text('Register!'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Welcome! Please register in to access your feed.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
