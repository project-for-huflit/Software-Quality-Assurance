import 'package:flutter/material.dart';

class TransactionRow extends StatelessWidget {
  const TransactionRow ({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.5),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color(0xffFFE5F3),
            offset: const Offset(0, 7),
            blurRadius: 15,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: Color(0xffFFE5F3),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Icon(
                Icons.shopping_bag_outlined,
                color: Colors.blue,
                size: 25
            ),
          ),

          const SizedBox(width: 15),

          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "buying some stuff",
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "6/5/2024 4:20pm",
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          )),

          const SizedBox(width: 15),

          Text(
            "- 1,000,000",
            maxLines: 1,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),

        ],
      ),
    );
  }
}
