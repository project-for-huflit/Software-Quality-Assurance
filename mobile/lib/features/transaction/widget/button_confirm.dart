import 'package:flutter/material.dart';
import 'package:mobile/features/transaction/widget/button_confirm.dart';

class ButtonConfirm extends StatelessWidget {
  final VoidCallback onPressed;

  const ButtonConfirm({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: const Text(
          'Confirm',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
