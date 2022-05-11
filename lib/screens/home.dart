import 'package:find_fresh_groceries/models/cart.dart';
import 'package:find_fresh_groceries/models/user.dart';
import 'package:find_fresh_groceries/screens/categories.dart';
import 'package:find_fresh_groceries/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _controller;

// Init State
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

// Dispose
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(
              35, 88, 35, 35), // Padding of the whole screen
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First column: title and picture
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // First row: title
                  RichText(
                    text: const TextSpan(
                      style: Styles.roboto24Green,
                      children: <TextSpan>[
                        TextSpan(text: 'Find '),
                        TextSpan(
                          text: 'Fresh Groceries',
                          style: Styles.roboto24Yellow,
                        )
                      ],
                    ),
                  ),
                  // Second row: picture
                  ClipRRect(
                    borderRadius: BorderRadius.circular(48),
                    child: Image.network(widget.user.pictureSmall,
                        height: 50.0, width: 50.0, fit: BoxFit.fill),
                  )
                ],
              ),
              // Second column: Search bar
              Container(
                // Search box
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                      color: const Color(Styles.borderGrey), width: 1),
                ),
                margin: const EdgeInsets.only(top: 50),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // search icon
                    ClipRRect(
                      child: Image.asset('assets/images/search_icon.png',
                          height: 40.0, width: 40.0, fit: BoxFit.fill),
                    ),
                    // search field
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration.collapsed(
                            hintText: 'Search Groceries',
                            hintStyle: Styles.hintText),
                        onSubmitted: (String value) {
                          setState(() {
                            // Call setState to refresh the page.
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Third column: 'Categories' text
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: const Text(
                    'Categories',
                    style: Styles.roboto14BoldLowBlack,
                  )),
              // Forth column: HomeCategoriesScreen (consists of catalog categories and data)
              Expanded(
                  child: HomeCategoriesScreen(
                searchString: _controller.text,
              )),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation
            .centerFloat, // Center floating action button
        floatingActionButton: Consumer<CartModel>(
          // Builder to receive cart class
          builder: (context, cart, child) {
            // Floating action button
            return FloatingActionButton.extended(
              heroTag: "btn2",
              elevation: 0,
              backgroundColor: const Color(Styles.greenMain),
              onPressed: () {},
              label: Text('Total in cart: ' +
                  cart.countWithMax()), // Get count in cart with max value of 99 (text changes to 99+ if > 99)
            );
          },
        ));
  }
}
