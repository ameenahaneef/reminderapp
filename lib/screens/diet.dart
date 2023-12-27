import 'package:flutter/material.dart';
import 'package:newproj/screens/navbar.dart';

class DietScreen extends StatelessWidget {
  const DietScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        ));
  }
}
