import 'package:mobile/apis/common/enums/frequency.dart';
import 'package:mobile/apis/wallets/models/wallet.dart';

class Invoice {
  Invoice({
    required this.amount,
    required this.category,
    required this.byDate,
    required this.wallet,

    required this.startDate,
    required this.endDate,
    required this.frequency,
  });

  final int amount;
  final String category;
  final String byDate;
  final Wallet wallet;

  final String startDate;
  final String endDate;
  final Frequency frequency;

  String get walletId => wallet.id; 
  Enum get frequencyValue => frequency; 
}