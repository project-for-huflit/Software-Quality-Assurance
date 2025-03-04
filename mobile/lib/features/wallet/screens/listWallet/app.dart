import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:mobile/apis/wallets/models/wallet_model.dart';
import 'package:mobile/apis/wallets/wallet_api.dart';
import 'package:mobile/features/home/widgets/bottom_nav_bar.dart';
import 'package:mobile/features/home/widgets/top_expense.dart';
import 'package:mobile/features/wallet/widgets/card/card.dart';
import 'package:mobile/features/wallet/widgets/emptyCardForCreateWallet/card.dart';

class ListWalletScreen extends StatefulWidget {
  const ListWalletScreen({ super.key });

  @override
  _ListWalletScreenState createState() => _ListWalletScreenState();
}

class _ListWalletScreenState extends State<ListWalletScreen> {
  static const TextStyle titleScreenWallet = TextStyle(
    fontSize: 28,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  @override
  void initState() {
    super.initState();
    _fetchWallets();
  }

  List<Widget> carouselItems = [
    Image.asset('assets/image1.png'),
    Image.asset('assets/image2.png'),
    Image.asset('assets/image3.png'),
  ];

  List<Widget> walletItems = [];

  Future<void> _fetchWallets() async {
    try {
      List<WalletModel> wallets = await WalletServices().listWallet(); 
      // ignore: avoid_print
      // print("Error for get list wallet: $wallets");
      setState(() {
        walletItems = [
          ...wallets.map((wallet) => CardWallet(wallet: wallet)), 
          const CardCreateWallet(),
        ];
      });
    } catch (e) {
      // ignore: avoid_print
      print("Error for get list wallet: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BottomNavBarWidget(),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
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
              // const CardWallet(),
              CarouselSlider(
                items: walletItems,
                options: CarouselOptions(
                  // Set the desired options for the carousel
                  height: 200, // Set the height of the carousel
                  // aspectRatio: 16/9, // Set the aspect ratio of each item
                  viewportFraction: 1,
                ),
              ),
              const SizedBox(height: 28),
              const Positioned(
                top: 680,
                left: 20,
                right: 20,
                child: TopExpense(),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           'Top Expenses',
              //           style: getTitleStyleOnSurface(context),
              //           ),
              //         GestureDetector(
              //           onTap: () {
                  
              //           },
              //           child: Text(
              //             'January 2025',
              //             style: getTitleStyleOutline(context),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 16,),
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
    );
  }
}