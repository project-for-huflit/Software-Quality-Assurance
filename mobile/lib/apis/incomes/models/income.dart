import 'package:mobile/apis/wallets/models/wallet.dart';

class Income {
  Income({
    required this.amount,
    required this.category,
    required this.byDate,
    required this.wallet,

    required this.startDate,
    required this.endDate,
    required this.frequency 
  });

  final int amount;
  final String category;
  final String byDate;
  final Wallet wallet;

  final String startDate;
  final String endDate;
  final Enum frequency;

  String get walletId => wallet.id; 
}