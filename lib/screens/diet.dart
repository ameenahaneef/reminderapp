

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:newproj/screens/navbar.dart';
import 'package:newproj/screens/adminmodel.dart';
import 'package:newproj/screens/userdietscreen.dart'; // Import the Category class

class DietScreen extends StatelessWidget {
  const DietScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var categoryBox = Hive.box<Category>('categoryBox');
    List<Category> categories = categoryBox.values.toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 116, 74, 129),
        elevation: 0.0,
      ),
      drawer: NavBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.9],
            colors: [
              Color.fromARGB(255, 116, 74, 129),
              Color.fromARGB(255, 10, 9, 9),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // You can adjust the number of columns here
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              Category category = categories[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                    return UserScreen(selectedCategory:category);
                  }));
                  // Handle category tap, if needed
                },
                child: Card(
                  color: const Color.fromARGB(255, 189, 156, 195),
                  //elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                       // borderRadius: BorderRadius.only(topLeft: Radius.circular(28.0),topRight: Radius.circular(28.0)),
                        borderRadius: BorderRadius.circular(28),
                        child: Image.file(
                          File(category.imagePath), // Assuming imagePath is a valid file path
                          fit: BoxFit.cover,
                          height: 130.0, // Adjust the height as needed
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            category.categoryName,
                            style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
