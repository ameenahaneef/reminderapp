import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newproj/screens/admin.dart';
import 'package:newproj/screens/adminmodel.dart';
import 'package:newproj/screens/categorydetails.dart';

class DietEdit extends StatefulWidget {
  final int selectedCategoryIndex;
   DietEdit({Key? key,required this.selectedCategoryIndex});

  @override
  State<DietEdit> createState() => _DietEditState();
}

class _DietEditState extends State<DietEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 127, 65, 138),
        title: const Text('Admin - Edit Category'),
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
  final List<List<TextEditingController>> mealControllers = List.generate(
    7,
    (index) => List.generate(
      3, // 3 meals per day
      (index) => TextEditingController(),
    ),
  );

  static const List<String> mealTimes = ['Breakfast', 'Lunch', 'Dinner'];
int selectedCategoryIndex=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchStoredData();
  }

  Future<void> fetchStoredData() async {
    // Fetch data from your storage (Hive in this case)
    // For simplicity, assuming you have a Category object stored in Hive
    var categoryBox = await Hive.openBox<Category>('categoryBox');

    if (categoryBox.isNotEmpty&&categoryBox.length>selectedCategoryIndex) {
      // Assuming you want to edit the first category found in the box
       print('Fetching data for index: $selectedCategoryIndex');
      var existingCategory = categoryBox.getAt(selectedCategoryIndex);
      if (existingCategory != null) {
        setState(() {
          categoryNameController.text = existingCategory.categoryName;
          descriptionController.text = existingCategory.description;

          // Set image if exists (you may need to modify this based on how you handle images)
          _image = existingCategory.imagePath.isNotEmpty
              ? File(existingCategory.imagePath)
              : null;

          // Set meal controllers
          for (int day = 0; day < 7; day++) {
            for (int meal = 0; meal < 3; meal++) {
              mealControllers[day][meal].text =
                  existingCategory.mealPlan[day][meal];
            }
          }
        });
      }
    }
  }

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
                    child: Center(
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
                  TextField(
                    controller: mealControllers[day][meal],
                    decoration: InputDecoration(
                      labelText: mealTimes[meal],
                    ),
                  ),
                const SizedBox(height: 8.0),
              ],
            ),
          const SizedBox(height: 16.0),
          ElevatedButton(
              onPressed: () {
                saveChanges();
              },
              child: Text('save changes')),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx1) => const AdminScreen()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }

  Future<void> saveChanges() async {
    // Fetch data from your storage (Hive in this case)
    var categoryBox = await Hive.openBox<Category>('categoryBox');

    if (categoryBox.isNotEmpty&&categoryBox.length>selectedCategoryIndex) {
       print('Saving changes for index: $selectedCategoryIndex');
      // Assuming you want to edit the first category found in the box
      var existingCategory = categoryBox.getAt(selectedCategoryIndex);
      if (existingCategory != null) {
        var updatedCategory = Category(
            categoryName: categoryNameController.text,
            description: descriptionController.text,
            imagePath: _image?.path ?? '',
            mealPlan: List.generate(
                7,
                (day) => List.generate(
                      3,
                      (meal) => mealControllers[day][meal].text,
                    )));

        categoryBox.putAt(selectedCategoryIndex, updatedCategory);
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return CategoryDisplay();
        }));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Changes saved successfully'),
          backgroundColor: Colors.green,),
        );
      }
    }
  }
}
