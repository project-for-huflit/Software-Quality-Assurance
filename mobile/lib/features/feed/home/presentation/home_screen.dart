import 'package:flutter/material.dart';
import 'package:mobile/features/app/widgets/navigation/bottom_navigation.dart';
import 'package:mobile/features/feed/home/widgets/app_bar.dart';
import 'package:mobile/features/feed/home/widgets/bottom_nav_bar.dart';
import 'package:mobile/features/feed/home/widgets/total_balance.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavBarWidget(),
        backgroundColor: Colors.white,
        body: Container(
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    AppBarWidget(),
                    Positioned(
                      top: 140,
                      left: 20,
                      right: 20,
                      child:
                        TotalBalanceWidget(),
                    ),
                  ]
              ),),
            ],
          ),
        )
    );
  }
}

