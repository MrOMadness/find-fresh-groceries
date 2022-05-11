// HomeCategoriesScreen (consists of catalog categories and data)
import 'dart:convert';

import 'package:find_fresh_groceries/models/cart.dart';
import 'package:find_fresh_groceries/models/catalog.dart';
import 'package:find_fresh_groceries/public/functions.dart';
import 'package:find_fresh_groceries/screens/error.dart';
import 'package:find_fresh_groceries/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class HomeCategoriesScreen extends StatefulWidget {
  // Parameter
  final String searchString;
  const HomeCategoriesScreen({Key? key, required this.searchString})
      : super(key: key);

  @override
  State<HomeCategoriesScreen> createState() => _HomeCategoriesScreenState();
}

class _HomeCategoriesScreenState extends State<HomeCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future:
            getCategories(), // Function to get categories. will return list category of all data (ex. apple, apple, banana, orange)
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // If data exists
            var uniqueTypes = getUniqueTypes(snapshot
                .data); // get unique category data (ex. apple, apple, banana => apple, banana)
            return DefaultTabController(
              length: uniqueTypes.length, // length of the unique category
              child: Scaffold(
                appBar: TabBar(
                  padding: const EdgeInsets.all(0),
                  isScrollable: true,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), // Creates border
                      color: const Color(Styles.greenMain)),
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.white,
                  labelStyle: Styles.roboto14Bold,
                  tabs: uniqueTabs(uniqueTypes), // unique category data
                ),
                body: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: TabBarView(
                    children: tabBarView(
                        uniqueTypes,
                        snapshot
                            .data), // Tab bar view. consists of the data in each category
                  ),
                ),
              ),
            );
            // If there is error
          } else if (snapshot.hasError) {
            return const ErrorScreen();
            // If dont have data
          } else {
            return const Scaffold(
              body: Center(
                child: Text('Loading...'),
              ),
            );
          }
        });
  }

  Future<List> getCategories() async {
    // Obtain shared preferences.

    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/data/catalog.json");

    var filteredArray = [];

    // Deocde to list
    var list = json
        .decode(data)['results']
        .map((data) => Catalog.fromJson(data))
        .toList();

    for (var val in list) {
      // Search algoritm
      if (val.name.toLowerCase().contains(widget.searchString.toLowerCase())) {
        filteredArray.add(val);
      }
    }

    return filteredArray;
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

  // widget list of tab with unique category data
  List<Widget> uniqueTabs(uniqueTypes) {
    List<Widget> arr = [];

    for (var val in uniqueTypes) {
      arr.add(Tab(
        text: val,
      ));
    }
    return arr;
  }

  // widget list of tabbarview
  List<Widget> tabBarView(uniqueTypes, data) {
    List<Widget> categoriesArr = []; // Categories array Ex. => Apple, Orange

    for (var uniqueType in uniqueTypes) {
      // Data in the categories Ex. => Sweet Apple Indonesia, Sweet Apple Canada
      List<Widget> categoriesDataArr = [];
      for (var val in data) {
        // if data category is the same with tab category
        if (val.type == uniqueType) {
          // create catalog class
          Catalog catalog = Catalog(
              name: val.name,
              type: val.type,
              price: val.price,
              picture: val.picture,
              rating: val.rating);
          // add to categoriesDataArr
          categoriesDataArr.add(
            // outer box
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                      color: const Color(Styles.borderGrey), width: 1),
                ),
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(12),
                height: 105,
                // Row inside of the box
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Row 1. Picture
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(Styles.imgGrey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                            color: const Color(Styles.borderGrey), width: 1),
                      ),
                      width: 80,
                      height: 80,
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(right: 12),
                      child: Image.network(catalog.picture,
                          height: 60.0, width: 60.0),
                    ),
                    // Row 2. name, price, rating
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // column 1. name
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            catalog.name,
                            style: Styles.roboto14Bold,
                          ),
                        ),
                        // column 2. price
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            'Rp ' +
                                convertDoubleToCurrency(
                                    int.parse(catalog.price)) +
                                '/kg',
                            style: Styles.roboto16BoldLowBlack,
                          ),
                        ),
                        // column 3. rating
                        RatingBarIndicator(
                          rating: double.parse(catalog.rating),
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: int.parse(catalog.rating),
                          itemSize: 25.0,
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                    // Row 3. expanded container to make the next row become right aligned
                    Expanded(child: Container()),
                    // row 4. buy button
                    ElevatedButton(
                      style: ButtonStyle(
                          elevation: null,
                          shadowColor: null,
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(Styles.greenMain)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ))),
                      onPressed: () {
                        // get cart
                        var cart = context.read<CartModel>();
                        // add catalog
                        cart.add(catalog);
                      },
                      child: const Text('Buy'),
                    )
                  ],
                )),
          );
        }
      }
      // the parent of categoriesDataArr
      categoriesArr.add(
        Tab(
          icon: ListView(children: categoriesDataArr),
        ),
      );
    }
    return categoriesArr;
  }
}
