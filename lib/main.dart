import 'dart:convert';

import 'package:find_fresh_groceries/models/cart.dart';
import 'package:find_fresh_groceries/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8'
  };

  // Get API data from https://randomuser.me/api/
  var url = Uri.parse('https://randomuser.me/api/');
  var response = await http.get(url, headers: headers);

  WidgetsFlutterBinding.ensureInitialized();

// Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();
  final parsedJson = jsonDecode(response.body);

// Save to local
  await prefs.setInt('status', response.statusCode);
  await prefs.setString('user', jsonEncode(parsedJson['results'][0]));

  // Remove android status bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: const MyApp(),
    ),
  ); // Run the app
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find Fresh Groceries', // Title of the app
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const Wrapper(),
    );
  }
}
