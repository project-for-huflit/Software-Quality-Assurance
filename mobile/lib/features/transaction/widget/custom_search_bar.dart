import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SearchBar(
        controller: controller,
        onChanged: onChanged,
        hintText: 'Search Category',
        leading: const Icon(Icons.search),
      ),
    );
  }
}
