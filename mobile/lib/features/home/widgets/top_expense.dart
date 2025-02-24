import 'package:flutter/material.dart';

import 'expense_card.dart';

class TopExpense extends StatefulWidget {
  const TopExpense({super.key});

  @override
  State<TopExpense> createState() => _TopExpenseState();
}

class _TopExpenseState extends State<TopExpense> {
  List<Map<String, dynamic>> expenses = [
    {
      "icon": Icons.shopping_cart,
      "title": "Shopping",
      "amount": "2,500,000",
      "percentage": "25%",
    },
    {
      "icon": Icons.sports_esports,
      "title": "Entertainment",
      "amount": "1,500,000",
      "percentage": "15%",
    },
    {
      "icon": Icons.school,
      "title": "Education",
      "amount": "1,000,000",
      "percentage": "10%",
    },
    {
      "icon": Icons.beach_access,
      "title": "Travel",
      "amount": "800,000",
      "percentage": "8%",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.cyanAccent, Colors.greenAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Top Expenses",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "December 2024",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),

          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return ExpenseCard(
                  icon: expense["icon"],
                  title: expense["title"],
                  amount: expense["amount"],
                  percentage: expense["percentage"],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
