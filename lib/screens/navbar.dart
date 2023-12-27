import 'package:flutter/material.dart';
import 'package:newproj/main.dart';
import 'package:newproj/screens/login.dart';
import 'package:newproj/screens/mainhome.dart';
import 'package:newproj/screens/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 50, 1, 61),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                Text(
                  'Ameena',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return MainHome();
              }));
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return ProfileScreen();
              }));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Logout'),
                      content: Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(onPressed: () {Navigator.of(context).pop();}, child: Text('cancel')),
                        TextButton(
                            onPressed: () {
                              logout();
                            
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (ctx) {
                                return LoginScreen();
                              }), (route) => false);
                            },
                            child: Text('Ok'))
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
    await _sharedPrefs.setBool(SAVE_KEY_NAME, false);
    print('User logged out');
  }
}
