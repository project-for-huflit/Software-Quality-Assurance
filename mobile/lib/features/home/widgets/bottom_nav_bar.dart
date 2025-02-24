import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/features/transaction/presentation/transaction.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(128, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            // offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            // spacing: 10,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.home_outlined, color: Colors.blueAccent),
                iconSize: 32,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.pie_chart_outline, color: Colors.blueAccent),
                iconSize: 32,
              ),
            ],
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              customBorder: CircleBorder(),
              splashColor: Colors.orange.withOpacity(0.4),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => const Transaction()),
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.orangeAccent,
                  shape: BoxShape.circle,
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.orangeAccent,
                  //     blurRadius: 10,
                  //     spreadRadius: 2,
                  //   ),
                  // ],
                ),
                padding: const EdgeInsets.all(20),
                child: const Text(
                  '+',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
              ),
            ),
          ),
          Row(
            // spacing: 10,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.wallet_outlined, color: Colors.blueAccent), // Biểu tượng màu xanh dương
                iconSize: 32,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person_outline, color: Colors.blueAccent), // Biểu tượng màu xanh dương
                iconSize: 32,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
