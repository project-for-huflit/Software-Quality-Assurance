import 'package:flutter/material.dart';
import 'package:mobile/features/feed/home/widgets/app_bar.dart';
import 'package:mobile/features/feed/home/widgets/bottom_nav_bar.dart';
import 'package:mobile/features/feed/home/widgets/top_expense.dart';
import 'package:mobile/features/feed/home/widgets/total_balance.dart';
import 'package:mobile/features/feed/home/widgets/overview_report.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBarWidget(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1.5, // Đảm bảo Stack đủ lớn để cuộn
          child: Stack(
            children: [
              AppBarWidget(),
              Positioned(
                top: 140,
                left: 20,
                right: 20,
                child: TotalBalanceWidget(),
              ),
              Positioned(
                top: 300,
                left: 20,
                right: 20,
                child: OverViewReport(),
              ),
              Positioned(
                top: 680,
                left: 20,
                right: 20,
                child: TopExpense(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
