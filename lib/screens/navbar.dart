import 'package:flutter/material.dart';
import 'package:newproj/main.dart';
import 'package:newproj/screens/aboutapp.dart';
import 'package:newproj/screens/login.dart';
import 'package:newproj/screens/mainhome.dart';
import 'package:newproj/screens/privacy.dart';
import 'package:newproj/screens/profile.dart';
//import 'package:rxdart/rxdart.dart';
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
            leading: Icon(Icons.info_outline_rounded),
            title: Text('About'),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                return AboutUs();
              }));
            },

          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy Policy'),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                return PrivacyPolicy();
              }));
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
            onTap: (){
              Share.share('text');
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
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('cancel')),
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
    await _sharedPrefs.setBool(saveKeyName, false);
    print('User logged out');
  }
}
