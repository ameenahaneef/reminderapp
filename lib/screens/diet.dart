import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:newproj/screens/navbar.dart';
import 'package:newproj/screens/adminmodel.dart';
import 'package:newproj/screens/userdietscreen.dart';

class DietScreen extends StatelessWidget {
  const DietScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var categoryBox = Hive.box<Category>('categoryBox');
    List<Category> categories = categoryBox.values.toList();

    Category hardcodedCategory = Category(
      categoryName: 'Paleo Diet',
      description:
          'The paleo diet is a very popular diet that is effective for weight loss and general health improvement. Its currently the world’s most popular diet.It centers on unprocessed foods believed to resemble those available to some of humanitys paleolithic ancestors.',
      imagePath: 'assets/images/paleo.jpeg',
      mealPlan: [
        [
          [
            'eggs and vegetables fried in olive oil, one piece of fruit',
            'chicken salad with olive oil, a handful of nuts',
            'burgers (no bun) fried in butter, vegetables, salsa'
          ],
          [
            'eggs and vegetables fried in olive oil, one piece of fruit',
            'chicken salad with olive oil, a handful of nuts',
            'burgers (no bun) fried in butter, vegetables, salsa'
          ],
          [
            'eggs and vegetables fried in olive oil, one piece of fruit',
            'chicken salad with olive oil, a handful of nuts',
            'burgers (no bun) fried in butter, vegetables, salsa'
          ],
        ],
        [
          [
            'bacon, eggs, one piece of fruit',
            'leftover burgers from the night before',
            'baked salmon with vegetables'
          ],
          [
            'bacon, eggs, one piece of fruit',
            'leftover burgers from the night before',
            'baked salmon with vegetables'
          ],
          [
            'bacon, eggs, one piece of fruit',
            'leftover burgers from the night before',
            'baked salmon with vegetables'
          ],
        ],
        [
          [
            'leftover salmon and vegetables from the night before',
            'sandwich in a lettuce leaf, with meat and fresh vegetables',
            'ground beef stir-fry with vegetables, berries'
          ],
          [
            'leftover salmon and vegetables from the night before',
            'sandwich in a lettuce leaf, with meat and fresh vegetables',
            'ground beef stir-fry with vegetables, berries'
          ],
          [
            'leftover salmon and vegetables from the night before',
            'sandwich in a lettuce leaf, with meat and fresh vegetables',
            'ground beef stir-fry with vegetables, berries'
          ],
        ],
        [
          [
            'eggs, one piece of fruit',
            'leftover stir-fry from the night before, a handful of nuts ',
            'fried pork, vegetables'
          ],
          [
            'eggs, one piece of fruit',
            'leftover stir-fry from the night before, a handful of nuts',
            'fried pork, vegetables'
          ],
          [
            'eggs, one piece of fruit',
            'leftover stir-fry from the night before, a handful of nuts',
            'fried pork, vegetables'
          ],
        ],
        [
          [
            'eggs and vegetables fried in olive oil, one piece of fruit',
            'chicken salad with olive oil, a handful of nuts',
            'steak, vegetables, sweet potatoes'
          ],
          [
            'eggs and vegetables fried in olive oil, one piece of fruit',
            'chicken salad with olive oil, a handful of nuts',
            'steak, vegetables, sweet potatoes'
          ],
          [
            'eggs and vegetables fried in olive oil, one piece of fruit',
            'chicken salad with olive oil, a handful of nuts',
            'steak, vegetables, sweet potatoes'
          ],
        ],
        [
          [
            'bacon, eggs, one piece of fruit',
            'leftover steak and vegetables from the night before',
            'baked tilapia, vegetables, avocado'
          ],
          [
            'bacon, eggs, one piece of fruit',
            'leftover steak and vegetables from the night before',
            'baked tilapia, vegetables, avocado'
          ],
          [
            'bacon, eggs, one piece of fruit',
            'leftover steak and vegetables from the night before',
            'baked tilapia, vegetables, avocado'
          ],
        ],
        [
          [
            'leftover salmon and vegetables from the night before',
            'sandwich in a lettuce leaf, with meat and fresh vegetables',
            'grilled chicken wings, vegetables, salsa'
          ],
          [
            'leftover salmon and vegetables from the night before',
            'sandwich in a lettuce leaf, with meat and fresh vegetables',
            'grilled chicken wings, vegetables, salsa'
          ],
          [
            'leftover salmon and vegetables from the night before',
            'sandwich in a lettuce leaf, with meat and fresh vegetables',
            'grilled chicken wings, vegetables, salsa'
          ],
        ],
      ],
    );

    categories.add(hardcodedCategory);

