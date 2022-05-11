import 'dart:convert';

import 'package:find_fresh_groceries/models/cart.dart';
import 'package:find_fresh_groceries/models/transaction.dart';
import 'package:find_fresh_groceries/public/functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Widget> getProductList(cart) {
    List<Widget> productList = [];

    cart.countPerElement().forEach((key, value) {
      productList.add(Row(
        children: [
          Text(key.name + '  '),
          Text(value.toString()),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () {
              //TODO
              cart.reduceElement(key);
            },
            child: const Text('-'),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () {
              //TODO
              cart.add(key);
            },
            child: const Text('+'),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () {
              //TODO
              cart.deleteElement(key.name);
            },
            child: const Text('x'),
          )
        ],
      ));
    });

    return productList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cart Product"),
        ),
        body: Consumer<CartModel>(
          builder: (context, cart, child) {
            return ListView(children: getProductList(cart));
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
}
