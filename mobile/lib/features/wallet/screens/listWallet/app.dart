import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:mobile/features/home/widgets/bottom_nav_bar.dart';
import 'package:mobile/features/wallet/widgets/card/card.dart';

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

  List<Widget> walletItems = [
    const CardWallet(),
    const CardWallet(),
    const CardWallet(),
  ];


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
                  autoPlay: true, // Enable auto-play
                  autoPlayCurve: Curves.easeInOut, // Set the auto-play curve
                  autoPlayAnimationDuration: const Duration(milliseconds: 500), // Set the auto-play animation duration
                  aspectRatio: 16/9, // Set the aspect ratio of each item
                  // You can also customize other options such as enlargeCenterPage, enableInfiniteScroll, etc.
                ),
              ),
              const SizedBox(height: 28,),
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