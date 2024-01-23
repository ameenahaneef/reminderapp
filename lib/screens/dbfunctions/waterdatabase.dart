
import 'package:hive/hive.dart';
import 'package:newproj/screens/watermodel.dart';

class WaterHelper {
  static Future<bool> loadReminderData(Function(String) setState) async {
    final box = await Hive.openBox<String>('reminder_data');
    final reminderFrequency = box.get('reminderFrequency');

    if (reminderFrequency != null) {
      setState(reminderFrequency);
      return true;
    }
    return false;
  }

  static Future<void> loadConsumptionData(Function(int, DateTime) setState) async {
    final box = await Hive.openBox<ConsumptionData>('consumption_data');
    final lastConsumptionData = box.values.lastOrNull;

    if (lastConsumptionData != null) {
      setState(lastConsumptionData.consumedAmount, lastConsumptionData.consumedDay);
    }
  }

  
}
