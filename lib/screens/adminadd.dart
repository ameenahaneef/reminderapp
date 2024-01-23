import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newproj/screens/categorydetails.dart';
import 'package:newproj/screens/dbfunctions/admindataase.dart';
import 'package:newproj/screens/login.dart';

class AdminAdd extends StatelessWidget {
  const AdminAdd({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 127, 65, 138),
        title: const Text('Admin - Add Category'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return CategoryDisplay();
                }));
              },
              icon: const Icon(Icons.category))
        ],
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AddCategoryForm(),
      ),
    );
  }
}

class AddCategoryForm extends StatefulWidget {
  @override
  _AddCategoryFormState createState() => _AddCategoryFormState();
}

class _AddCategoryFormState extends State<AddCategoryForm> {
  File? _image;

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final List<List<List<TextEditingController>>> mealControllers = List.generate(
    7,
    (dayIndex) => List.generate(
      3,
      (mealIndex) => List.generate(
        3,
        (optionIndex) => TextEditingController(),
      ),
    ),
  );

  static const List<String> mealTimes = ['Breakfast', 'Lunch', 'Dinner'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: getImage,
            child: _image == null
                ? Container(
                    width: 250,
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.camera_alt, size: 50),
                    ),
                  )
                : Image.file(_image!),
          ),
          TextField(
            controller: categoryNameController,
            decoration: const InputDecoration(labelText: 'Category Name'),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          const SizedBox(height: 16.0),
          const Text('Meal Plan for 7 Days:'),
          for (int day = 0; day < 7; day++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Day ${day + 1}'),
                for (int meal = 0; meal < 3; meal++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${mealTimes[meal]} Options:'),
                      for (int option = 0; option < 3; option++)
                        TextField(
                          controller: mealControllers[day][meal][option],
                          decoration: InputDecoration(
                            labelText:
                                '${mealTimes[meal]} Option ${option + 1}',
                          ),
                        ),
                    ],
                  ),
                const SizedBox(height: 8.0),
              ],
            ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              if (categoryNameController.text.isEmpty ||
                  descriptionController.text.isEmpty ||
                  _image == null ||
                  mealControllers.any((day) => day.any(
                      (meal) => meal.any((option) => option.text.isEmpty)))) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Please fill all the fields'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('ok'))
                        ],
                      );
                    });
                print('Please fill in all the required fields');
                return;
              }

              File? imageFile = _image;

              List<List<List<String>>> mealPlan = mealControllers
                  .map((dayControllers) => dayControllers
                      .map((mealControllers) => mealControllers
                          .map((controller) => controller.text)
                          .toList())
                      .toList())
                  .toList();

              await DatabaseOperations.saveCategory(
                  categoryName: categoryNameController.text,
                  description: descriptionController.text,
                  image: imageFile,
                  mealPlan: mealPlan);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Stored successfully'),
                  backgroundColor: Colors.green,
                ),
              );

              setState(() {
                _image = null;
                categoryNameController.clear();
                descriptionController.clear();
                mealControllers.forEach((day) => day.forEach(
                    (meal) => meal.forEach((option) => option.clear())));
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 127, 65, 138),
            ),
            child: const Text('Save Category'),
          ),
          const SizedBox(height: 16.0),
          Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 127, 65, 138),
                borderRadius: BorderRadius.circular(20)),
            width: 100,
            height: 100,
            child: IconButton(
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('cancel'),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                );
                              },
                              child: const Text('OK'))
                        ],
                      );
                    });
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
