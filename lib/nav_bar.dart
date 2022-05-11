import 'dart:convert';

import 'package:find_fresh_groceries/models/user.dart';
import 'package:find_fresh_groceries/screens/cart.dart';
import 'package:find_fresh_groceries/screens/error.dart';
import 'package:find_fresh_groceries/screens/home.dart';
import 'package:find_fresh_groceries/screens/profile.dart';
import 'package:find_fresh_groceries/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final _controller = PersistentTabController(initialIndex: 0);

  double iconSize = 20; // Icon Size
  static const activeColorPrimary = Color(Styles.greenBotNav);
  static const inactiveColorPrimary = Colors.black;

  List<Widget> _buildScreens(user) {
    return [
      HomeScreen(user: user),
      const CartScreen(),
      ProfileScreen(user: user)
    ]; // Screens
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset('assets/images/home_icon.png'),
        iconSize: iconSize,
        title: ("Home"),
        textStyle: Styles.roboto10Bold,
        activeColorPrimary: activeColorPrimary,
        inactiveColorPrimary: inactiveColorPrimary,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset('assets/images/cart_icon.png'),
        iconSize: iconSize,
        title: ("Cart"),
        textStyle: Styles.roboto10Bold,
        activeColorPrimary: activeColorPrimary,
        inactiveColorPrimary: inactiveColorPrimary,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset('assets/images/profile_icon.png'),
        iconSize: iconSize,
        title: ("Profile"),
        textStyle: Styles.roboto10Bold,
        activeColorPrimary: activeColorPrimary,
        inactiveColorPrimary: inactiveColorPrimary,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Future<User> getUser() async {
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      var jsonString = prefs.getString('user');
      var list = json.decode(jsonString!);
      User user = User(
          fullName: '${list['name']['first']} ${list['name']['last']}',
          userName: list['login']['username'],
          email: list['email'],
          phone: list['phone'],
          pictureSmall: list['picture']['thumbnail'],
          pictureLarge: list['picture']['large'],
          address:
              '${list['location']['city']} - ${list['location']['postcode']}',
          province: list['location']['state']);
      return user;
    }

    return FutureBuilder<Object>(
        future: getUser(),
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData) {
            return PersistentTabView(
              context,
              navBarHeight: 65,
              controller: _controller,
              screens: _buildScreens(userSnapshot.data),
              items: _navBarsItems(),
              confineInSafeArea: true,
              backgroundColor: Colors.white, // Default is Colors.white.
              handleAndroidBackButtonPress: true, // Default is true.
              resizeToAvoidBottomInset:
                  false, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
              stateManagement: true, // Default is true.
              hideNavigationBarWhenKeyboardShows:
                  true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
              decoration: const NavBarDecoration(
                border: Border(
                  top: BorderSide(width: 1.0, color: Color(0xFFDFDFDF)),
                ),
                colorBehindNavBar: Colors.white,
              ),
              popAllScreensOnTapOfSelectedTab: true,
              popActionScreens: PopActionScreensType.all,
              itemAnimationProperties: const ItemAnimationProperties(
                // Navigation Bar's items animation properties.
                duration: Duration(milliseconds: 200),
                curve: Curves.ease,
              ),
              screenTransitionAnimation: const ScreenTransitionAnimation(
                // Screen transition animation on change of selected tab.
                animateTabTransition: true,
                curve: Curves.ease,
                duration: Duration(milliseconds: 200),
              ),
              navBarStyle: NavBarStyle
                  .style14, // Choose the nav bar style with this property.
            );
          } else if (userSnapshot.hasError) {
            return const ErrorScreen();
          } else {
            return const Scaffold(
              body: Center(
                child: Text('Loading...'),
              ),
            );
          }
        });
  }
}
