import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:newproj/screens/adminmodel.dart';

class DatabaseOperations {
  static Future<void> saveCategory({
    required String categoryName,
    required String description,
    required File? image,
    required List<List<String>> mealPlan,
  }) async {
    // Check if any of the required fields is empty
    if (categoryName.isEmpty ||
        description.isEmpty ||
        image == null ||
        mealPlan.any((day) => day.any((meal) => meal.isEmpty))) {
          
      // Show an error message or handle the case where fields are empty
      print('Please fill in all the required fields');
      return;
    }

    var category = Category(
      categoryName: categoryName,
      description: description,
      imagePath: image.path ?? '', // Assuming imagePath is a String
      mealPlan: mealPlan,
    );

    print('Category Data: $category'); // Print the category data

    var categoryBox = Hive.box<Category>('categoryBox');
    categoryBox.add(category);
    print('Category added to Hive');
  }
  
}
