import 'package:flutter/material.dart';

import '../widgets/settingMenuTitle/app.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const TextStyle titleCardWallet = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle valueCardWallet = TextStyle(
    fontSize: 40,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle titleScreenWallet = TextStyle(
    fontSize: 28,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static TextStyle getTitleStyleOnSurface(BuildContext context) {
    return TextStyle(
      fontSize: 16,
      color: Theme.of(context).colorScheme.onSurface,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle getTitleStyleOutline(BuildContext context) {
    return TextStyle(
      fontSize: 14,
      color: Theme.of(context).colorScheme.outline,
      fontWeight: FontWeight.bold,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    'Setting',
                    style: titleScreenWallet,
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                    children: [
                      // Account setting
                      SettingMenuTitle(
                        icon: Icons.abc_outlined, title: 'Cài đặt ví và danh mục', subtitle: 'Thể loại, tiền tệ, số dư ban đầu',
                      ),
                      SettingMenuTitle(
                        icon: Icons.abc_outlined, title: 'Cài đặt tài khoản', subtitle: 'Ngôn ngữ, xuất nhập CSV',
                      )
                    ],
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
