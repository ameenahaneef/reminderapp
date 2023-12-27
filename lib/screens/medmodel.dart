import 'package:hive/hive.dart';
part 'medmodel.g.dart';
@HiveType(typeId: 2)
class MedicineModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String dosage;
  @HiveField(2)
  String description;
  @HiveField(3)
  String type;
  @HiveField(4)
  List<DateTime> selectedDates;
  @HiveField(5)
  List<String> selectedTimes;

  MedicineModel(
      {required this.name,
      required this.dosage,
      required this.description,
      required this.type,
      List<DateTime>? selectedDates,
      List<String>? selectedTimes})
      : selectedDates = selectedDates ?? [],
        selectedTimes = selectedTimes ?? [];
}
