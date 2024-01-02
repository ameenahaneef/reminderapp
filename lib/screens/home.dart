import 'package:flutter/material.dart';
import 'package:newproj/screens/login.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.4, 0.9],
                  colors: [
                    Colors.black,
                    Color.fromARGB(255, 116, 74, 129),
                  ],
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage(
                            'assets/images/29013775_7450359 (1).png'),
                        width: 300,
                        height: 300,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: 320,
                        height: 150,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          color: Color.fromARGB(91, 104, 102, 102),
                          child: const Center(
                            child: Text(
                              'Prioritize your health journney with mindful reminders.Embrace each day as an oppurtunity to make positive choices for your well-being.Your wellness,Your way',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              backgroundColor: Colors.transparent,
                              padding: EdgeInsets.only(
                                  top: 15, bottom: 10, left: 30, right: 30)),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) {
                              return LoginScreen();
                            }));
                          },
                          child: Text('Get Started'))
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
