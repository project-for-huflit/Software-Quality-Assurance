import 'package:flutter/material.dart';

class BottomNavbar {
  const BottomNavbar(this.icon, this.label);

  final IconData icon;
  final String label;
}

const List<BottomNavbar> bottomNavbar = <BottomNavbar>[
  BottomNavbar(Icons.inbox_rounded, 'Inbox'),
  BottomNavbar(Icons.article_outlined, 'Articles'),
  BottomNavbar(Icons.messenger_outline_rounded, 'Messages'),
  BottomNavbar(Icons.group_outlined, 'Groups'),
];