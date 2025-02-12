import 'package:flutter/material.dart';
// import 'package:mobile/features/feed/home/widgets/bottom_nav_bar.dart';
// import 'package:mobile/features/feed/home/widgets/total_balance.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: Theme.of(context).textTheme.headlineMedium!.fontSize! * 1.1 + 200.0,
      ),
      padding: const EdgeInsets.fromLTRB(20,60,20,0),
      decoration: BoxDecoration(
        // color: Colors.blue[600],
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromRGBO(0, 255, 135, 100),
            Color.fromRGBO(0, 229, 225, 100),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.centerLeft,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Good Morning',
              style: TextStyle(color: Colors.white, fontSize: 16)),
          Text('Hi User',
              style: TextStyle(color: Colors.white, fontSize: 24)),

        ],
      ),
    );
  }
}
