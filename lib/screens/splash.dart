import 'package:flutter/material.dart';
import 'package:newproj/main.dart';
import 'package:newproj/screens/home.dart';
import 'package:newproj/screens/mainhome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkUserLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              width: 120,
              height: 120,
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
              child: const Center(
                child: Image(
                  image: AssetImage('assets/images/Well Alert.png'),
                  width: 120,
                  height: 120,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> gotoLogin() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
      return HomeScreen();
    }));
  }

  Future<void> checkUserLoggedIn() async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    final _userLoggedIn = _sharedPrefs.getBool(saveKeyName);
    if (_userLoggedIn == null || _userLoggedIn == false) {
      gotoLogin();
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx1) {
        return MainHome();
      }));
    }
  }
}
