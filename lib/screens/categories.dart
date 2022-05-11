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
        future: getCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var uniqueTypes = getUniqueTypes(snapshot.data);
            return DefaultTabController(
              length: uniqueTypes.length,
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
                  tabs: uniqueTabs(uniqueTypes),
                ),
                body: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: TabBarView(
                    children: tabBarView(uniqueTypes, snapshot.data),
                  ),
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
        // Search
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
      arr.add(Tab(
        text: val,
      ));
    }
    return arr;
  }

  List<Widget> tabBarView(uniqueTypes, data) {
    List<Widget> categoriesArr = []; // Categories array Ex. => Apple, Orange

    for (var uniqueType in uniqueTypes) {
      // Data in the categories Ex. => Sweet Apple Indonesia, Sweet Apple Canada
      List<Widget> categoriesDataArr = [];
      for (var val in data) {
        if (val.type == uniqueType) {
          Catalog catalog = Catalog(
              name: val.name,
              type: val.type,
              price: val.price,
              picture: val.picture,
              rating: val.rating);
          categoriesDataArr.add(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            catalog.name,
                            style: Styles.roboto14Bold,
                          ),
                        ),
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
                    Expanded(child: Container()),
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
                        var cart = context.read<CartModel>();
                        cart.add(catalog);
                      },
                      child: const Text('Buy'),
                    )
                  ],
                )),
          );
        }
      }
      categoriesArr.add(
        Tab(
          icon: ListView(children: categoriesDataArr),
        ),
      );
    }
    return categoriesArr;
  }
}
