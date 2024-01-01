import 'dart:io';
import 'package:hive/hive.dart';
import 'package:newproj/screens/adminmodel.dart';

class DatabaseOperations {
  static Future<void> saveCategory({
    required String categoryName,
    required String description,
    required File? image,
    required List<List<String>> mealPlan,
  }) async {
    if (categoryName.isEmpty ||
        description.isEmpty ||
        image == null ||
        mealPlan.any((day) => day.any((meal) => meal.isEmpty))) {
          
      print('Please fill in all the required fields');
      return;
    }

    var category = Category(
      categoryName: categoryName,
      description: description,
      imagePath: image.path ?? '', 
      mealPlan: mealPlan,
    );

    print('Category Data: $category'); 

    var categoryBox = Hive.box<Category>('categoryBox');
    categoryBox.add(category);
    print('Category added to Hive');
  }
  
}
