import 'package:find_fresh_groceries/models/user.dart';
import 'package:find_fresh_groceries/screens/history.dart';
import 'package:find_fresh_groceries/templates/profile_box.dart';
import 'package:find_fresh_groceries/utils/styles.dart';
import 'package:find_fresh_groceries/templates/signature_appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ProfileScreen extends StatelessWidget {
  // parameter to get user
  final User user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // signature app bar with title 'profile'
      appBar: SignatureAppBar(
        title: 'Profile',
        // history action widget
        actionWidget: IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.clockRotateLeft,
            color: Colors.white,
          ),
          onPressed: () {
            // to history page
            pushNewScreen(
              context,
              screen: const HistoryScreen(),
              withNavBar: false, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          },
        ),
      ),
      // creates a stack
      body: Stack(
        children: [
          // stack 1: upper background
          Container(
            height: 163,
            color: const Color(Styles.backgroundGrey),
          ),
          // stack 2: main content
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // column 1: picture
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
              // column 2: name
              Center(
                  child: Text(
                user.fullName,
                style: Styles.roboto16BoldLowBlack,
              )),
              // column 3: user data
              Expanded(
                // background
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
                      // username
                      ProfileBoxTemplate(
                          user.userName, 'assets/images/id_icon.png'),
                      // email
                      ProfileBoxTemplate(
                          user.email, 'assets/images/email_icon.png'),
                      // phone
                      ProfileBoxTemplate(
                          user.phone, 'assets/images/phone_icon.png'),
                      // location
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
