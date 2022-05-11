import 'dart:convert';

import 'package:find_fresh_groceries/models/cart.dart';
import 'package:find_fresh_groceries/models/transaction.dart';
import 'package:find_fresh_groceries/public/functions.dart';
import 'package:find_fresh_groceries/templates/signature_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/styles.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // app bar
        appBar: const SignatureAppBar(
          title: 'Cart Product',
        ),
        // body
        body: Consumer<CartModel>(
          builder: (context, cart, child) {
            // detail list view of cart
            return ListView(
                padding: const EdgeInsets.fromLTRB(25, 25, 25, 95),
                children: getProductList(cart));
          },
        ),
        // floacting action button
        floatingActionButton: Consumer<CartModel>(
          builder: (context, cart, child) {
            return SizedBox(
              width: MediaQuery.of(context).size.width - 32, // full width
              height: 65,
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: const Color(Styles.greenMain),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  // row. consists of total detail and checkout text
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // row 1: cart total detail
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // column 1: total {x} item
                          Text(
                            'Total ' + cart.countNoMax() + ' Item',
                            style: Styles.roboto16BoldWhite,
                          ),
                          // line
                          Container(
                            margin: const EdgeInsets.all(2),
                            padding: const EdgeInsets.all(0),
                            width: 120,
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: Colors.white,
                            )),
                          ),
                          // total in rupiah
                          Text(
                            'Rp ' + convertDoubleToCurrency(cart.totalPrice()),
                            style: Styles.roboto16BoldWhite,
                          ),
                        ],
                      ),
                      // row 2: checkout text
                      const Text(
                        'Checkout',
                        style: Styles.roboto16BoldWhite,
                      ),
                    ],
                  ),
                ),
                onPressed: () async {
                  // Penyimpanan transaksi produk yang terdapat pada page “cart” dibuat dinamis  dalam local storage.
                  Transaction trx = Transaction(
                      totalPrice: convertDoubleToCurrency(cart.totalPrice()),
                      time: DateTime.now().toString(),
                      trxId: 'trx' +
                          DateTime.now().millisecondsSinceEpoch.toString() +
                          cart.totalPrice().toStringAsFixed(0));

                  // Save to shared
                  List<dynamic> storedArray = [];
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  // Get from shared if exist
                  if (pref.getString('transactions') != null) {
                    var listString = pref.getString('transactions');
                    List<dynamic> list = jsonDecode(listString!);

                    for (var json in list) {
                      storedArray.add(
                          jsonEncode(json)); // Add transactions to stored array
                    }
                  }

                  storedArray.add(
                      jsonEncode(trx.toJson())); // add most recent transaction

                  await pref.setString('transactions',
                      storedArray.toString()); // change to string

                  // success toast
                  Fluttertoast.showToast(
                      msg: "Transaction saved successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey.shade600,
                      textColor: Colors.white,
                      fontSize: 16.0);

                  // clean cart
                  cart.deleteAll();
                },
              ),
            );
          },
        ));
  }

  // widget list of product
  List<Widget> getProductList(cart) {
    List<Widget> productList = [];

    // loop on every categories
    cart.countPerElement().forEach((key, value) {
      // add product on the category
      productList.add(
        // border
        Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border:
                  Border.all(color: const Color(Styles.borderGrey), width: 1),
            ),
            margin: const EdgeInsets.only(top: 10),
            height: 130,
            // column consists of all data
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // column 1: heading row (title and delete)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // row 1: title
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        key.name,
                        style: Styles.roboto16BoldLowBlack,
                      ),
                    ),
                    // row 2: delete
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: IconButton(
                        onPressed: () {
                          cart.deleteElement(key.name);
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.xmark,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                // column 2: datas
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // row 1: image
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(Styles.imgGrey),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                              color: const Color(Styles.borderGrey), width: 1),
                        ),
                        width: 60,
                        height: 60,
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(right: 12),
                        child: Image.network(key.picture,
                            height: 60.0, width: 60.0),
                      ),
                      // row 2: price and rating
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // column 1: price
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4, 6, 4, 6),
                            child: Text(
                              'Rp ' +
                                  convertDoubleToCurrency(
                                      int.parse(key.price)) +
                                  ',-',
                              style: Styles.roboto16MediumLowBlack,
                            ),
                          ),
                          // column 2: rating
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: RatingBarIndicator(
                              rating: double.parse(key.rating),
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: int.parse(key.rating),
                              itemSize: 25.0,
                              direction: Axis.horizontal,
                            ),
                          ),
                        ],
                      ),
                      // column 3: expended make next column right aligned
                      Expanded(child: Container()),
                      // column 4: data manipulation (add and substract)
                      Row(
                        children: [
                          // row 1: substract
                          ElevatedButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    EdgeInsets.zero,
                                  ),
                                  elevation: MaterialStateProperty.all(0),
                                  shadowColor: null,
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(Styles.white)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ))),
                              onPressed: () {
                                // function to substract selected element by 1
                                cart.reduceElement(key);
                              },
                              child: Container(
                                width: 30,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2.0,
                                      color: const Color(Styles.greenMain)),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                ),
                                child: const Center(
                                  child: Text(
                                    '-',
                                    style: Styles.roboto18Medium,
                                  ),
                                ),
                              )),
                          // row 2: qty of product
                          Text(value.toString()),
                          // row 3: add
                          ElevatedButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    EdgeInsets.zero,
                                  ),
                                  elevation: MaterialStateProperty.all(0),
                                  shadowColor: null,
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(Styles.white)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ))),
                              onPressed: () {
                                // function to add
                                cart.add(key);
                              },
                              child: Container(
                                width: 30,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2.0,
                                      color: const Color(Styles.greenMain)),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                ),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 1.0),
                                    child: Text(
                                      '+',
                                      style: Styles.roboto18Medium,
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
      );
    });

    return productList;
  }
}
