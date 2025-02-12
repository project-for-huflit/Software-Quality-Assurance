// import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile/features/feed/home/widgets/app_bar.dart';
// import 'package:mobile/features/feed/home/widgets/bottom_nav_bar.dart';
import 'package:mobile/features/feed/home/widgets/bottom_nav_blur_bar.dart';
import 'package:mobile/features/feed/home/widgets/top_expense.dart';
import 'package:mobile/features/feed/home/widgets/total_balance.dart';
import 'package:mobile/features/feed/home/widgets/overview_report.dart';
import 'package:mobile/features/feed/home/widgets/transaction_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: const BottomNavBarWidget(),
      extendBody: true,
      bottomNavigationBar: const BottomNavBlurBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 2, // Đảm bảo Stack đủ lớn để cuộn
          child: Stack(
            children: [
              const AppBarWidget(),
              const Positioned(
                top: 140,
                left: 20,
                right: 20,
                child: TotalBalanceWidget(),
              ),
              const Positioned(
                top: 300,
                left: 20,
                right: 20,
                child: OverViewReport(),
              ),
              const Positioned(
                top: 680,
                left: 20,
                right: 20,
                child: TopExpense(),
              ),
              const Positioned(
                  top: 920, left: 20,
                  child: Text("Transactions",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
              Positioned(
                top: 950, left: 20, right: 20,
                child: Column(
                  children: List.generate(4, (index) => const TransactionRow()),
                ), ),
            ],
          ),
        ),
      ),
    );
  }
}