    Category ketoCategory = Category(
      categoryName: 'Mediteranean Diet',
      description:
          'The Mediterranean diet is an excellent diet that has been thoroughly studied. It’s particularly effective for heart disease prevention.It emphasizes foods that were commonly eaten around the Mediterranean region during the 20th century and earlier.As such, it includes plenty of vegetables, fruits, fish, poultry, whole grains, legumes, dairy products, and extra virgin olive oil.',
      imagePath: 'assets/images/mediteraneean-min.jpeg',
      mealPlan: [
        [
          [
            'eggs and vegetables fried in olive oil, one piece of fruit',
            'chicken salad with olive oil, a handful of nuts',
            'burgers (no bun) fried in butter, vegetables, salsa'
          ],
          [
            'eggs and vegetables fried in olive oil, one piece of fruit',
            'chicken salad with olive oil, a handful of nuts',
            'burgers (no bun) fried in butter, vegetables, salsa'
          ],
          [
            'eggs and vegetables fried in olive oil, one piece of fruit',
            'chicken salad with olive oil, a handful of nuts',
            'burgers (no bun) fried in butter, vegetables, salsa'
          ],
        ],
        [
          [
            'bacon, eggs, one piece of fruit',
            'leftover burgers from the night before',
            'baked salmon with vegetables'
          ],
          [
            'bacon, eggs, one piece of fruit',
            'leftover burgers from the night before',
            'baked salmon with vegetables'
          ],
          [
            'bacon, eggs, one piece of fruit',
            'leftover burgers from the night before',
            'baked salmon with vegetables'
          ],
        ],
        [
          [
            'leftover salmon and vegetables from the night before',
            'sandwich in a lettuce leaf, with meat and fresh vegetables',
            'ground beef stir-fry with vegetables, berries'
          ],
          [
            'leftover salmon and vegetables from the night before',
            'sandwich in a lettuce leaf, with meat and fresh vegetables',
            'ground beef stir-fry with vegetables, berries'
          ],
          [
            'leftover salmon and vegetables from the night before',
            'sandwich in a lettuce leaf, with meat and fresh vegetables',
            'ground beef stir-fry with vegetables, berries'
          ],
        ],
        [
          [
            'eggs, one piece of fruit',
            'leftover stir-fry from the night before, a handful of nuts ',
            'fried pork, vegetables'
          ],
          [
            'eggs, one piece of fruit',
            'leftover stir-fry from the night before, a handful of nuts',
            'fried pork, vegetables'
          ],
          [
            'eggs, one piece of fruit',
            'leftover stir-fry from the night before, a handful of nuts',
            'fried pork, vegetables'
          ],
        ],
        [
          [
            'eggs and vegetables fried in olive oil, one piece of fruit',
            'chicken salad with olive oil, a handful of nuts',
            'steak, vegetables, sweet potatoes'
          ],
          [
            'eggs and vegetables fried in olive oil, one piece of fruit',
            'chicken salad with olive oil, a handful of nuts',
            'steak, vegetables, sweet potatoes'
          ],
          [
            'eggs and vegetables fried in olive oil, one piece of fruit',
            'chicken salad with olive oil, a handful of nuts',
            'steak, vegetables, sweet potatoes'
          ],
        ],
        [
          [
            'bacon, eggs, one piece of fruit',
            'leftover steak and vegetables from the night before',
            'baked tilapia, vegetables, avocado'
          ],
          [
            'bacon, eggs, one piece of fruit',
            'leftover steak and vegetables from the night before',
            'baked tilapia, vegetables, avocado'
          ],
          [
            'bacon, eggs, one piece of fruit',
            'leftover steak and vegetables from the night before',
            'baked tilapia, vegetables, avocado'
          ],
        ],
        [
          [
            'leftover salmon and vegetables from the night before',
            'sandwich in a lettuce leaf, with meat and fresh vegetables',
            'grilled chicken wings, vegetables, salsa'
          ],
          [
            'leftover salmon and vegetables from the night before',
            'sandwich in a lettuce leaf, with meat and fresh vegetables',
            'grilled chicken wings, vegetables, salsa'
          ],
          [
            'leftover salmon and vegetables from the night before',
            'sandwich in a lettuce leaf, with meat and fresh vegetables',
            'grilled chicken wings, vegetables, salsa'
          ],
        ],
      ],
    );

    categories.add(ketoCategory);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 116, 74, 129),
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
          padding: const EdgeInsets.only(left: 18.0, right: 18),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              Category category = categories[index];
              return SingleChildScrollView(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return UserScreen(selectedCategory: category);
                    }));
                  },
                  child: Card(
                    color: const Color.fromARGB(255, 189, 156, 195),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: _buildImage(category.imagePath),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              category.categoryName,
                              style: const TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String imagePath) {
    if (imagePath.startsWith('assets/')) {
      return FadeInImage(
        placeholder: AssetImage('assets/images/27002.jpg'),
        image: AssetImage(imagePath),
        fit: BoxFit.cover,
        height: 130.0,
      );
    } else {
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
        height: 130.0,
      );
    }
  }
}
