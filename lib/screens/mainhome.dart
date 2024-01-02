import 'package:flutter/material.dart';
import 'package:newproj/screens/diet.dart';
import 'package:newproj/screens/navbar.dart';
import 'package:newproj/screens/med.dart';
import 'package:newproj/screens/water.dart';

class MainHome extends StatelessWidget {
  const MainHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
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
              Color.fromARGB(255, 10, 9, 9),
              Color.fromARGB(255, 116, 74, 129),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Worry Less\nLive Healthier',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) {
                          return Medicine();
                        },
                      ),
                    );
                  },
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      // width: 320,
                      // height: 150,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(86, 0, 0, 0),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50))),
                      child: const Column(
                        children: [
                          Align(
                              alignment: Alignment.topCenter,
                              child: Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/[removal.ai]_22809c63-fbeb-4910-a3c2-7bd80fe847aa-m028t0135_e_medical_icon_24aug22 (1).png'),
                                    width: 120,
                                    height: 120,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 20.0),
                                    child: Text(
                                      'Dont forget to take\nyour medication at the\nprescribed time to maintain\nconsistent treatment',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return WaterScreen();
                    }));
                  },
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      // width: 150,
                      // height: 150,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(86, 0, 0, 0),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50))),
                      child: const Column(
                        children: [
                          Align(
                              alignment: Alignment.topCenter,
                              child: Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/images/Water (1).png'),
                                    width: 120,
                                    height: 120,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 16),
                                    child: Text(
                                      'Remember to sip water\nthroughout the day\nto keep your body and mind \nrefreshed.',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return DietScreen();
                    }));
                  },
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      // width: 150,
                      // height: 150,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(86, 0, 0, 0),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50))),
                      child: const Column(
                        children: [
                          Align(
                              alignment: Alignment.topCenter,
                              child: Row(
                                children: [
                                  Image(
                                    image:
                                        AssetImage('assets/images/Plate.png'),
                                    width: 120,
                                    height: 120,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 18.0),
                                    child: Text(
                                      'Fuel your body with\nnutritious choices.\nYour health is your wealth!',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              )),
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
    ));
  }
}
