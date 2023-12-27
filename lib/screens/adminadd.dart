import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newproj/screens/adminmodel.dart';
import 'package:newproj/screens/categorydetails.dart';
import 'package:newproj/screens/login.dart';

class AdminAdd extends StatelessWidget {
  const AdminAdd({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color.fromARGB(255, 127, 65, 138),
        title: const Text('Admin - Add Category'),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
              return CategoryDisplay();
            }));
          }, icon: Icon(Icons.category))
        ],
        
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
  final TextEditingController descriptionController=TextEditingController();
  final List<List<TextEditingController>> mealControllers = List.generate(
    7,
    (index) => List.generate(
      3, // 3 meals per day
      (index) => TextEditingController(),
    ),
  );

  static const List<String> mealTimes = ['Breakfast', 'Lunch', 'Dinner'];



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(onTap: getImage,child: _image==null?Container(width:250,height: 200,color: Colors.grey[300],child: Center(child: Icon(Icons.camera_alt,size: 50),),):Image.file(_image!),),
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

// Check if any of the required fields is empty
    if (categoryNameController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        _image == null ||
        mealControllers.any((day) => day.any((meal) => meal.text.isEmpty))) {
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              title: Text('Error'),
              content: Text('Please fill all the fields'),
              actions: [
                TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text('ok'))
              ],
            );
          });
      // Show an error message or handle the case where fields are empty
      print('Please fill in all the required fields');
      return;
    }

    var category = Category(
      categoryName: categoryNameController.text,
      description: descriptionController.text,
      imagePath: _image?.path ?? '', // Assuming imagePath is a String
      mealPlan: mealControllers.map((controllers) => controllers.map((controller) => controller.text).toList()).toList(),
    );


  print('Category Data: $category'); // Print the category data

    var categoryBox = Hive.box<Category>('categoryBox');
    categoryBox.add(category);
    ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('stored successfully'),
          backgroundColor: Colors.green,),
        );
     print('Category added to Hive');
     setState(() {
       _image=null;
       categoryNameController.clear();
       descriptionController.clear();
        mealControllers.forEach((day) => day.forEach((meal) => meal.clear()));
     });
    




     
    print('Retrieved Category Data: ${category.categoryName}');// Print a message indicating 
  },
  child: const Text('Save Category'),
),

          const SizedBox(height: 16.0),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx1) => const LoginScreen()),
                (route) => false,
              );
              
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
