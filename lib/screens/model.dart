
import 'package:hive/hive.dart';
part 'model.g.dart';
@HiveType(typeId: 1)
class Model{
  @HiveField(0)
  String name;
  @HiveField(1)
  String email;
  @HiveField(2)
  String password;
Model({required this.name,required this.email,required this.password});
}

