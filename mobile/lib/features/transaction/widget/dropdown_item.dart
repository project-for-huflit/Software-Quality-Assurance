import 'package:flutter/material.dart';

DropdownMenuItem<String> buildDropdownItem(String label, IconData icon) {
  return DropdownMenuItem<String>(
    value: label,
    child: Row(
      children: [
        Icon(icon, color: Colors.pink),
        const SizedBox(width: 8),
        Text(label),
      ],
    ),
  );
}
