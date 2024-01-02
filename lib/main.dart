import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newproj/screens/adminmodel.dart';

import 'package:newproj/screens/medmodel.dart';
import 'package:newproj/screens/model.dart';
import 'package:newproj/screens/splash.dart';
const saveKeyName = 'UserLoggedIn';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ModelAdapter());
  Hive.registerAdapter(MedicineModelAdapter());
  Hive.registerAdapter(CategoryAdapter());
  await Hive.openBox<Model>('Modelbox');
  await Hive.openBox<MedicineModel>('MedicineModelBox');
   await Hive.openBox<MedicineModel>('MedicineHistoryBox');
    await Hive.openBox<Category>('categoryBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: SplashScreen(),
    );
  }
}
