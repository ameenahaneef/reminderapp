import 'package:flutter/material.dart';
import 'package:newproj/main.dart';
import 'package:newproj/screens/aboutapp.dart';
import 'package:newproj/screens/login.dart';
import 'package:newproj/screens/mainhome.dart';
import 'package:newproj/screens/privacy.dart';
import 'package:newproj/screens/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 50, 1, 61),
            ),
            child: FutureBuilder(
              future: _getUserName(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        snapshot.data!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return MainHome();
              }));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Medicine History'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return ProfileScreen();
              }));
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline_rounded),
            title: const Text('About'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return AboutUs();
              }));
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy Policy'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return const PrivacyPolicy();
              }));
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share'),
            onTap: () {
              Share.share('text');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('cancel')),
                        TextButton(
                            onPressed: () {
                              logout();

                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (ctx) {
                                return LoginScreen();
                              }), (route) => false);
                            },
                            child: const Text('Ok'))
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }

  Future<void> logout() async {
    final SharedPreferences _sharedPrefs =
        await SharedPreferences.getInstance();
    await _sharedPrefs.setBool(saveKeyName, false);
    await _sharedPrefs.remove('username');
    print('User logged out');
  }

  Future<String> _getUserName() async {
    final SharedPreferences _sharedPrefs =
        await SharedPreferences.getInstance();
    return _sharedPrefs.getString('userName') ?? '';
  }
}
