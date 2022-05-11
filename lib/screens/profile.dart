import 'package:find_fresh_groceries/models/user.dart';
import 'package:find_fresh_groceries/templates/profile_box.dart';
import 'package:find_fresh_groceries/utils/styles.dart';
import 'package:find_fresh_groceries/templates/signature_appbar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final User user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SignatureAppBar(
        title: 'Profile',
      ),
      body: Stack(
        children: [
          Container(
            height: 163,
            color: const Color(Styles.backgroundGrey),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 10),
                ),
                margin: const EdgeInsets.only(top: 60),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(360),
                  child: Image.network(user.pictureLarge,
                      height: 150.0, width: 150.0, fit: BoxFit.fill),
                ),
              ),
              Center(
                  child: Text(
                user.fullName,
                style: Styles.roboto16BoldLowBlack,
              )),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 55),
                  decoration: const BoxDecoration(
                      color: Color(Styles.backgroundGrey),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        topLeft: Radius.circular(40.0),
                      )),
                  child: ListView(
                    padding: const EdgeInsets.only(top: 55),
                    children: [
                      ProfileBoxTemplate(
                          user.userName, 'assets/images/id_icon.png'),
                      ProfileBoxTemplate(
                          user.email, 'assets/images/email_icon.png'),
                      ProfileBoxTemplate(
                          user.phone, 'assets/images/phone_icon.png'),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                              color: const Color(Styles.borderGrey), width: 1),
                        ),
                        margin: const EdgeInsets.fromLTRB(40, 0, 40, 15),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        height: 70,
                        child: Row(
                          children: [
                            ClipRRect(
                              child: Image.asset(
                                  'assets/images/location_icon.png',
                                  height: 30.0,
                                  width: 30.0,
                                  fit: BoxFit.fill),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    user.province,
                                    style: (Styles.roboto14MediumLowBlack),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    user.address,
                                    style: (Styles.roboto14MediumLowBlack),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
