import 'dart:convert';

import 'package:find_fresh_groceries/models/cart.dart';
import 'package:find_fresh_groceries/models/transaction.dart';
import 'package:find_fresh_groceries/public/functions.dart';
import 'package:find_fresh_groceries/templates/signature_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
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
        appBar: const SignatureAppBar(
          title: 'Cart Product',
        ),
        body: Consumer<CartModel>(
          builder: (context, cart, child) {
            return ListView(
                padding: const EdgeInsets.fromLTRB(
                    25, 25, 25, 100), // TODO: Ganti botom
                children: getProductList(cart));
          },
        ),
        floatingActionButton: Consumer<CartModel>(
          builder: (context, cart, child) {
            return FloatingActionButton(
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
                SharedPreferences pref = await SharedPreferences.getInstance();

                if (pref.getString('transactions') != null) {
                  // Get from shared
                  var listString = pref.getString('transactions');
                  List<dynamic> list = jsonDecode(listString!);

                  for (var json in list) {
                    storedArray.add(
                        jsonEncode(json)); // Add transactions to stored array
                  }
                }

                storedArray.add(
                    jsonEncode(trx.toJson())); // add most recent transaction

                await pref.setString(
                    'transactions', storedArray.toString()); // change to string
              },
              child: Text(convertDoubleToCurrency(cart.totalPrice())),
            );
          },
        ));
  }

  List<Widget> getProductList(cart) {
    List<Widget> productList = [];

    cart.countPerElement().forEach((key, value) {
      productList.add(
        Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border:
                  Border.all(color: const Color(Styles.borderGrey), width: 1),
            ),
            margin: const EdgeInsets.only(top: 10),
            height: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        key.name,
                        style: Styles.roboto16BoldLowBlack,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        cart.deleteElement(key.name);
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.xmark,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                        width: 60,
                        height: 60,
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(right: 12),
                        child: Image.network(key.picture,
                            height: 60.0, width: 60.0),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4, 6, 4, 6),
                            child: Text(
                              'Rp ' +
                                  NumberFormat("###,###", "tr_TR")
                                      .format(int.parse(key.price)) +
                                  ',-',
                              style: Styles.roboto16MediumLowBlack,
                            ),
                          ),
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
                      Expanded(child: Container()),
                      Row(
                        children: [
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
                                    style: Styles.roboto18Bold,
                                  ),
                                ),
                              )),
                          Text(value.toString()),
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
                                  child: Text(
                                    '+',
                                    style: Styles.roboto18Bold,
                                  ),
                                ),
                              )),
                        ],
                      ),
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                      //   children: [
                      //     IconButton(
                      //       onPressed: () {
                      //         cart.deleteElement(key.name);
                      //       },
                      //       icon: const FaIcon(
                      //         FontAwesomeIcons.xmark,
                      //         color: Colors.red,
                      //       ),
                      //     ),
                      //     Row(
                      //       children: [
                      //         IconButton(
                      //           onPressed: () {
                      //             cart.deleteElement(key.name);
                      //           },
                      //           icon: const FaIcon(
                      //             FontAwesomeIcons.xmark,
                      //             color: Colors.red,
                      //           ),
                      //         ),
                      //         IconButton(
                      //           onPressed: () {
                      //             cart.deleteElement(key.name);
                      //           },
                      //           icon: const FaIcon(
                      //             FontAwesomeIcons.xmark,
                      //             color: Colors.red,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                ),
              ],
            )),
        //   Row(
        //   children: [
        //     Text(key.name + '  '),
        //     Text(value.toString()),
        //     TextButton(
        //       style: ButtonStyle(
        //         foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        //       ),
        //       onPressed: () {
        //         //TODO
        //         cart.reduceElement(key);
        //       },
        //       child: const Text('-'),
        //     ),
        //     TextButton(
        //       style: ButtonStyle(
        //         foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        //       ),
        //       onPressed: () {
        //         //TODO
        //         cart.add(key);
        //       },
        //       child: const Text('+'),
        //     ),
        //     TextButton(
        //       style: ButtonStyle(
        //         foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        //       ),
        //       onPressed: () {
        //         //TODO
        //         cart.deleteElement(key.name);
        //       },
        //       child: const Text('x'),
        //     )
        //   ],
        // )
      );
    });

    return productList;
  }
}
