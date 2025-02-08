import 'package:flutter/material.dart';

class BarView extends StatelessWidget {
  final Map cObj;
  final double barWidth;
  final double maxVal;
  const BarView({super.key,
    required this.cObj,
    required this.barWidth,
    required this.maxVal});

  @override
  Widget build(BuildContext context) {
    var height = 180 - 16 - 16;

    var incomeVal = double.tryParse(cObj["income"].toString()) ?? 0.0;
    var expenseVal = double.tryParse(cObj["expense"].toString()) ?? 0.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [

        Container(
          width: barWidth,
          height: incomeVal * height / maxVal,
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(5)
          ),
        ),

        const SizedBox(height: 4),

        Container(
          width: barWidth,
          height: expenseVal * height / maxVal,
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5)
          ),
        ),

        const SizedBox(height: 4),
        Text(
          cObj["name"].toString(),
          style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }
}
