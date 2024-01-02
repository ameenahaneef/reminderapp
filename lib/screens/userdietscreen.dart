import 'dart:io';
import 'package:flutter/material.dart';
import 'package:newproj/screens/adminmodel.dart';

class UserScreen extends StatelessWidget {
  final Category selectedCategory;

  UserScreen({required this.selectedCategory});
  static const List<String> mealTimes = ['Breakfast', 'Lunch', 'Dinner'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 116, 74, 129),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.2, 0.4],
            colors: [
              Color.fromARGB(255, 116, 74, 129),
              Color.fromARGB(255, 10, 9, 9),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.file(
                    File(selectedCategory.imagePath),
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  '${selectedCategory.categoryName}',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    color: Color.fromARGB(255, 220, 210, 223),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '${selectedCategory.description}',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    )),
                const Center(
                    child: Text(
                  'Meal Plan:',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
                for (int day = 0; day < selectedCategory.mealPlan.length; day++)
                  Container(
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: const Color.fromARGB(255, 220, 210, 223),
                      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Day ${day + 1}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            for (int meal = 0;
                                meal < selectedCategory.mealPlan[day].length;
                                meal++)
                              ListTile(
                                title: Text(
                                  mealTimes[meal],
                                  style: const TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  selectedCategory.mealPlan[day][meal],
                                  style: const TextStyle(fontSize: 16,color: Colors.black),
                                ),
                              ),
                            const SizedBox(height: 8.0),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
