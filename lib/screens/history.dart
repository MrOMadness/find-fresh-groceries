// Halaman ini digunakan untuk mengecek local storage pada ketentuan
// - Penyimpanan transaksi produk yang terdapat pada page “cart” dibuat dinamis  dalam local storage.

import 'package:find_fresh_groceries/screens/error.dart';
import 'package:find_fresh_groceries/templates/signature_appbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SignatureAppBar(title: 'History'),
      body: FutureBuilder<String?>(
          future: getHistory(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // Make scrollable
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                    margin: const EdgeInsets.all(12),
                    child: Text(snapshot.data!)),
              );
              // if error
            } else if (snapshot.hasError) {
              return const ErrorScreen();
              // if no data
            } else {
              return const Scaffold(
                body: Center(
                  child: Text('Loading...'),
                ),
              );
            }
          }),
    );
  }

  Future<String?> getHistory() async {
    // get pref
    SharedPreferences pref = await SharedPreferences.getInstance();
    // get transaction history
    var historyString = pref.getString('transactions'); // change to string
    return historyString;
  }
}
