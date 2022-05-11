import 'package:find_fresh_groceries/utils/styles.dart';
import 'package:flutter/material.dart';

// Template for app bar that only have back arrow
class SignatureAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  const SignatureAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: const Color(Styles.greenMain),
        elevation: 0,
        toolbarHeight: 90,
        title: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            title,
            style: Styles.roboto20BoldWhite,
          ),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}
