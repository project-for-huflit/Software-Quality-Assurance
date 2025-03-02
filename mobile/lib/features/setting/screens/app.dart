import 'package:flutter/material.dart';
import 'package:mobile/features/home/widgets/bottom_nav_bar.dart';
import 'package:mobile/features/setting/widgets/settingMenu/setting_menu.dart';


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
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BottomNavBarWidget(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Column(
                  children: [
                    Text(
                      'Setting',
                      style: titleScreenWallet,
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                      children: [
                        // const SectionHeading(title: 'account'),
                        const SizedBox(height: 16),

                        SettingMenu(
                          icon: Icons.add_chart_outlined,
                          title: 'Irorem isoasdoj',
                          subTitle: 'Set shopping delivery address',
                          onTap: () {},
                        )
                      ],
                    ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
