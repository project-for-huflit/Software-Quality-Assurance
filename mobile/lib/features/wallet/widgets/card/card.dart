import 'package:flutter/material.dart';
import 'package:mobile/apis/wallets/models/wallet_model.dart';

class CardWallet extends StatelessWidget {
const CardWallet({ super.key, required this.wallet });

final WalletModel wallet;

  @override
  Widget build(BuildContext context) {
    return _buildCreditCard(
        color: const Color(0xFF090943),
        cardExpiration: wallet.name,
        cardHolder: wallet.type,
        amountMoney: wallet.amount);
  }

  Card _buildCreditCard({
    required Color color,
    required String cardHolder,
    required String cardExpiration,
    required int amountMoney,
  }) {
    return Card(
      elevation: 4.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        height: 200,
        // width: 
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:
              MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _buildDetailsBlock(
                  label: 'wallet',
                  value: cardHolder,
                ),
              ],
            ),
            Text(
              amountMoney.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontFamily: 'CourrierPrime',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildDetailsBlock({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey, 
            fontSize: 12,
            fontWeight: FontWeight.bold
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white, 
            fontSize: 18, 
            fontWeight: FontWeight.bold
          ),
        )
      ],
    );
  }
}
