import 'package:find_fresh_groceries/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          print(cart.items);
          return ListView(children: getProductList(cart));
        },
      ),
    );
  }
}
