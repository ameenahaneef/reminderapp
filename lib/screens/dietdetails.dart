import 'dart:io';

import 'package:flutter/material.dart';

import 'adminmodel.dart';

class DietDetails extends StatelessWidget {
  final Category category;
  final List<String> mealTimes = ['Breakfast', 'Lunch', 'Dinner'];

  DietDetails({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 127, 65, 138),
        title: Text('Diet Details - ${category.categoryName}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Center(
              child: 
              
              FadeInImage(placeholder: AssetImage('assets/images/360_F_109403481_g8LbMgibBxrnl7CBc201wcJsNihOWTF2.webp'), image: FileImage(File(category.imagePath)),fit: BoxFit.cover,)
            ),
            Center(child: Text(category.categoryName)),
            Card(
                margin: const EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(category.description),
                )),
            const Center(child: Text('Meal Plan:')),
            for (int day = 0; day < category.mealPlan.length; day++)
              SizedBox(
                width: double.infinity,
                child: Card(
                  margin: const EdgeInsets.all(16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Day ${day + 1}'),
                        for (int meal = 0;
                            meal < category.mealPlan[day].length;
                            meal++)
                          Text(
                              '${mealTimes[meal]}: ${category.mealPlan[day][meal]}',),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
