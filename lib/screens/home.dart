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

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(35, 88, 35, 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(48),
                    child: Image.network(widget.user.pictureSmall,
                        height: 50.0, width: 50.0, fit: BoxFit.fill),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                      color: const Color(Styles.borderGrey), width: 1),
                ),
                margin: const EdgeInsets.only(top: 60),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      child: Image.asset('assets/images/search_icon.png',
                          height: 40.0, width: 40.0, fit: BoxFit.fill),
                    ),
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
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: const Text(
                    'Categories',
                    style: Styles.roboto14BoldLowBlack,
                  )),
              Expanded(
                  child: HomeCategoriesScreen(
                searchString: _controller.text,
              )),
            ],
          ),
        ),
        floatingActionButton: Consumer<CartModel>(
          builder: (context, cart, child) {
            return FloatingActionButton(
              onPressed: () {},
              child: Text(cart.count()),
            );
          },
        ));
  }
}
