import 'package:find_fresh_groceries/models/cart.dart';
import 'package:find_fresh_groceries/screens/cart.dart';
import 'package:find_fresh_groceries/screens/home.dart';
import 'package:find_fresh_groceries/screens/profile.dart';
import 'package:find_fresh_groceries/styles.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

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

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const CartScreen(),
      const ProfileScreen()
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
    return Scaffold(
        body: PersistentTabView(
          context,
          navBarHeight: 65,
          controller: _controller,
          screens: _buildScreens(),
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
        ),
        floatingActionButton: Consumer<CartModel>(
          builder: (context, cart, child) {
            print(cart.items);
            return FloatingActionButton(onPressed: () {});
          },
        ));
  }
}
