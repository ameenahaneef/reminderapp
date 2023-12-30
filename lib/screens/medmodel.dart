
import 'package:hive/hive.dart';

part 'medmodel.g.dart';
@HiveType(typeId: 2)
class MedicineModel extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String dosage;

  @HiveField(2)
  late String description;

  @HiveField(3)
  late String type;

  @HiveField(4)
  late String foodTime;

  @HiveField(5)
  late int frequency;

  @HiveField(6)
  late String startingTime;

  MedicineModel({
    required this.name,
    required this.dosage,
    required this.description,
    required this.type,
    required this.foodTime,
    required this.frequency,
    required this.startingTime,
  });
}
