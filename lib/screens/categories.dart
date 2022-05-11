import 'dart:convert';

import 'package:find_fresh_groceries/models/cart.dart';
import 'package:find_fresh_groceries/models/catalog.dart';
import 'package:find_fresh_groceries/screens/error.dart';
import 'package:find_fresh_groceries/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeCategoriesScreen extends StatefulWidget {
  final String searchString;
  const HomeCategoriesScreen({Key? key, required this.searchString})
      : super(key: key);

  @override
  State<HomeCategoriesScreen> createState() => _HomeCategoriesScreenState();
}

class _HomeCategoriesScreenState extends State<HomeCategoriesScreen> {
  Future<List> getCategories() async {
    // Obtain shared preferences.

    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/data/catalog.json");

    var filteredArray = [];

    var list = json
        .decode(data)['results']
        .map((data) => Catalog.fromJson(data))
        .toList();

    for (var val in list) {
      if (val.name.toLowerCase().contains(widget.searchString.toLowerCase())) {
        //TODO: create better search func
        filteredArray.add(val);
      }
    }

    return filteredArray; // return your response
  }

  List getUniqueTypes(data) {
    var temp = [];

    if (data != null) {
      for (var val in data) {
        temp.add(val.type);
      }
    }
    return temp.toSet().toList(); // Returns unique
  }

  List<Widget> uniqueTabs(uniqueTypes) {
    List<Widget> arr = [];

    for (var val in uniqueTypes) {
      arr.add(
        Tab(
          icon: SizedBox(width: 100, child: Text(val)), //TODO: Style
        ),
      );
    }
    return arr;
  }

  List<Widget> tabBarView(uniqueTypes, data) {
    List<Widget> categoriesArr = []; // Categories array Ex. => Apple, Orange

    for (var uniqueType in uniqueTypes) {
      // Data in the categories Ex. => Sweet Apple Indonesia, Sweet Apple Canada
      List<Widget> categoriesDataArr = [];
      for (var val in data) {
        // print(val.type);
        if (val.type == uniqueType) {
          Catalog catalog = Catalog(
              name: val.name,
              type: val.type,
              price: val.price,
              picture: val.picture,
              rating: val.rating);
          // print(val.name);
          categoriesDataArr.add(
            Container(
                padding: const EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(catalog.name),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {
                        var cart = context.read<CartModel>();
                        cart.add(catalog);
                      },
                      child: const Text('Buy'),
                    )
                  ],
                )), //TODO: Style
          );
        }
      }
      categoriesArr.add(
        Tab(
          icon: Column(children: categoriesDataArr), //TODO: Style
        ),
      );
    }
    return categoriesArr;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: getCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var uniqueTypes = getUniqueTypes(snapshot.data);
            return DefaultTabController(
              length: uniqueTypes.length,
              child: Scaffold(
                appBar: AppBar(
                  toolbarHeight: 0,
                  elevation: 0,
                  backgroundColor: Colors.white,
                  bottom: TabBar(
                    padding: const EdgeInsets.all(0),
                    // labelPadding: const EdgeInsets.all(0),
                    isScrollable: true,
                    indicator: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10), // Creates border
                        color: const Color(Styles.greenMain)),
                    tabs: uniqueTabs(uniqueTypes),
                  ),
                ),
                body: TabBarView(
                  children: tabBarView(uniqueTypes, snapshot.data),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const ErrorScreen();
          } else {
            return const Scaffold(
              body: Center(
                child: Text('Loading...'),
              ),
            );
          }
        });
  }
}
