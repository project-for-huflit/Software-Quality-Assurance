import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/overview_report.dart';
import '../widgets/top_expense.dart';
import '../widgets/total_balance.dart';
import '../widgets/transaction_row.dart';

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
          height: MediaQuery.of(context).size.height * 2, // Đảm bảo Stack đủ lớn để cuộn
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
              Positioned(
                  child: Text("Transactions",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  top: 920, left: 20),
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
