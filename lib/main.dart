import 'package:find_fresh_groceries/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() async {
  // Get API data from https://randomuser.me/api/
  var url = Uri.parse('https://randomuser.me/api/');
  var response = await http.get(url);

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  WidgetsFlutterBinding.ensureInitialized();

  // Remove android status bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

  runApp(const MyApp()); // Run the app
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find Fresh Groceries', // Title of the app
      theme: ThemeData(
        primarySwatch: Colors.lightBlue, // Primary theme color
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const NavBar(),
    );
  }
}
