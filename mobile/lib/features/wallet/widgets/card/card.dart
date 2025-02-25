import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardWallet extends StatefulWidget {
  const CardWallet({ super.key });

  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<CardWallet> {
  static const TextStyle titleCardWallet = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle valueCardWallet = TextStyle(
    fontSize: 40,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 2.2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.tertiary,
              ],
              transform: const GradientRotation(pi / 4)
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Colors.grey.shade300,
                offset: const Offset(5, 5)
              )
            ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Total balance',
                style: titleCardWallet,
              ),
              const Text(
                'Total balance',
                style: valueCardWallet,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Colors.white30,
                            shape: BoxShape.circle
                          ),
                          child: const Center(
                            child: Icon(
                              CupertinoIcons.arrow_down,
                              size: 12,
                              color: Colors.greenAccent
                            ),
                          ),
                        ),
                        const SizedBox(width: 8,),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Incomes',
                              style: titleCardWallet,
                            ),
                            Text(
                              '2500',
                              style: valueCardWallet,
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Colors.white30,
                            shape: BoxShape.circle
                          ),
                          child: const Center(
                            child: Icon(
                              CupertinoIcons.arrow_down,
                              size: 12,
                              color: Colors.greenAccent
                            ),
                          ),
                        ),
                        const SizedBox(width: 8,),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Invoices',
                              style: titleCardWallet,
                            ),
                            Text(
                              '2500',
                              style: valueCardWallet,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
    );
  }
}