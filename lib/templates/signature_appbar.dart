import 'package:find_fresh_groceries/utils/styles.dart';
import 'package:flutter/material.dart';

// Template for app bar that only have back arrow
class SignatureAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final Widget actionWidget;
  const SignatureAppBar(
      {Key? key,
      required this.title,
      this.actionWidget = const SizedBox.shrink()}) // empty widget
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(Styles.greenMain),
      elevation: 0, // elevation
      toolbarHeight: 90, // height
      // title
      title: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Text(
          title,
          style: Styles.roboto20BoldWhite,
        ),
      ),
      // action widget
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: actionWidget,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90); // height
}
