import 'package:flutter/material.dart';

class CreateButtonWalletScreen extends StatelessWidget {
const CreateButtonWalletScreen({ super.key });

  static const TextStyle titleWallet = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Account',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/wallet/create');
          },
          child: Container(
            width: 336,
            height: 200,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(241, 243, 242, 100),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 40,
                  color: Colors.black54,
                ),
                SizedBox(height: 10),
                Text(
                  'Add Account',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}