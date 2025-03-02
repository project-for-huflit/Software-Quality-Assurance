import 'package:flutter/material.dart';

class CardWallet extends StatefulWidget {
  const CardWallet({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CardState createState() => _CardState();
}

class _CardState extends State<CardWallet> {

  @override
  Widget build(BuildContext context) {
    return _buildCreditCard(
        color: const Color(0xFF090943),
        cardExpiration: "TPB xxxx 8944",
        cardHolder: "TPB xxxx 8944",
        cardNumber: "3546 7532 XXXX 9742");
  }

  Card _buildCreditCard(
      {required Color color,
      required String cardNumber,
      required String cardHolder,
      required String cardExpiration}) {
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
              cardNumber,
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
              color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
