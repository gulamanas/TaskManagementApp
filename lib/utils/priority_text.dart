import 'package:flutter/material.dart';

Text getPriorityText(int priority) {
  switch (priority) {
    case 1:
      return const Text('Low');
    case 2:
      return const Text('Medium');
    case 3:
      return const Text('High');
    default:
      return const Text('None');
  }
}
