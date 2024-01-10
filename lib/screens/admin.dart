import 'package:flutter/material.dart';
import 'package:newproj/screens/adminadd.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final usernameController = TextEditingController();
  final passController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(40.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white)),
                labelText: 'Username',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter username';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white)),
                labelText: 'Password',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    login(context);
                    usernameController.clear();
                    passController.clear();
                  }
                },
                child: const Text('Login'))
          ],
        ),
      ),
    ));
  }

  void login(BuildContext ctx) async {
    final predefinedUsername = 'admin';
    final predefinedPassword = '1234';
    if (usernameController.text.trim() == predefinedUsername &&
        passController.text.trim() == predefinedPassword) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
        return AdminAdd();
      }));
    } else {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('error'),
              content: const Text('invalid username and password'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('ok'))
              ],
            );
          });
    }
  }
}
