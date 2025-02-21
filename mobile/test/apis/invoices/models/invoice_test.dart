import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/apis/common/enums/frequency.dart';
import 'package:mobile/apis/invoices/models/invoice.dart';
import 'package:mobile/apis/wallets/models/wallet.dart';

void main() {
  // ignore: unused_local_variable
  late Invoice invoice;

  body() {
    invoice = Invoice(
      amount: 0,
      category: '',
      byDate: '',
      wallet: Wallet(
        id: '', 
        nameWallet: '', 
        typeWallet: '', 
        currency: '', 
        amount: 0
      ),

      startDate: '',
      endDate: '',
      frequency: Frequency.threeMonths, 
    );
  }

  setUpAll(body);
} 