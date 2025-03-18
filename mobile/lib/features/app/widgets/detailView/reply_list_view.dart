import 'package:flutter/material.dart';

// import '../../../../__mock__/data.dart' as data;

class ReplyListView extends StatelessWidget {
  const ReplyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ListView(
        children: [
          const SizedBox(height: 8),
          // ...List.generate(data.replies.length, (index) {
          //   return const Padding(
          //     padding: EdgeInsets.only(bottom: 8.0),
          //   );
          // }),
        ],
      ),
    );
  }
}