import 'package:flutter/material.dart';

class BottomNavbar {
  const BottomNavbar(this.icon, this.label);

  final IconData icon;
  final String label;
}

const List<BottomNavbar> bottomNavbar = <BottomNavbar>[
  BottomNavbar(Icons.inbox_rounded, 'Home'),
  BottomNavbar(Icons.article_outlined, 'Saved'),
  BottomNavbar(Icons.messenger_outline_rounded, 'Wallet'),
  BottomNavbar(Icons.group_outlined, 'Settings'),
];