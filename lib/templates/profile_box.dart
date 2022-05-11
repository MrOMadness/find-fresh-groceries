// ignore_for_file: must_be_immutable

import 'package:find_fresh_groceries/utils/styles.dart';
import 'package:flutter/material.dart';

class ProfileBoxTemplate extends StatelessWidget {
  String imagePath;
  String text;

  ProfileBoxTemplate(this.text, this.imagePath, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: const Color(Styles.borderGrey), width: 1),
      ),
      margin: const EdgeInsets.fromLTRB(40, 0, 40, 15),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 50,
      child: Row(
        children: [
          ClipRRect(
            child: Image.asset(imagePath,
                height: 30.0, width: 30.0, fit: BoxFit.fill),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              text,
              style: (Styles.roboto14MediumLowBlack),
            ),
          )
        ],
      ),
    );
  }
}
