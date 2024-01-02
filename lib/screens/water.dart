import 'package:flutter/material.dart';
import 'package:newproj/screens/navbar.dart';

class WaterScreen extends StatelessWidget {
  const WaterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 116, 74, 129),
          elevation: 0.0,
        ),
        drawer: NavBar(),
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.4, 0.9],
              colors: [
                Color.fromARGB(255, 116, 74, 129),
                Colors.black,
              ],
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Column(
                    children: [
                      Text('')
                    ],
                  )
                ],)
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
