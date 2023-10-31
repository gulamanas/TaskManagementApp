import 'package:flutter/material.dart';
import 'package:task_management_app/data/category.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];
  int _nextCategoryId = 1;

  List<Category> get categories => _categories;

  void createCategory(String name) {
    final newCategory = Category(id: _nextCategoryId, name: name);
    _categories.add(newCategory);
    _nextCategoryId++;
    notifyListeners();
  }
}
