import 'package:hive/hive.dart';

part 'adminmodel.g.dart';

@HiveType(typeId: 3) 
class Category {
  @HiveField(0)
  late final String categoryName;

  @HiveField(1)
  late final String description;

  @HiveField(2)
  late final String imagePath;

  @HiveField(3)
  final List<List<String>> mealPlan;

  Category({
    required this.categoryName,
    required this.description,
    required this.imagePath,
    required this.mealPlan,
  });
  
}
