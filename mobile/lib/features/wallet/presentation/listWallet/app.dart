import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/features/feed/home/widgets/bottom_nav_bar.dart';
import 'package:mobile/features/feed/home/widgets/top_expense.dart';

class ListWalletScreen extends StatefulWidget {
  const ListWalletScreen({ super.key });

  @override
  _ListWalletScreenState createState() => _ListWalletScreenState();
}

class _ListWalletScreenState extends State<ListWalletScreen> {

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

  static const TextStyle titleScreenWallet = TextStyle(
    fontSize: 28,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static TextStyle getTitleStyleOnSurface(BuildContext context) {
    return TextStyle(
      fontSize: 16,
      color: Theme.of(context).colorScheme.onSurface,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle getTitleStyleOutline(BuildContext context) {
    return TextStyle(
      fontSize: 14,
      color: Theme.of(context).colorScheme.outline,
      fontWeight: FontWeight.bold,
    );
  }

  List<Widget> carouselItems = [
    Image.asset('assets/image1.png'),
    Image.asset('assets/image2.png'),
    Image.asset('assets/image3.png'),
  ];


  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      bottomNavigationBar: const BottomNavBarWidget(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height *1.5,
          child: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Column(
                        children: [
                          Text(
                            'Wallet',
                            style: titleScreenWallet,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Container(
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
                      const SizedBox(height: 28,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Top Expenses',
                                style: getTitleStyleOnSurface(context),
                                ),
                              GestureDetector(
                                onTap: () {
                          
                                },
                                child: Text(
                                  'January 2025',
                                  style: getTitleStyleOutline(context),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16,),
                      CarouselSlider(
                        items: carouselItems,
                        options: CarouselOptions(
                          // Set the desired options for the carousel
                          height: 150, // Set the height of the carousel
                          // autoPlay: true, // Enable auto-play
                          // autoPlayCurve: Curves.easeInOut, // Set the auto-play curve
                          // autoPlayAnimationDuration: Duration(milliseconds: 500), // Set the auto-play animation duration
                          aspectRatio: 16/9, // Set the aspect ratio of each item
                          // You can also customize other options such as enlargeCenterPage, enableInfiniteScroll, etc.
                        ),
                      ),
                      const SizedBox(height: 16),
                      const TopExpense()
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       'Transactions',
                      //       style: getTitleStyleOnSurface(context),
                      //       ),
                      //     GestureDetector(
                      //       onTap: () {
                        
                      //       },
                      //       child: Text(
                      //         'Views all',
                      //         style: getTitleStyleOutline(context),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
            ),
        ),
      ),
    );
  }
}