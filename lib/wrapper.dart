import 'package:find_fresh_groceries/nav_bar.dart';
import 'package:find_fresh_groceries/screens/error.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkData(),
        builder: (context, data) {
          if (data.data == 200) {
            // If Success
            return const NavBar();
          } else {
            // If failed
            return const ErrorScreen();
          }
        });
  }
}

checkData() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('status');
}
