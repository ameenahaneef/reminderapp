import 'package:hive/hive.dart';
import 'package:newproj/screens/medmodel.dart';

class DatabaseHelper {
  late Box boxes;
  late Box historyBox;

  DatabaseHelper() {
    boxes = Hive.box<MedicineModel>('MedicineModelBox');
    historyBox = Hive.box<MedicineModel>('MedicineHistoryBox');
  }

  Future<void> saveMedicineToHive({
    required String name,
    required String dosage,
    required String description,
    required String type,
    required String beforeOrAfter,
    required List<String> selectedTimes,
  }) async {
    MedicineModel medicine = MedicineModel(
      name: name,
      dosage: dosage,
      description: description,
      type: type,
      beforeOrAfter: beforeOrAfter,
      selectedTimes: selectedTimes,
    );

    await boxes.add(medicine);
    await historyBox.add(medicine);

    print('Data stored successfully');
    print('Name: $name');
    print('Dosage: $dosage');
    print('Description: $description');
    print('Type: $type');
    print('Times: $selectedTimes');
  }

  // void updateMedicine(MedicineModel oldMedicine, MedicineModel newMedicine) {
  //   int index =
  //       boxes.values.toList().indexWhere((medicine) => medicine == oldMedicine);
  //   if (index != -1) {
  //     boxes.putAt(index, newMedicine);
  //   }
  // }
  void updateMedicine(MedicineModel oldMedicine, MedicineModel newMedicine) {
  for (int i = 0; i < boxes.length; i++) {
    MedicineModel medicine = boxes.getAt(i)!;
    if (medicine.name == oldMedicine.name) {
      boxes.putAt(i, newMedicine);
      break; // Stop iterating once the medicine is updated
    }
  }
}


  Future<void> deleteMedicine(MedicineModel medicine) async {
    final index = boxes.values.toList().indexOf(medicine);
    if (index != -1) {
      boxes.deleteAt(index);
    }
  }
}
