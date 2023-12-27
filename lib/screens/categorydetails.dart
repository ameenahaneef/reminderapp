import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:newproj/screens/dietdetails.dart';
import 'package:newproj/screens/dietedit.dart';
import 'adminmodel.dart'; // Import your Category class

class CategoryDisplay extends StatefulWidget {
  @override
  State<CategoryDisplay> createState() => _CategoryDisplayState();
}

class _CategoryDisplayState extends State<CategoryDisplay> {
  @override
  Widget build(BuildContext context) {
    var categoryBox = Hive.box<Category>('categoryBox');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 127, 65, 138),
        title: Text('Diet Display'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView.builder(
          itemCount: categoryBox.length,
          itemBuilder: (context, index) {
            var category = categoryBox.getAt(index) as Category;

            return Card(
              child: Container(
                width: 200,
                height: 80,
                color: Color.fromARGB(255, 127, 65, 138),
                child: Center(
                  child: ListTile(
                    title: Text(
                      category.categoryName,
                      style: TextStyle(color: Colors.white),
                    ),
                    //subtitle: Text(category.description),
                    leading: ClipOval(
                      child: Image.file(
                        File(category.imagePath),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return DietDetails(category: category);
                      }));
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return DietEdit(selectedCategoryIndex:index ,);
                              }));
                              
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.green,
                            )),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Delete Category'),
                                      content: Text(
                                          'Are you sure you want to delete this category?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            categoryBox.deleteAt(index);
                                            Navigator.of(context).pop();
                                            setState(() {});
                                          },
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
