import 'package:flutter/material.dart';

Icon getPriorityIcon(int priority) {
  switch (priority) {
    case 3:
      return const Icon(
        Icons.priority_high,
        color: Colors.red,
      );
    case 2:
      return const Icon(
        Icons.priority_high,
        color: Colors.yellow,
      );
    case 1:
      return const Icon(
        Icons.low_priority,
        color: Colors.green,
      );
    default:
      return const Icon(
        Icons.low_priority,
        color: Colors.blue,
      );
  }
}
