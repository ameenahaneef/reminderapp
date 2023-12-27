import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newproj/screens/login.dart';
import 'package:newproj/screens/model.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailidController = TextEditingController();
  final passwordsController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
            ),
            body: Container(
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
              child: Center(
                child: Container(
                  width: 320,
                  height: 400,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(67, 187, 177, 177),
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: _autovalidateMode,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(color: Colors.red),
                                ),
                                labelText: 'Fullname',
                                labelStyle: const TextStyle(color: Colors.white)),
                            style: const TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter your name';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: emailidController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(color: Colors.white)),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:const BorderSide(color: Colors.red),
                              ),
                              labelText: 'Email id',
                              labelStyle: const TextStyle(color: Colors.white),
                            ),
                            style:const TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter your email id';
                              } else if (!RegExp(
                                      r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                                  .hasMatch(value)) {
                                return 'Please enter a valid email id';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: passwordsController,
                            obscureText: true,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                       const BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                      const  BorderSide(color: Colors.white)),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:const BorderSide(color: Colors.red),
                                ),
                                labelText: 'Password',
                                labelStyle:const TextStyle(color: Colors.white)),
                            keyboardType: TextInputType.number,
                            style:const TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter your password';
                              } else if (value.length < 3) {
                                return 'password must be atleast 3 characters';
                              }
                              return null;
                            },
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  backgroundColor:
                                      const Color.fromARGB(0, 90, 88, 88),
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
                                  _storeData();
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (ctx) {
                                    return LoginScreen();
                                  }));
                                }
                              },
                              child: const Text('Create Account')),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )));
  }

  void _storeData() {
    final model = Model(
        name: nameController.text,
        email: emailidController.text,
        password: passwordsController.text);
    final box = Hive.box<Model>('Modelbox');
    box.add(model);
    print('data successfully');
    print('name:${model.name}');
    print('email:${model.email}');
    print('pass:${model.password}');

    nameController.clear();
    emailidController.clear();
    passwordsController.clear();
    setState(() {});
  }
}
