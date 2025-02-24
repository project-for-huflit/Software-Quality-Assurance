import 'package:flutter/material.dart';
import 'package:mobile/features/transaction/presentation/expense_form.dart';
import 'package:mobile/features/transaction/presentation/income_form.dart';
import 'package:mobile/features/transaction/widget/button_confirm.dart';
import '../widget/custom_tab_bar.dart';

class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  final List<String> _recurring = [
    'Cash', 'Bank', 'Credit Card', 'Create Account'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text('Add Transaction',
              style: TextStyle(
                  fontSize: 24 ,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: CustomTabBar(),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: const TabBarView(
                    children: [
                      IncomeForm(),
                      ExpenseForm(),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ButtonConfirm(
                    onPressed: () {
                      // Xử lý xác nhận giao dịch
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}