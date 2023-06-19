import 'package:flutter/material.dart';

Widget interestChip(
    String label, Color color, Function(String) onInterestToggled) {
  return FilterChip(
    labelPadding: const EdgeInsets.all(2.0),
    avatar: CircleAvatar(
      backgroundColor: Colors.white70,
      child: Text(label[0].toUpperCase()),
    ),
    label: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: color,
    elevation: 6.0,
    shadowColor: Colors.grey[60],
    padding: const EdgeInsets.all(8.0),
    onSelected: (_) => {onInterestToggled(label)},
  );
}
