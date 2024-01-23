import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newproj/screens/categorydetails.dart';
import 'package:newproj/screens/dbfunctions/admindataase.dart';
import 'adminmodel.dart';

class DietEdit extends StatefulWidget {
  final int selectedCategoryIndex;

  const DietEdit({Key? key, required this.selectedCategoryIndex})
      : super(key: key);

  @override
  State<DietEdit> createState() => _DietEditState();
}

class _DietEditState extends State<DietEdit> {
  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  File? _image;
  late List<List<List<TextEditingController>>> mealControllers;

  static const List<String> mealTimes = ['Breakfast', 'Lunch', 'Dinner'];

  @override
  void initState() {
    super.initState();
    mealControllers = List.generate(
      7,
      (day) => List.generate(
        3,
        (meal) => List.generate(
          3,
          (option) => TextEditingController(),
        ),
      ),
    );

    fetchStoredData();
  }

  Future<void> fetchStoredData() async {
    var categoryBox = await Hive.openBox<Category>('categoryBox');

    if (categoryBox.isNotEmpty &&
        categoryBox.length > widget.selectedCategoryIndex) {
      var existingCategory =
          categoryBox.getAt(widget.selectedCategoryIndex) as Category;
      if (existingCategory != null) {
        setState(() {
          categoryNameController.text = existingCategory.categoryName;
          descriptionController.text = existingCategory.description;

          _image = existingCategory.imagePath.isNotEmpty
              ? File(existingCategory.imagePath)
              : null;

          mealControllers = List.generate(
            7,
            (day) => List.generate(
              3,
              (meal) => List.generate(
                3,
                (option) => TextEditingController(
                    text: existingCategory.mealPlan[day][meal][option]),
              ),
            ),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 127, 65, 138),
        title: const Text('Edit Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                onPressed: () {
                  saveChanges();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 127, 65, 138),
                ),
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveChanges() async {
    var categoryBox = await Hive.openBox<Category>('categoryBox');

    if (categoryBox.isNotEmpty &&
        categoryBox.length > widget.selectedCategoryIndex) {
      var updatedCategory = Category(
        categoryName: categoryNameController.text,
        description: descriptionController.text,
        imagePath: _image?.path ?? '',
        mealPlan: List.generate(
          7,
          (day) => List.generate(
            3,
            (meal) => List.generate(
              3,
              (option) => mealControllers[day][meal][option].text,
            ),
          ),
        ),
      );

      await DatabaseOperations.updateCategory(
          widget.selectedCategoryIndex, updatedCategory);
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return CategoryDisplay();
      }));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Changes saved successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }
}
