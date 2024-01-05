import 'package:hive_flutter/hive_flutter.dart';
 part 'watermodel.g.dart';
@HiveType(typeId:4 )
class ConsumptionData{
  @HiveField(0)
  late DateTime consumedDay;
  @HiveField(1)
  late int consumedAmount;
  @HiveField(2)
  late String? reminderInterval;
ConsumptionData({
  required this.consumedDay,required this.consumedAmount,this.reminderInterval
});
}