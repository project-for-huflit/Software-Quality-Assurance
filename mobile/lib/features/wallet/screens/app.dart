import 'package:flutter/material.dart';

import 'createButtonWallet/app.dart';
import 'listWallet/app.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  static const List<String> wallets = [];

  static const TextStyle titleWallet = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  // @override
  // Widget build(BuildContext context) {
  //   return wallets.isEmpty ? CreateButtonWalletScreen() : ListWalletScreen();
  // }

  @override
  Widget build(BuildContext context) {
    // return const CreateButtonWalletScreen();
    return const ListWalletScreen();
  }
}
