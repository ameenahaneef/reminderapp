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
        //title: Text('User Screen - ${selectedCategory.categoryName}'),
        elevation: 0,
      ),
      body: Container(
        //width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height,
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.file(
                                  File(selectedCategory.imagePath),
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                    )),
                Center(child: Text('${selectedCategory.categoryName}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)),
                Card(
                    margin: EdgeInsets.all(16.0),
                  color:  Color.fromARGB(255, 220, 210, 223),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('${selectedCategory.description}',style: TextStyle(color: Colors.black),),
                    )),
                Center(child: Text('Meal Plan:',style: TextStyle(color: Colors.white,fontSize: 20),)),
                for (int day = 0; day < selectedCategory.mealPlan.length; day++)
                  Container(
                    width: double.infinity,
                    child: Card(
                      margin: EdgeInsets.all(16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Day ${day + 1}'),
                            for (int meal = 0;
                                meal < selectedCategory.mealPlan[day].length;
                                meal++)
                              Text(
                                  '${mealTimes[meal]}: ${selectedCategory.mealPlan[day][meal]}'),
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
