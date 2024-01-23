import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newproj/main.dart';
import 'package:newproj/screens/admin.dart';
import 'package:newproj/screens/mainhome.dart';
import 'package:newproj/screens/model.dart';
import 'package:newproj/screens/sign.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              children: [
                const Image(
                  image: AssetImage('assets/images/Well Alert.png'),
                  width: 120,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _autovalidateMode,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: Colors.white)),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                  labelText: 'Email id',
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  )),
                              style: const TextStyle(color: Colors.white),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please enter your email id';
                                } else if (!RegExp(
                                        r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                                    .hasMatch(value)) {}
                                return null;
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                labelText: 'Password',
                                labelStyle: TextStyle(color: Colors.white),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                )),
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.white),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter your password';
                              } else if (value.length < 3) {
                                return 'password must be at least 3 characters ';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  backgroundColor: Colors.transparent,
                                  padding: const EdgeInsets.only(
                                      top: 15,
                                      bottom: 10,
                                      left: 30,
                                      right: 30)),
                              onPressed: () {
                                setState(() {
                                  _autovalidateMode = AutovalidateMode.always;
                                });
                                if (_formKey.currentState!.validate()) {
                                  _loginUser();
                                }
                                emailController.clear();
                                passwordController.clear();
                              },
                              child: const Text('Login')),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Dont have any account?',
                                style: TextStyle(color: Colors.white),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) {
                                        return const SignupScreen();
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(color: Colors.amber),
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return AdminScreen();
                                }));
                              },
                              child: const Text(
                                'Admin',
                                style: TextStyle(color: Colors.amber),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                const Image(
                    image: AssetImage('assets/images/gggg.png'), width: 200)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loginUser() async {
    final String email = emailController.text;
    final String password = passwordController.text;
    final Box box = Hive.box<Model>('Modelbox');

    final existingUser = box.values.any(
      (user) => user.email == email && user.password == password,
    );

    if (existingUser) {
      final SharedPreferences _sharedPrefs =
          await SharedPreferences.getInstance();
      _sharedPrefs.setBool(saveKeyName, true);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) =>  MainHome()),
      );
    } else {
      _showErrorSnackBar();
      print('Authentication failed. Invalid email or password.');
    }
  }

  void _showErrorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Login failed.Invalid email or Password.Please try again'),
    ));
  }
}
